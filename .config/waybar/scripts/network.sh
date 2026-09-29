#!/usr/bin/env bash
# Single network module: wifi/ethernet icon + no-internet detection + live bandwidth.
# Output (one line per second): waybar JSON {text, tooltip, class}

ICONS_WIFI=("󰤯" "󰤟" "󰤢" "󰤥" "󰤨")
ICON_ETH="󰀂"
ICON_NOINET="󰌙"
ICON_DISC="󰖪"
INET=/tmp/waybar-inet-$UID
INET_EVERY=5   # seconds between internet checks

# State shared between functions.
iface=""       # primary (first up default-route) interface
ups=()         # every up default-route interface
ip4=""
bw=""
prev_key=""; prev_rx=0; prev_tx=0; prev_ts=0

json() { printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$1" "$2" "$3"; }

# Center lines (args) to widest line, monospace via <tt>.
center() {
    local max=0 l out=""
    for l in "$@"; do (( ${#l} > max )) && max=${#l}; done
    for l in "$@"; do
        [[ -z "$l" ]] && continue
        local pad=$(( (max - ${#l}) / 2 ))
        out+="$(printf '%*s%s' "$pad" '' "$l")\\n"
    done
    printf '<tt>%s</tt>' "${out%\\n}"
}

human() {
    awk -v b="$1" 'BEGIN{ if(b>=1048576) printf "%.1f MB/s",b/1048576; else if(b>=1024) printf "%.0f kB/s",b/1024; else printf "%d B/s",b }'
}

# Ping two servers in parallel; offline only if both fail. Result in $INET.
check_inet() {
    ping -c1 -W2 1.1.1.1 >/dev/null 2>&1 & local p1=$!
    ping -c1 -W2 8.8.8.8 >/dev/null 2>&1 & local p2=$!
    if ! wait "$p1" && ! wait "$p2"; then echo 0 > "$INET"; else echo 1 > "$INET"; fi
}

# Run the check in background every INET_EVERY ticks so the 1s loop stays accurate.
maybe_check_inet() {
    (( $1 % INET_EVERY == 0 )) && { check_inet & }
}

has_internet() { [[ "$(<"$INET")" != "0" ]]; }

# Fill $iface and $ups. Primary = first default-route iface with carrier up.
# Bandwidth sums every up iface: with wifi+ethernet both up, replies can
# arrive on a different iface than the one picked.
detect_ifaces() {
    local i
    iface=""; ups=()
    for i in $(ip -o route show default | awk '{print $5}'); do
        [[ "$(cat /sys/class/net/"$i"/operstate 2>/dev/null)" == "up" ]] || continue
        [[ -z "$iface" ]] && iface=$i
        [[ " ${ups[*]} " == *" $i "* ]] || ups+=("$i")
    done
}

get_ip4() { ip -4 -o addr show dev "$1" | awk '{print $4}' | head -1; }

is_wireless() { [[ -d "/sys/class/net/$1/wireless" ]]; }

wifi_ssid() {
    iwctl station "$1" show 2>/dev/null | awk -F'network' '/Connected network/{gsub(/^ +| +$/,"",$2); print $2}'
}

# Wifi icon index (0-4) from /proc/net/wireless link quality (0-70).
wifi_icon_index() {
    local q idx
    q=$(awk -v i="$1:" '$1==i{gsub(/\./,"",$3); print $3}' /proc/net/wireless)
    idx=$(( ${q:-0} * 5 / 71 )); (( idx > 4 )) && idx=4
    echo "$idx"
}

# Sum rx/tx bytes over $ups into $rx / $tx.
read_counters() {
    local i
    rx=0; tx=0
    for i in "${ups[@]}"; do
        rx=$(( rx + $(<"/sys/class/net/$i/statistics/rx_bytes") ))
        tx=$(( tx + $(<"/sys/class/net/$i/statistics/tx_bytes") ))
    done
}

# Bandwidth string: delta since last sample, microsecond clock.
sample_bandwidth() {
    local rx tx now key="${ups[*]}" dt r t
    read_counters
    now=${EPOCHREALTIME/[.,]/}   # locale may use ',' as decimal separator
    bw="⇣0 B/s  ⇡0 B/s"
    if [[ "$key" == "$prev_key" ]] && (( now > prev_ts )); then
        dt=$(( now - prev_ts ))
        r=$(( (rx - prev_rx) * 1000000 / dt )); t=$(( (tx - prev_tx) * 1000000 / dt ))
        (( r < 0 )) && r=0; (( t < 0 )) && t=0
        bw="⇣$(human "$r")  ⇡$(human "$t")"
    fi
    prev_key=$key; prev_rx=$rx; prev_tx=$tx; prev_ts=$now
}

emit_disconnected() {
    json "$ICON_DISC" "Disconnected" "disconnected"
    prev_key=""
}

emit_noinet() {
    json "$ICON_NOINET" "$(center "Sem internet" "$iface $ip4" "$bw")" "noinet"
}

emit_wifi() {
    local icon ssid
    icon=${ICONS_WIFI[$(wifi_icon_index "$iface")]}
    ssid=$(wifi_ssid "$iface")
    json "$icon" "$(center "$icon ${ssid:-$iface}" "$ip4" "$bw")" "wifi"
}

emit_ethernet() {
    json "$ICON_ETH" "$(center "$ICON_ETH  $iface" "$ip4" "$bw")" "ethernet"
}

emit_status() {
    if ! has_internet; then emit_noinet
    elif is_wireless "$iface"; then emit_wifi
    else emit_ethernet
    fi
}

main() {
    local n=0
    echo 1 > "$INET"
    while :; do
        maybe_check_inet "$n"; n=$((n + 1))
        detect_ifaces
        if [[ -z "$iface" ]]; then
            emit_disconnected
        else
            ip4=$(get_ip4 "$iface")
            sample_bandwidth
            emit_status
        fi
        sleep 1
    done
}

main

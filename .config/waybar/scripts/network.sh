#!/usr/bin/env bash
# Single network module: wifi/ethernet icon + no-internet detection.
# Output: waybar JSON {text, tooltip, class}

ICONS_WIFI=("󰤯" "󰤟" "󰤢" "󰤥" "󰤨")
ICON_ETH="󰀂"
ICON_NOINET="󰌙"
ICON_DISC="󰖪"
STATE=/tmp/waybar-net-$UID

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

# Pick first default-route interface whose carrier is actually up.
iface=""
for i in $(ip -o route show default | awk '{print $5}'); do
    [[ "$(cat /sys/class/net/"$i"/operstate 2>/dev/null)" == "up" ]] && { iface=$i; break; }
done

if [[ -z "$iface" ]]; then
    json "$ICON_DISC" "Disconnected" "disconnected"
    exit 0
fi

ip4=$(ip -4 -o addr show dev "$iface" | awk '{print $4}' | head -1)

# Bandwidth: delta since last run.
rx=$(<"/sys/class/net/$iface/statistics/rx_bytes")
tx=$(<"/sys/class/net/$iface/statistics/tx_bytes")
now=$(date +%s)
bw=""
if [[ -f "$STATE" ]]; then
    read -r prx ptx pt < "$STATE"
    dt=$((now - pt))
    if (( dt > 0 )); then
        bw=$(awk -v r=$(( (rx-prx)/dt )) -v t=$(( (tx-ptx)/dt )) '
            function h(b){ if(b>1048576) return sprintf("%.1f MB/s",b/1048576); if(b>1024) return sprintf("%.0f kB/s",b/1024); return b " B/s" }
            BEGIN{ printf "⇣%s  ⇡%s", h(r), h(t) }')
    fi
fi
echo "$rx $tx $now" > "$STATE"

# Internet check: ping two servers in parallel; offline only if both fail.
ping -c1 -W2 1.1.1.1 >/dev/null 2>&1 & p1=$!
ping -c1 -W2 8.8.8.8 >/dev/null 2>&1 & p2=$!
if ! wait "$p1" && ! wait "$p2"; then
    json "$ICON_NOINET" "Sem internet ($iface $ip4)" "noinet"
    exit 0
fi

if [[ -d "/sys/class/net/$iface/wireless" ]]; then
    ssid=$(iwctl station "$iface" show 2>/dev/null | awk -F'network' '/Connected network/{gsub(/^ +| +$/,"",$2); print $2}')
    q=$(awk -v i="$iface:" '$1==i{gsub(/\./,"",$3); print $3}' /proc/net/wireless)
    q=${q:-0}
    idx=$(( q * 5 / 71 )); (( idx > 4 )) && idx=4
    json "${ICONS_WIFI[$idx]}" "$(center "${ICONS_WIFI[$idx]} ${ssid:-$iface}" "$ip4" "$bw")" "wifi"
else
    json "$ICON_ETH" "$(center "$ICON_ETH  $iface" "$ip4" "$bw")" "ethernet"
fi

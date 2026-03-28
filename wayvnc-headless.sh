#!/bin/bash

# -------------------
# CONFIGURATION
# -------------------
HEADLESS_NAME="HEADLESS"          # Prefix for headless monitor
VNC_ADDRESS="10.77.42.159"             # Listen on all interfaces
VNC_PORT="5900"
PID_FILE="$HOME/.config/wayvnc/wayvnc.pid"

# -------------------
# FUNCTIONS
# -------------------

is_wayvnc_running() {
    [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null
}

start_server() {
    mkdir -p "$(dirname "$PID_FILE")"

    # Check or create headless monitor first
    MONITOR_NAME=$(hyprctl monitors | grep "$HEADLESS_NAME" | awk '{print $2}' | head -n1)
    if [ -z "$MONITOR_NAME" ]; then
        echo "📺 Creating headless monitor..."
        hyprctl output create headless
        sleep 0.5
        MONITOR_NAME=$(hyprctl monitors | grep "$HEADLESS_NAME" | awk '{print $2}' | head -n1)
        echo "✅ Created: $MONITOR_NAME"
    else
        echo "✅ Headless monitor already exists: $MONITOR_NAME"
    fi

    # Set headless monitor to 1920x1080@60Hz to avoid GPU capture errors
    hyprctl output setmode "$MONITOR_NAME" 1920x1080@60

    # Start WayVNC (CPU mode, no GPU)
    if ! is_wayvnc_running; then
        echo "🚀 Starting WayVNC server..."
        nohup wayvnc -v "$VNC_ADDRESS" --output "$MONITOR_NAME" >/dev/null 2>&1 &
        echo $! > "$PID_FILE"
        sleep 1
    else
        echo "⚠️ WayVNC already running."
    fi

    echo "✅ Started! Connect via VNC: $VNC_ADDRESS:$VNC_PORT"
}

stop_server() {
    if is_wayvnc_running; then
        echo "🛑 Stopping WayVNC server..."
        kill $(cat "$PID_FILE") 2>/dev/null
        rm -f "$PID_FILE"
    else
        echo "ℹ️ WayVNC not running."
    fi

    MONITOR_NAME=$(hyprctl monitors | grep "$HEADLESS_NAME" | awk '{print $2}' | head -n1)
    if [ -n "$MONITOR_NAME" ]; then
        echo "❌ Removing headless monitor: $MONITOR_NAME"
        hyprctl output remove "$MONITOR_NAME"
    fi

    echo "✅ Stop completed!"
}

# -------------------
# MAIN
# -------------------

case "$1" in
    start) start_server ;;
    stop) stop_server ;;
    *) echo "Usage: $0 {start|stop}" ;;
esac

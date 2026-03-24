#!/bin/bash

# -------------------
# CONFIGURATION
# -------------------
HEADLESS_NAME="HEADLESS"     # Prefix of the headless monitor
VNC_ADDRESS="0.0.0.0"
VNC_PORT="5900"
PID_FILE="$HOME/.config/wayvnc/wayvnc.pid"

# -------------------
# FUNCTIONS
# -------------------

# Check if WayVNC is running
is_wayvnc_running() {
    [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null
}

# Start server
start_server() {
    mkdir -p "$(dirname "$PID_FILE")"

    # Don't start if already running
    if is_wayvnc_running; then
        echo "⚠️ WayVNC is already running. Skipping start."
    else
        echo "🚀 Starting WayVNC server (nohup -g -v)..."
        nohup wayvnc -g -v $VNC_ADDRESS >/dev/null 2>&1 &
        echo $! > "$PID_FILE"
        sleep 1
    fi

    # Check for headless monitor
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

    # Attach WayVNC to headless monitor
    echo "🎯 Setting WayVNC output..."
    wayvncctl output-set "$MONITOR_NAME"

    echo "✅ Started! Connect via VNC: $VNC_ADDRESS:$VNC_PORT"
}

# Stop server
stop_server() {
    # Stop WayVNC
    if is_wayvnc_running; then
        echo "🛑 Stopping WayVNC server..."
        kill $(cat "$PID_FILE") 2>/dev/null
        rm -f "$PID_FILE"
    else
        echo "ℹ️ WayVNC server is not running."
    fi

    # Remove headless monitor if exists
    MONITOR_NAME=$(hyprctl monitors | grep "$HEADLESS_NAME" | awk '{print $2}' | head -n1)
    if [ -n "$MONITOR_NAME" ]; then
        echo "❌ Removing headless monitor: $MONITOR_NAME"
        hyprctl output remove "$MONITOR_NAME"
    else
        echo "ℹ️ No headless monitor found."
    fi

    echo "✅ Stop completed!"
}

# -------------------
# MAIN
# -------------------

case "$1" in
    start)
        start_server
        ;;
    stop)
        stop_server
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        ;;
esac

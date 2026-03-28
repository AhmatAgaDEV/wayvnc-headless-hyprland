# WayVNC Headless Script for Hyprland

A simple **Bash script** to manage a headless WayVNC server on **Hyprland / Wayland**.

It handles:

* Automatic creation of a **headless monitor** if not present
* Starting WayVNC with verbose logging
* Stopping WayVNC and removing the headless monitor
* PID-based process tracking

---

## Features

* **Start / Stop management**
* Works with **Hyprland / Wayland**
* Runs WayVNC in the background using `nohup`
* Prevents GPU capture errors by setting monitor resolution to 1920x1080@60Hz

---

## Installation

Download the script using the **direct raw GitHub link**:

```bash
wget -q https://raw.githubusercontent.com/AhmatAgaDEV/wayvnc-headless/main/wayvnc-headless.sh -O wayvnc-headless.sh
chmod +x wayvnc-headless.sh
```

> The script is saved in the **current working directory**, not the home folder.

---

## Usage

### Start the headless WayVNC server

```bash
./wayvnc-headless.sh start
```

* Creates headless monitor if missing
* Attaches WayVNC to the monitor
* Runs in **nohup** background mode

### Stop the WayVNC server

```bash
./wayvnc-headless.sh stop
```

* Stops WayVNC process
* Removes headless monitor

---

## One-liner install + start

```bash
wget -q https://raw.githubusercontent.com/AhmatAgaDEV/wayvnc-headless/main/wayvnc-headless.sh -O wayvnc-headless.sh && chmod +x wayvnc-headless.sh && ./wayvnc-headless.sh start
```

---

## Configuration

* **Headless monitor prefix**: `HEADLESS_NAME="HEADLESS"`
* **VNC address**: `VNC_ADDRESS="10.77.42.159"`
* **VNC port**: `VNC_PORT="5900"`
* **PID file**: `$HOME/.config/wayvnc/wayvnc.pid`

You can edit these variables in the script directly if needed.

---

## Requirements

* **Hyprland** (or any Wayland compositor)
* **WayVNC** (`wayvnc` and `wayvncctl`)
* **Hyprctl** commands available

---

## License

This project is licensed under **MIT License** – see LICENSE for details.

---

## Notes

* Always check `hyprctl monitors` to confirm headless monitor name
* The script sets monitor to **1920x1080@60Hz** for proper VNC capture
* Works with Android or desktop VNC clients

---

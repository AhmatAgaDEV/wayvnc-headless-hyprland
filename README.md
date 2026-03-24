---

# **README.md — WayVNC Headless Script (wget version)**

````markdown
# WayVNC Headless Script

![WayVNC](https://img.shields.io/badge/WayVNC-Headless-blue)

A simple Bash script to manage a **headless WayVNC server** on Hyprland / Wayland.  

It automatically:

- Starts WayVNC in **nohup mode** with GPU and verbose logging (`-g -v`)  
- Creates a **headless monitor** if not present  
- Attaches WayVNC to the headless monitor  
- Stops WayVNC and removes the headless monitor cleanly  

---

## Features

- **Start / Stop management**  
- **Automatic headless monitor creation**  
- **Works on Hyprland / Wayland setups**  
- **PID-based process tracking**, compatible with `nohup`  
- Easy to install and run using `wget`  

---

## Installation

### Download script using `wget`

```bash
wget -q https://raw.githubusercontent.com/AhmatAgaDEV/wayvnc-headless/main/wayvnc-headless.sh -O wayvnc-headless.sh
````

> The script will be saved **in the current directory** (not in home).

### Make it executable

```bash
chmod +x wayvnc-headless.sh
```

---

## Usage

### Start WayVNC headless server

```bash
./wayvnc-headless.sh start
```

* Creates a headless monitor if it doesn’t exist
* Attaches WayVNC to it
* Runs in the background (`nohup -g -v`)

### Stop WayVNC server

```bash
./wayvnc-headless.sh stop
```

* Stops WayVNC process
* Removes the headless monitor

---

## One-line installation + start

For a quick setup in the current directory:

```bash
wget -q https://raw.githubusercontent.com/AhmatAgaDEV/wayvnc-headless/main/wayvnc-headless.sh -O wayvnc-headless.sh && chmod +x wayvnc-headless.sh && ./wayvnc-headless.sh start
```

---

## Requirements

* **Hyprland** or other Wayland compositor
* **WayVNC** installed and working (`wayvnc` and `wayvncctl`)
* **Hyprctl** commands available

---

## Configuration

* The script uses `wayvnc.pid` in `$HOME/.config/wayvnc/` to store the PID of the running WayVNC process
* Headless monitor prefix is set in `HEADLESS_NAME="HEADLESS"`
* VNC address and port can be configured:

```bash
VNC_ADDRESS="0.0.0.0"
VNC_PORT="5900"
```

---

## License

This project is licensed under the **MIT License** – see [LICENSE](LICENSE) for details.

---

### Notes

* Always check `hyprctl monitors` to see the headless monitor name
* The script automatically creates/removes the headless monitor on start/stop
* Works with Android VNC apps, desktop VNC viewers, or any VNC client

---

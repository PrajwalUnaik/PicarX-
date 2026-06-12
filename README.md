# PicarX- Setup

Automated setup script for the [SunFounder PiCar-X v2.0](https://docs.sunfounder.com/projects/picar-x-v20/en/latest/) on Raspberry Pi.  
Flash your Pi, run one command, walk away — everything installs and reboots automatically.

---

## ⚡ Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/PrajwalUnaik/PicarX-/main/picarx_setup.sh | sudo bash
```

> Make sure your Raspberry Pi is **connected to the internet** before running.

---

## 📦 What Gets Installed

| Module | Version | Description |
|--------|---------|-------------|
| System packages | latest | `git`, `python3-pip`, `python3-setuptools`, `python3-smbus` |
| [robot-hat](https://github.com/sunfounder/robot-hat) | 2.5.x | Hardware abstraction layer for SunFounder robots |
| [vilib](https://github.com/sunfounder/vilib) | latest | Vision library for the Pi camera |
| [picar-x](https://github.com/sunfounder/picar-x) | 2.1.x | Main PiCar-X control library |
| I2S Amplifier | — | Audio output support via `i2samp.sh` |

---

## 🔧 What the Script Does

1. **Updates** the system (`apt update && apt upgrade`)
2. **Installs** required base Python packages
3. **Clones & installs** `robot-hat`, `vilib`, and `picar-x` from GitHub
4. **Enables sound** by running the I2S amplifier setup script
5. **Reboots** the Pi automatically after everything is done

---

## 📋 Requirements

- Raspberry Pi (any model running Raspberry Pi OS)
- Internet connection
- Works on both **Raspberry Pi OS Desktop** and **Raspberry Pi OS Lite**

---

## 🔁 Safe to Re-run

The script removes and re-clones all module folders before installing, so it's completely safe to run again after re-flashing your SD card.

---

## 🔊 No Sound After Reboot?

If there's no audio output after the reboot, SSH into your Pi and re-run the I2S amplifier script manually:

```bash
cd ~/robot-hat
sudo bash i2samp.sh
```

Run it a couple of times if needed — this is a known quirk with the I2S amplifier setup.

---

## 📄 License

This setup script is provided as-is for personal use with the SunFounder PiCar-X kit.  
All installed modules belong to their respective owners — see [SunFounder's GitHub](https://github.com/sunfounder) for their licenses.

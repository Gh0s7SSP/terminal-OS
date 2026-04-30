# terminal-OS
TERMINAL OS is a terminal-based desktop simulation built with Batch and PowerShell
💻 TERMINAL OS

A lightweight, terminal-based desktop simulation built using Batch + PowerShell, featuring a Windows-like interface, arrow-key navigation, and real system tools.

🚀 Overview

TERMINAL OS is a command-line desktop environment that simulates a real operating system UI inside the Windows terminal.

It includes:

🖥️ ASCII-based desktop interface
🎮 Arrow-key navigation
🪟 Window-style menus (Network, System, Files)
📡 Real system tools (IP, ping, Wi-Fi scan, processes)
📁 File manager (create, delete, list files)
🎨 Colorful UI with ASCII wallpaper
📸 Features
🖥️ Desktop Environment
ASCII art wallpaper
Interactive icon menu
Highlighted selection system
Keyboard navigation (↑ ↓ ENTER)
🪟 Window System
Network Center
System Monitor
File Explorer
Each window runs real commands inside the terminal
🌐 Network Tools
Show IP configuration (ipconfig)
Ping test (Google or custom host)
Wi-Fi network scan
📊 System Tools
System information (systeminfo)
Running processes (tasklist)
📁 File Manager
List files in directory
Create files
Delete files
🎮 Controls
Desktop
↑ / ↓ → Navigate menu
ENTER → Open selected window
Q → Quit OS
Inside Windows
Number keys (1–3 / 1–4) → Execute actions
Follow on-screen instructions
⚙️ Requirements
Windows OS
PowerShell enabled (default on Windows 10/11)
No external dependencies
📦 Installation
Clone or download the project:
git clone (https://github.com/Gh0s7SSP/terminal-OS.git)
Open the folder:
cd terminal-os
Run the OS:
terminal_os.bat
📁 Project Structure
terminal-os/
│
├── terminal_os.bat     # Launcher (login + start system)
├── desktop.ps1         # UI engine (desktop + windows + tools)
└── README.md
🧠 How It Works
.bat file handles startup, login, and launching PowerShell
PowerShell script renders the UI and handles navigation
Windows are simulated using loop-based rendering
Real system commands are executed inside each window
💡 Ideas for Future Improvements
🖱️ Mouse support (via GUI rewrite)
🪟 Draggable windows (true UI system)
🎨 Animations & transitions
🧠 Built-in assistant / AI commands
🌐 Web-based version (HTML/CSS/JS OS)
🔐 Improved authentication system
⚠️ Disclaimer

This project is:

A simulation / educational OS interface
Not a real operating system
Intended for learning terminal UI, scripting, and system commands
👨‍💻 Author

Created as a terminal UI experiment combining:

Batch scripting
PowerShell UI rendering
System command integration

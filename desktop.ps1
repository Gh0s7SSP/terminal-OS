param([string]$Username = "admin")

# ════════════════════════════════════════════════════════
#   TERM OS v2.0 — Desktop Environment
#   by 4y0ubyyyy  (improved) ts took me too long fr fr 
# ════════════════════════════════════════════════════════

$Host.UI.RawUI.WindowTitle = "TERM OS v2.0"
try { $Host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,50) } catch {}
try { $Host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,40) } catch {}

# ── Palette helpers ─────────────────────────────────────
function C($text, $fg, $bg=$null) {
    if ($bg) { Write-Host $text -ForegroundColor $fg -BackgroundColor $bg -NoNewline }
    else      { Write-Host $text -ForegroundColor $fg -NoNewline }
}
function CL($text, $fg, $bg=$null) {
    if ($bg) { Write-Host $text -ForegroundColor $fg -BackgroundColor $bg }
    else      { Write-Host $text -ForegroundColor $fg }
}
function NL { Write-Host "" }

# ── Taskbar ─────────────────────────────────────────────
function Draw-Taskbar {
    $time = (Get-Date).ToString("HH:mm")
    $date = (Get-Date).ToString("dd/MM/yy")
    $bar  = " [TERM OS v2.0]   $Username@termos   $date $time "
    $pad  = " " * (80 - $bar.Length - 1)
    Write-Host ($bar + $pad + " ") -ForegroundColor Black -BackgroundColor Cyan
}

# ── Wallpaper ────────────────────────────────────────────
function Draw-Wallpaper {
    Clear-Host
    Draw-Taskbar
    CL "                                                                                " DarkCyan DarkBlue
    CL "    ████████╗███████╗██████╗ ███╗   ███╗    ██████╗ ███████╗   v2.0           " Cyan DarkBlue
    CL "    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║   ██╔═══██╗██╔════╝                 " Cyan DarkBlue
    CL "       ██║   █████╗  ██████╔╝██╔████╔██║   ██║   ██║███████╗                 " White DarkBlue
    CL "       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║   ██║   ██║╚════██║                 " Cyan DarkBlue
    CL "       ██║   ███████╗██║  ██║██║ ╚═╝ ██║   ╚██████╔╝███████║                 " Cyan DarkBlue
    CL "       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝    ╚═════╝ ╚══════╝                " DarkCyan DarkBlue
    CL "                                                                                " DarkCyan DarkBlue
    # Stars / decoration
    for ($row = 0; $row -lt 16; $row++) {
        $line = "  "
        for ($col = 0; $col -lt 76; $col++) {
            $r = Get-Random -Minimum 0 -Maximum 40
            if ($r -eq 0) { $line += "*" } elseif ($r -eq 1) { $line += "." } else { $line += " " }
        }
        CL $line DarkBlue DarkBlue
    }
}

# ── Desktop icons ────────────────────────────────────────
$icons = @(
    @{ Label="[1] Terminal";    Color="Green";   Desc="Command Shell"  }
    @{ Label="[2] Network";     Color="Cyan";    Desc="Net Tools"      }
    @{ Label="[3] Files";       Color="Yellow";  Desc="File Explorer"  }
    @{ Label="[4] System";      Color="Magenta"; Desc="System Info"    }
    @{ Label="[5] Text Editor"; Color="White";   Desc="Write & Edit"   }
    @{ Label="[6] Calculator";  Color="DarkCyan";Desc="Math Tools"     }
    @{ Label="[7] Music";       Color="DarkYellow"; Desc="Play Sounds" }
    @{ Label="[0] Shutdown";    Color="Red";     Desc="Power Off"      }
)

function Draw-Icons {
    # Position: 2 columns of 4 icons
    $left = @(0,1,2,3)
    $right = @(4,5,6,7)
    $rows = [Math]::Max($left.Count, $right.Count)
    for ($r = 0; $r -lt $rows; $r++) {
        # Left icon
        $li = if ($r -lt $left.Count) { $icons[$left[$r]] } else { $null }
        # Right icon
        $ri = if ($r -lt $right.Count) { $icons[$right[$r]] } else { $null }

        # Row 1 of icon
        if ($li) { C ("  ╔═══════════════════╗  ") $li.Color }
        else      { C ("  " + " "*23 + " ") Gray }
        if ($ri) { CL ("  ╔═══════════════════╗  ") $ri.Color }
        else      { NL }

        # Row 2 – label
        if ($li) {
            C "  ║ " $li.Color
            C ("{0,-19}" -f $li.Label) $li.Color
            C " ║  " $li.Color
        } else { C ("  " + " "*23 + " ") Gray }
        if ($ri) {
            C "  ║ " $ri.Color
            C ("{0,-19}" -f $ri.Label) $ri.Color
            CL " ║  " $ri.Color
        } else { NL }

        # Row 3 – desc
        if ($li) {
            C "  ║ " $li.Color
            C ("  " + ("{0,-17}" -f $li.Desc)) DarkGray
            C " ║  " $li.Color
        } else { C ("  " + " "*23 + " ") Gray }
        if ($ri) {
            C "  ║ " $ri.Color
            C ("  " + ("{0,-17}" -f $ri.Desc)) DarkGray
            CL " ║  " $ri.Color
        } else { NL }

        # Row 4 – bottom
        if ($li) { C "  ╚═══════════════════╝  " $li.Color }
        else      { C ("  " + " "*23 + " ") Gray }
        if ($ri) { CL "  ╚═══════════════════╝  " $ri.Color }
        else      { NL }

        NL
    }
}

function Draw-Desktop {
    Draw-Wallpaper
    NL
    CL "  ╔══════════════════════════════════════════════════════════════════════════╗" DarkCyan
    CL "  ║  DESKTOP — press a number key to open an app                             ║" Cyan
    CL "  ╚══════════════════════════════════════════════════════════════════════════╝" DarkCyan
    NL
    Draw-Icons
}

# ═══════════════════════════════════════════════════════
#  WINDOW CHROME helper
# ═══════════════════════════════════════════════════════
function Open-Window($title, $color) {
    Clear-Host
    Draw-Taskbar
    NL
    $bar = "  $title"
    $pad = "═" * (72 - $title.Length)
    CL "  ╔═$pad══╗" $color
    CL ("  ║  $title" + (" " * (71 - $title.Length)) + "║") $color
    CL "  ╠═$pad══╣" $color
}
function Close-Window($color) {
    CL "  ╚$(('═')*73)╝" $color
    NL
    CL "  Press any key to return to desktop..." DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# ═══════════════════════════════════════════════════════
#   APP: TERMINAL SHELL
# ═══════════════════════════════════════════════════════
function App-Terminal {
    Clear-Host
    Draw-Taskbar
    NL
    CL "  ╔══════════════════════════════════════════════════════════════════════════╗" Green
    CL "  ║  TERMINAL — TERM OS v2.0 Shell                                           ║" Green
    CL "  ╠══════════════════════════════════════════════════════════════════════════╣" Green
    CL "  ║  Type 'help' for commands. Type 'exit' to close. DUHH                    ║" DarkGreen
    CL "  ╚══════════════════════════════════════════════════════════════════════════╝" Green
    NL

    $history = @()
    while ($true) {
        C "  " White
        C "$Username" Cyan
        C "@" DarkCyan
        C "termos" Green
        C ":" DarkGray
        C "~$ " Yellow
        $cmd = Read-Host

        if (!$cmd) { continue }
        $history += $cmd
        $parts = $cmd.Trim() -split "\s+", 2
        $verb  = $parts[0].ToLower()
        $arg   = if ($parts.Count -gt 1) { $parts[1] } else { "" }

        switch ($verb) {
            "exit"    { return }
            "clear"   { 
                Clear-Host; Draw-Taskbar; NL
                CL "  ╔══════════════════════════════════════════════════════════════════════════╗" Green
                CL "  ║  TERMINAL                                                                ║" Green
                CL "  ╚══════════════════════════════════════════════════════════════════════════╝" Green
                NL
            }
            "help"    {
                NL
                CL "  ┌──────────────────────────────────────────────────────────────────┐" DarkCyan
                CL "  │  BUILT-IN COMMANDS    now i see why your parents dont love you   │" Cyan
                CL "  ├──────────────────────────────────────────────────────────────────┤" DarkCyan
                @(
                    "  │  help          — show this list                                 │"
                    "  │  clear         — clear screen                                   │"
                    "  │  whoami        — current user                                   │"
                    "  │  date          — date & time                                    │"
                    "  │  ls / dir      — list directory                                 │"
                    "  │  pwd           — working directory                              │"
                    "  │  echo [text]   — print text                                     │"
                    "  │  uname         — kernel info                                    │"
                    "  │  uptime        — system uptime                                  │"
                    "  │  history       — command history                                │"
                    "  │  color [name]  — change text color                              │"
                    "  │  fortune       — random quote                                   │"
                    "  │  matrix        — matrix effect                                  │"
                    "  │  sysinfo       — quick system stats                             │"
                    "  │  exit          — close terminal                                 │"
                ) | ForEach-Object { CL $_ Cyan }
                CL "   └─────────────────────────────────────────────────────────────────┘" DarkCyan
                NL
            }
            "whoami"  { CL "  $Username" Green; NL }
            "date"    { CL "  $(Get-Date -Format 'dddd, dd MMMM yyyy  HH:mm:ss')" Cyan; NL }
            "pwd"     { CL "  $(Get-Location)" Yellow; NL }
            { $_ -in "ls","dir" } {
                NL
                CL "  Directory listing: $(Get-Location)" DarkCyan
                Get-ChildItem | ForEach-Object {
                    if ($_.PSIsContainer) { CL "  [DIR]  $($_.Name)" Cyan }
                    else { C "  [FILE] " DarkGray; CL $_.Name Yellow }
                }
                NL
            }
            "echo"    { CL "  $arg" White; NL }
            "uname"   { CL "  TERM-OS v2.0 — PowerShell $($PSVersionTable.PSVersion) — $env:OS" Cyan; NL }
            "uptime"  {
                $boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
                $up   = (Get-Date) - $boot
                CL "  Up: $([int]$up.TotalHours)h $($up.Minutes)m $($up.Seconds)s" Cyan; NL
            }
            "history" {
                NL; CL "  Command History:" DarkCyan
                for ($i=0; $i -lt $history.Count; $i++) { CL "  $($i+1)  $($history[$i])" Gray }
                NL
            }
            "fortune" {
                $quotes = @(
                    "now yk why your parents dont like you "
                    "get a like lil bro and go shower too i can smell ts from my room"
                    "In the middle of every difficulty lies opportunity."
                    "Stay hungry, stay foolish dont be a jew. — Steven epstayn"
                    "First, solve the problem. Then, write the code.JK JST ASK CHATGPT LMFAO"
                    "The only way to do great work is to GET A GF"
                    "Talk is cheap. Show me the code. — Linus Torvalds my goat"
                )
                $q = $quotes[(Get-Random -Maximum $quotes.Count)]
                NL; CL "  `"$q`"" Yellow; NL
            }
            "matrix"  {
                CL "  [Matrix mode — press any key to stop idk why i did this frfr]" DarkGreen
                $chars = "01アイウエオカキクケコサシスセソタチツテトナニヌネノ"
                $cols  = 76
                $run   = $true
                while ($run) {
                    $line = ""
                    for ($i=0; $i -lt $cols; $i++) {
                        $line += $chars[(Get-Random -Maximum $chars.Length)]
                    }
                    CL "  $line" Green
                    Start-Sleep -Milliseconds 60
                    if ($Host.UI.RawUI.KeyAvailable) {
                        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                        $run = $false
                    }
                }
                NL
            }
            "sysinfo" {
                NL
                $os  = Get-CimInstance Win32_OperatingSystem
                $cpu = (Get-CimInstance Win32_Processor).Name
                $ram = [math]::Round($os.TotalVisibleMemorySize/1MB,1)
                $free= [math]::Round($os.FreePhysicalMemory/1MB,1)
                CL "  OS   : $($os.Caption)" Cyan
                CL "  CPU  : $cpu" Green
                CL "  RAM  : ${ram} GB total  /  ${free} GB free" Yellow
                CL "  Host : $env:COMPUTERNAME" Magenta
                CL "  User : $Username" White
                NL
            }
            "color"   {
                $validColors = @("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")
                if ($arg -and $arg -in $validColors) {
                    $Host.UI.RawUI.ForegroundColor = $arg
                    CL "  Color changed to $arg" $arg
                } else {
                    CL "  Usage: color [name]  Available: $($validColors -join ', ')" DarkGray
                }
                NL
            }
            default {
                try {
                    $out = Invoke-Expression $cmd 2>&1
                    if ($out) { $out | ForEach-Object { CL "  $_" Gray } }
                } catch {
                    CL "  [ERROR] Command not found: $verb" Red
                }
                NL
            }
        }
    }
}

# ═════════════════════════════════════════════════════════════════════════════════════
#   APP: NETWORK CENTER hack your own wifi lol and black list your self like a dumb ahh
# ═════════════════════════════════════════════════════════════════════════════════════
function App-Network {
    while ($true) {
        Open-Window "NETWORK CENTER" Cyan
        CL "  ║  [1] Show IP & Adapters                                                  ║" White
        CL "  ║  [2] Ping a host                                                         ║" White
        CL "  ║  [3] WiFi Networks                                                       ║" White
        CL "  ║  [4] Open Ports (netstat)                                                ║" White
        CL "  ║  [5] DNS Lookup                                                          ║" White
        CL "  ║  [0] Back to Desktop                                                     ║" Red
        CL "  ╚═════════════════════════════════════════════════════════════════════════╝" Cyan
        NL
        C "  Choice: " Cyan
        $k = Read-Host
        switch ($k) {
            "1" {
                Open-Window "IP & ADAPTERS" Cyan
                ipconfig | ForEach-Object { CL "  ║  $_" Gray }
                Close-Window Cyan
            }
            "2" {
                C "  Host to ping: " Cyan; $h = Read-Host
                Open-Window "PING → $h" Cyan
                ping $h | ForEach-Object { CL "  ║  $_" Gray }
                Close-Window Cyan
            }
            "3" {
                Open-Window "WIFI NETWORKS" Cyan
                netsh wlan show networks | ForEach-Object { CL "  ║  $_" Gray }
                Close-Window Cyan
            }
            "4" {
                Open-Window "OPEN PORTS" Cyan
                netstat -an | Select-Object -First 30 | ForEach-Object { CL "  ║  $_" Gray }
                Close-Window Cyan
            }
            "5" {
                C "  Domain to lookup: " Cyan; $d = Read-Host
                Open-Window "DNS → $d" Cyan
                try { Resolve-DnsName $d | ForEach-Object { CL "  ║  $($_.Name)  →  $($_.IPAddress)" Green } }
                catch { CL "  ║  [ERROR] Could not resolve $d" Red }
                Close-Window Cyan
            }
            "0" { return }
        }
    }
}

# ═══════════════════════════════════════════════════════
#   APP: FILE MANAGER ts was was hard to make 
# ═══════════════════════════════════════════════════════
function App-Files {
    $cwd = (Get-Location).Path
    while ($true) {
        Open-Window "FILE EXPLORER — $cwd" Yellow
        $items = Get-ChildItem -Path $cwd -ErrorAction SilentlyContinue
        $dirs  = $items | Where-Object { $_.PSIsContainer }
        $files = $items | Where-Object { !$_.PSIsContainer }
        CL "  ║  [Folders]" DarkYellow
        $i = 1
        $dirs | ForEach-Object {
            CL ("  ║    [{0,2}] 📁 {1}" -f $i, $_.Name) Yellow
            $i++
        }
        CL "  ║" Yellow
        CL "  ║  [Files]" DarkGray
        $files | ForEach-Object {
            $sz = if ($_.Length -gt 1MB) { "{0:N1} MB" -f ($_.Length/1MB) }
                  elseif ($_.Length -gt 1KB) { "{0:N1} KB" -f ($_.Length/1KB) }
                  else { "$($_.Length) B" }
            CL ("  ║    {0,-40} {1,10}" -f $_.Name, $sz) Gray
        }
        CL "  ╠═══════════════════════════════════════════════════════════════════════════╣" Yellow
        CL "  ║  [c] Change dir  [n] New file  [d] Delete file  [r] Rename  [0] Back   ║" DarkYellow
        CL "  ╚═══════════════════════════════════════════════════════════════════════════╝" Yellow
        NL
        C "  Choice: " Yellow; $k = (Read-Host).ToLower()
        switch ($k) {
            "c" { C "  New path (or '..' to go up): " Yellow; $p = Read-Host; try { Set-Location $p; $cwd = (Get-Location).Path } catch { CL "  [ERROR] $p" Red; Start-Sleep 1 } }
            "n" { C "  File name: " Yellow; $fn = Read-Host; New-Item -Path (Join-Path $cwd $fn) -ItemType File -Force | Out-Null; CL "  [OK] Created $fn" Green; Start-Sleep 1 }
            "d" { C "  File/folder name: " Red; $fn = Read-Host; try { Remove-Item (Join-Path $cwd $fn) -Recurse -Force; CL "  [OK] Deleted" Green } catch { CL "  [ERROR] $_" Red }; Start-Sleep 1 }
            "r" { C "  Old name: " Yellow; $old = Read-Host; C "  New name: " Yellow; $new = Read-Host; try { Rename-Item (Join-Path $cwd $old) $new; CL "  [OK] Renamed" Green } catch { CL "  [ERROR] $_" Red }; Start-Sleep 1 }
            "0" { return }
        }
    }
}

# ═══════════════════════════════════════════════════════
#   APP: SYSTEM INFO
# ═══════════════════════════════════════════════════════
function App-System {
    while ($true) {
        Open-Window "SYSTEM PANEL" Magenta
        CL "  ║  [1] Full System Info                                                    ║" White
        CL "  ║  [2] Running Processes                                                   ║" White
        CL "  ║  [3] CPU & RAM Usage                                                     ║" White
        CL "  ║  [4] Disk Usage                                                          ║" White
        CL "  ║  [5] Environment Variables                                               ║" White
        CL "  ║  [0] Back                                                                ║" Red
        CL "  ╚═════════════════════════════════════════════════════════════════════════╝" Magenta
        NL
        C "  Choice: " Magenta
        $k = Read-Host
        switch ($k) {
            "1" {
                Open-Window "SYSTEM INFO" Magenta
                $os  = Get-CimInstance Win32_OperatingSystem
                $cpu = Get-CimInstance Win32_Processor
                $mb  = Get-CimInstance Win32_BaseBoard
                @(
                    "  ║  OS      : $($os.Caption) $($os.Version)"
                    "  ║  Build   : $($os.BuildNumber)"
                    "  ║  Host    : $env:COMPUTERNAME"
                    "  ║  CPU     : $($cpu.Name)"
                    "  ║  Cores   : $($cpu.NumberOfCores) cores / $($cpu.NumberOfLogicalProcessors) threads"
                    "  ║  RAM     : $([math]::Round($os.TotalVisibleMemorySize/1MB,2)) GB"
                    "  ║  Board   : $($mb.Manufacturer) $($mb.Product)"
                    "  ║  User    : $Username"
                    "  ║  TermOS  : v2.0"
                ) | ForEach-Object { CL $_ Cyan }
                Close-Window Magenta
            }
            "2" {
                Open-Window "TOP PROCESSES" Magenta
                Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 |
                    ForEach-Object { CL ("  ║  {0,-30} CPU:{1,6:N1}  MEM:{2,6:N1}MB" -f $_.Name, $_.CPU, ($_.WorkingSet64/1MB)) Gray }
                Close-Window Magenta
            }
            "3" {
                Open-Window "CPU & RAM" Magenta
                $os   = Get-CimInstance Win32_OperatingSystem
                $cpu  = Get-CimInstance Win32_Processor
                $load = $cpu.LoadPercentage
                $ramT = [math]::Round($os.TotalVisibleMemorySize/1MB,1)
                $ramF = [math]::Round($os.FreePhysicalMemory/1MB,1)
                $ramU = [math]::Round($ramT - $ramF,1)
                $ramP = [math]::Round(($ramU/$ramT)*100)
                $cpuBar = "#" * [int]($load/5) + "." * (20 - [int]($load/5))
                $ramBar = "#" * [int]($ramP/5) + "." * (20 - [int]($ramP/5))
                CL "  ║  CPU Usage : [$cpuBar] $load%" $(if($load -gt 80){"Red"}elseif($load -gt 50){"Yellow"}else{"Green"})
                CL "  ║  RAM Usage : [$ramBar] $ramP%  ($ramU / $ramT GB)" $(if($ramP -gt 80){"Red"}elseif($ramP -gt 60){"Yellow"}else{"Cyan"})
                Close-Window Magenta
            }
            "4" {
                Open-Window "DISK USAGE" Magenta
                Get-PSDrive -PSProvider FileSystem | ForEach-Object {
                    if ($_.Used -and $_.Free) {
                        $tot = [math]::Round(($_.Used+$_.Free)/1GB,1)
                        $use = [math]::Round($_.Used/1GB,1)
                        $pct = [math]::Round(($_.Used/($_.Used+$_.Free))*100)
                        $bar = "#"*[int]($pct/5) + "."*(20-[int]($pct/5))
                        CL ("  ║  {0}:\  [{1}] {2}%  ({3}/{4} GB)" -f $_.Name, $bar, $pct, $use, $tot) $(if($pct -gt 90){"Red"}elseif($pct -gt 70){"Yellow"}else{"Green"})
                    }
                }
                Close-Window Magenta
            }
            "5" {
                Open-Window "ENV VARIABLES" Magenta
                Get-ChildItem Env: | Select-Object -First 20 | ForEach-Object {
                    CL ("  ║  {0,-25} = {1}" -f $_.Name, ($_.Value -replace "`n"," ")) Gray
                }
                Close-Window Magenta
            }
            "0" { return }
        }
    }
}

# ═══════════════════════════════════════════════════════
#   APP: TEXT EDITOR (NOTEPAD)
# ═══════════════════════════════════════════════════════
function App-TextEditor {
    $filename = ""
    $lines    = @()
    Open-Window "TEXT EDITOR" White
    CL "  ║  [n] New  [o] Open file  [s] Save  [e] Edit  [0] Back                   ║" DarkGray
    CL "  ╚═════════════════════════════════════════════════════════════════════════╝" White
    NL
    C "  Choice: " White; $k = (Read-Host).ToLower()
    switch ($k) {
        "n" {
            C "  New filename: " White; $filename = Read-Host
            $lines = @()
        }
        "o" {
            C "  File path: " White; $filename = Read-Host
            if (Test-Path $filename) { $lines = Get-Content $filename }
            else { CL "  [ERROR] File not found." Red; Start-Sleep 1; return }
        }
        "0" { return }
    }
    while ($true) {
        Open-Window "EDITOR — $filename" White
        CL "  ║  [Type lines and press ENTER. Empty line to stop typing.]               ║" DarkGray
        CL "  ╠═════════════════════════════════════════════════════════════════════════╣" White
        for ($i=0; $i -lt $lines.Count; $i++) {
            CL ("  ║  {0,3} │ {1}" -f ($i+1), $lines[$i]) Gray
        }
        CL "  ╠═════════════════════════════════════════════════════════════════════════╣" White
        CL "  ║  [a] Append lines  [d] Delete line  [s] Save  [c] Clear  [0] Back     ║" DarkGray
        CL "  ╚═════════════════════════════════════════════════════════════════════════╝" White
        NL
        C "  Choice: " White; $k = (Read-Host).ToLower()
        switch ($k) {
            "a" {
                CL "  (type lines, blank line = done)" DarkGray
                while ($true) {
                    C "  + " Green; $ln = Read-Host
                    if ($ln -eq "") { break }
                    $lines += $ln
                }
            }
            "d" {
                C "  Line number to delete: " Red; $n = [int](Read-Host)
                if ($n -ge 1 -and $n -le $lines.Count) { $lines = $lines | Where-Object { $lines.IndexOf($_) -ne ($n-1) } }
            }
            "s" {
                $lines | Set-Content $filename
                CL "  [OK] Saved to $filename" Green; Start-Sleep 1
            }
            "c" { $lines = @() }
            "0" { return }
        }
    }
}

# ═══════════════════════════════════════════════════════
#   APP: CALCULATOR sins your bahh dont know how to count
# ═══════════════════════════════════════════════════════
function App-Calculator {
    $mem = 0
    while ($true) {
        Open-Window "CALCULATOR" DarkCyan
        CL "  ║  Enter an expression (e.g. 10 + 5 * 2 / 3)                             ║" Cyan
        CL "  ║  Commands: [m+] store  [mr] recall  [mc] clear mem  [0] back           ║" DarkGray
        CL "  ╠═════════════════════════════════════════════════════════════════════════╣" DarkCyan
        CL "  ║  Memory: $mem$((' ')*67)║" DarkCyan
        CL "  ╚═════════════════════════════════════════════════════════════════════════╝" DarkCyan
        NL
        C "  = " Cyan; $expr = Read-Host
        switch ($expr.ToLower()) {
            "0"  { return }
            "mr" { CL "  Memory: $mem" Cyan }
            "mc" { $mem = 0; CL "  Memory cleared." DarkGray }
            default {
                if ($expr -match "^m\+(.*)") {
                    try { $v = [double](Invoke-Expression $matches[1]); $mem += $v; CL "  M+ $v  (Memory: $mem)" Cyan } catch { CL "  [ERROR] Invalid" Red }
                } else {
                    try {
                        $result = [math]::Round([double](Invoke-Expression $expr), 8)
                        NL; CL "  ┌─────────────────────────────────┐" DarkCyan
                        CL "  │  $expr = $result$((' ')*(32-$expr.Length-"$result".Length))│" Cyan
                        CL "  └─────────────────────────────────┘" DarkCyan
                    } catch {
                        CL "  [ERROR] Could not evaluate: $expr" Red
                    }
                }
            }
        }
        NL; CL "  Press ENTER to continue..." DarkGray; Read-Host | Out-Null
    }
}

# ═══════════════════════════════════════════════════════
#   APP: MUSIC PLAYER (beep tunes) 
# ═══════════════════════════════════════════════════════
function App-Music {
    while ($true) {
        Open-Window "MUSIC PLAYER" DarkYellow
        CL "  ║  [1] Play: nigga tune                                                   ║" Yellow
        CL "  ║  [2] Play: Imperial March                                               ║" Yellow
        CL "  ║  [3] Play: Mario Theme                                                  ║" Yellow
        CL "  ║  [4] Play: Alarm                                                        ║" Yellow
        CL "  ║  [0] Back                                                               ║" Red
        CL "  ╚═════════════════════════════════════════════════════════════════════════╝" DarkYellow
        NL
        C "  Choice: " Yellow; $k = Read-Host
        switch ($k) {
            "1" {
                CL "  ♪ Playing: nigga tune..." Yellow
                @(523,50,523,50,784,100,784,100,880,100,880,100,784,200,698,100,698,100,659,100,659,100,587,100,587,100,523,200) | ForEach-Object -Begin { $i=0;$prev=0 } -Process {
                    if ($i % 2 -eq 0) { $prev = $_ } else { [Console]::Beep($prev,$_) }; $i++
                }
            }
            "2" {
                CL "  ♪ Playing: Imperial March..." Yellow
                $notes = @(440,500,440,500,440,500,349,350,523,150,440,500,349,350,523,150,440,1000)
                for ($i=0; $i -lt $notes.Count-1; $i+=2) { [Console]::Beep($notes[$i],$notes[$i+1]) }
            }
            "3" {
                CL "  ♪ Playing: Mario Theme..." Yellow
                $notes = @(660,100,660,100,0,100,660,100,0,100,510,100,660,100,0,100,770,100,0,300,380,100)
                for ($i=0; $i -lt $notes.Count-1; $i+=2) {
                    if ($notes[$i] -eq 0) { Start-Sleep -Milliseconds $notes[$i+1] }
                    else { [Console]::Beep($notes[$i],$notes[$i+1]) }
                }
            }
            "4" {
                CL "  ♪ Alarm!wake up bigga " Red
                for ($j=0; $j -lt 5; $j++) { [Console]::Beep(1000,200); [Console]::Beep(500,200) }
            }
            "0" { return }
        }
        NL; CL "  Done! Press ENTER..." DarkGray; Read-Host | Out-Null
    }
}

# ═══════════════════════════════════════════════════════
#   SHUTDOWN SCREEN
# ═══════════════════════════════════════════════════════
function Do-Shutdown {
    Clear-Host
    NL; NL; NL
    CL "  ╔══════════════════════════════════╗" Red
    CL "  ║                                  ║" Red
    CL "  ║   Shutting down TERM OS v2.0...  ║" White
    CL "  ║             finnaly              ║" Red
    CL "  ║   Goodbye, $Username.$((' ')*(20-$Username.Length))║" DarkGray
    CL "  ║                                  ║" Red
    CL "  ╚══════════════════════════════════╝" Red
    Start-Sleep 2
    exit
}

# ═══════════════════════════════════════════════════════
#   MAIN DESKTOP LOOP
# ═══════════════════════════════════════════════════════
while ($true) {
    Draw-Desktop
    NL
    C "  Open app [1-7] or [0] Shutdown: " DarkCyan
    $key = Read-Host
    switch ($key) {
        "1" { App-Terminal }
        "2" { App-Network  }
        "3" { App-Files    }
        "4" { App-System   }
        "5" { App-TextEditor }
        "6" { App-Calculator }
        "7" { App-Music    }
        "0" { Do-Shutdown  }
    }
}
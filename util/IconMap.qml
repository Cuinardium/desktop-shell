pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: iconMapper

    readonly property var map: {
        // Misc
        // "qbittorrent": {
        //     title: "QBittorrent",
        //     icon: ""
        // },
        "rofi": {
            title: "Rofi",
            icon: ""
        },

        // Browsers
        // "brave-browser": {
        //     title: "Brave Browser",
        //     icon: "󰖟"
        // },
        "chromium": {
            title: "Chromium",
            icon: ""
        },
        "firefox": {
            title: "Firefox",
            icon: "󰈹"
        },
        // "floorp": {
        //     title: "Floorp",
        //     icon: "󰈹"
        // },
        // "google-chrome": {
        //     title: "Google Chrome",
        //     icon: ""
        // },
        // "microsoft-edge": {
        //     title: "Edge",
        //     icon: "󰇩"
        // },
        // "opera": {
        //     title: "Opera",
        //     icon: ""
        // },
        // "thorium": {
        //     title: "Thorium",
        //     icon: "󰖟"
        // },
        // "tor-browser": {
        //     title: "Tor Browser",
        //     icon: ""
        // },
        // "vivaldi": {
        //     title: "Vivaldi",
        //     icon: "󰖟"
        // },
        // "waterfox": {
        //     title: "Waterfox",
        //     icon: "󰖟"
        // },
        // "zen": {
        //     title: "Zen Browser",
        //     icon: ""
        // },

        // Terminals
        // "st": {
        //     title: "st Terminal",
        //     icon: ""
        // },
        // "alacritty": {
        //     title: "Alacritty",
        //     icon: ""
        // },
        "com.mitchellh.ghostty": {
            title: "Ghostty",
            icon: "󰊠"
        },
        // "foot": {
        //     title: "Foot Terminal",
        //     icon: "󰽒"
        // },
        // "gnome-terminal": {
        //     title: "GNOME Terminal",
        //     icon: ""
        // },
        // "kitty": {
        //     title: "Kitty Terminal",
        //     icon: "󰄛"
        // },
        // "konsole": {
        //     title: "Konsole",
        //     icon: ""
        // },
        // "tilix": {
        //     title: "Tilix",
        //     icon: ""
        // },
        // "urxvt": {
        //     title: "URxvt",
        //     icon: ""
        // },
        // "wezterm": {
        //     title: "Wezterm",
        //     icon: ""
        // },
        // "xterm": {
        //     title: "XTerm",
        //     icon: ""
        // },

        // Development Tools
        // "dbeaver": {
        //     title: "DBeaver",
        //     icon: ""
        // },
        "android-studio": {
            title: "Android Studio",
            icon: "󰀴"
        },
        // "atom": {
        //     title: "Atom",
        //     icon: ""
        // },
        // "code": {
        //     title: "Visual Studio Code",
        //     icon: "󰨞"
        // },
        // "docker": {
        //     title: "Docker",
        //     icon: ""
        // },
        // "eclipse": {
        //     title: "Eclipse",
        //     icon: ""
        // },
        // "emacs": {
        //     title: "Emacs",
        //     icon: ""
        // },
        "jetbrains-idea": {
            title: "IntelliJ IDEA",
            icon: ""
        },
        // "jetbrains-phpstorm": {
        //     title: "PhpStorm",
        //     icon: ""
        // },
        // "jetbrains-pycharm": {
        //     title: "PyCharm",
        //     icon: ""
        // },
        // "jetbrains-webstorm": {
        //     title: "WebStorm",
        //     icon: ""
        // },
        // "neovide": {
        //     title: "Neovide",
        //     icon: ""
        // },
        "neovim": {
            title: "Neovim",
            icon: ""
        },
        // "netbeans": {
        //     title: "NetBeans",
        //     icon: ""
        // },
        // "sublime-text": {
        //     title: "Sublime Text",
        //     icon: ""
        // },
        // "vim": {
        //     title: "Vim",
        //     icon: ""
        // },
        // "vscode": {
        //     title: "VS Code",
        //     icon: "󰨞"
        // },

        // Communication Tools
        "discord": {
            title: "Discord",
            icon: ""
        },
        // "legcord": {
        //     title: "Legcord",
        //     icon: ""
        // },
        // "webcord": {
        //     title: "WebCord",
        //     icon: ""
        // },
        // "org.telegram.desktop": {
        //     title: "Telegram",
        //     icon: ""
        // },
        // "skype": {
        //     title: "Skype",
        //     icon: "󰒯"
        // },
        // "slack": {
        //     title: "Slack",
        //     icon: "󰒱"
        // },
        // "teams": {
        //     title: "Microsoft Teams",
        //     icon: "󰊻"
        // },
        // "teamspeak": {
        //     title: "TeamSpeak",
        //     icon: ""
        // },
        // "telegram-desktop": {
        //     title: "Telegram",
        //     icon: ""
        // },
        // "thunderbird": {
        //     title: "Thunderbird",
        //     icon: ""
        // },
        // "vesktop": {
        //     title: "Vesktop",
        //     icon: ""
        // },
        // "whatsapp": {
        //     title: "WhatsApp",
        //     icon: "󰖣"
        // },

        // File Managers
        // "doublecmd": {
        //     title: "Double Commander",
        //     icon: "󰝰"
        // },
        // "krusader": {
        //     title: "Krusader",
        //     icon: "󰝰"
        // },
        // "nautilus": {
        //     title: "Files (Nautilus)",
        //     icon: "󰝰"
        // },
        // "nemo": {
        //     title: "Nemo",
        //     icon: "󰝰"
        // },
        // "org.kde.dolphin": {
        //     title: "Dolphin",
        //     icon: ""
        // },
        // "pcmanfm": {
        //     title: "PCManFM",
        //     icon: "󰝰"
        // },
        // "ranger": {
        //     title: "Ranger",
        //     icon: "󰝰"
        // },
        // "thunar": {
        //     title: "Thunar",
        //     icon: "󰝰"
        // },

        // Media Players
        "mpv": {
            title: "MPV",
            icon: ""
        },
        // "plex": {
        //     title: "Plex",
        //     icon: "󰚺"
        // },
        // "rhythmbox": {
        //     title: "Rhythmbox",
        //     icon: "󰓃"
        // },
        // "ristretto": {
        //     title: "Ristretto",
        //     icon: "󰋩"
        // },
        "spotify": {
            title: "Spotify",
            icon: "󰓇"
        },
        // "vlc": {
        //     title: "VLC Media Player",
        //     icon: "󰕼"
        // },

        // Graphics Tools
        // "blender": {
        //     title: "Blender",
        //     icon: "󰂫"
        // },
        // "gimp": {
        //     title: "GIMP",
        //     icon: ""
        // },
        // "inkscape": {
        //     title: "Inkscape",
        //     icon: ""
        // },
        // "krita": {
        //     title: "Krita",
        //     icon: ""
        // },

        // Video Editing
        // "kdenlive": {
        //     title: "Kdenlive",
        //     icon: ""
        // },

        // Games and Gaming Platforms
        // "csgo": {
        //     title: "CS:GO",
        //     icon: "󰺵"
        // },
        // "dota2": {
        //     title: "Dota 2",
        //     icon: "󰺵"
        // },
        // "heroic": {
        //     title: "Heroic Games Launcher",
        //     icon: "󰺵"
        // },
        // "lutris": {
        //     title: "Lutris",
        //     icon: "󰺵"
        // },
        // "minecraft": {
        //     title: "Minecraft",
        //     icon: "󰍳"
        // },
        // "steam": {
        //     title: "Steam",
        //     icon: ""
        // },

        // Office and Productivity
        // "evernote": {
        //     title: "Evernote",
        //     icon: ""
        // },
        "libreoffice-base": {
            title: "LibreOffice Base",
            icon: ""
        },
        "libreoffice-calc": {
            title: "LibreOffice Calc",
            icon: ""
        },
        "libreoffice-draw": {
            title: "LibreOffice Draw",
            icon: ""
        },
        "libreoffice-impress": {
            title: "LibreOffice Impress",
            icon: ""
        },
        "libreoffice-math": {
            title: "LibreOffice Math",
            icon: ""
        },
        "libreoffice-writer": {
            title: "LibreOffice Writer",
            icon: ""
        },
        "obsidian": {
            title: "Obsidian",
            icon: "󱓧"
        },
        // "sioyek": {
        //     title: "Sioyek",
        //     icon: ""
        // },
        "libreoffice": {
            title: "LibreOffice Default",
            icon: ""
        },
        "title:libreoffice": {
            title: "LibreOffice Dialogs",
            icon: ""
        },
        "soffice": {
            title: "LibreOffice Base Selector",
            icon: ""
        },

        // Cloud Services and Sync
        // "dropbox": {
        //     title: "Dropbox",
        //     icon: "󰇣"
        // }
    }

    function getMatch(appId) {
        if (!appId) {
            return {
                title: "Desktop",
                icon: "󰇄"
            };
        }

        let key = String(appId).toLowerCase();

        if (map[key] !== undefined) {
            return map[key];
        }

        return {
            title: "Unknown",
            icon: "󰣆"
        };
    }
}

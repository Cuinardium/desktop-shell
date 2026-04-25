pragma Singleton
import Quickshell

Singleton {
    id: root

    function lock() {
        Quickshell.execDetached(["hyprlock"]);
    }

    function suspend() {
        Quickshell.execDetached(["bash", "-c", "systemctl suspend"]);
    }

    function poweroff() {
        Quickshell.execDetached(["bash", "-c", `systemctl poweroff`]);
    }

    function reboot() {
        Quickshell.execDetached(["bash", "-c", `systemctl reboot`]);
    }

    function rebootToFirmware() {
        Quickshell.execDetached(["bash", "-c", `systemctl reboot --firmware-setup`]);
    }
}

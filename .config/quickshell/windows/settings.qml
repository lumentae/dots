import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Quickshell
import Quickshell.Io

FloatingWindow {
    id: root
    implicitWidth: 1280
    implicitHeight: 800
    title: "Quickshell Settings"
    color: "#66000000"

    Column {
        anchors.centerIn: parent
        Text {
            text: "hello world"
            color: "#fff"
        }
        Button {
            onClicked: zenity_process.running = true
        }
    }

    Process {
        id: zenity_process
        command: ["/usr/sbin/zenity", "--file-selection"]
        stdout: SplitParser {
            onRead: data => {
                wallpaper_process.command = ["/usr/sbin/bash", "/home/lumentae/.config/quickshell/scripts/set-wallpaper.sh", data.trim()]
                wallpaper_process.running = true
            }
        }
    }

    Process {
        id: wallpaper_process
        command: []
    }
}
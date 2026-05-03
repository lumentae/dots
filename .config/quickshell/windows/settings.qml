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
            onClicked: wallpaper_process.running = true
        }
    }

    Process {
        id: wallpaper_process
        command: ["/home/lumentae/.config/quickshell/scripts/set-wallpaper.sh"]
    }
}

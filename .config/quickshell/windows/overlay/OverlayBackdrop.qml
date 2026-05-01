import QtQuick
import QtQuick.Window
import Quickshell

FloatingWindow {
    id: root
    signal requestClose

    title: "Quickshell Overlay Backdrop"
    implicitWidth: screen?.width ?? 1
    implicitHeight: screen?.height ?? 1
    color: "transparent"
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "#40000000"

        MouseArea {
            anchors.fill: parent
            onClicked: root.requestClose()
        }
    }

    Shortcut {
        sequence: "Escape"
        onActivated: root.requestClose()
    }
}

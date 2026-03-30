// Pill.qml
import Quickshell;
import QtQuick;

Item {
    id: root

    property string text: "Pill"
    property string color: "#000000"
    property string backgroundColor: "#aa000000"

    // Safe enum-like values
    readonly property int posCenter: 0
    readonly property int posRight: 1
    readonly property int posLeft: 2

    property int position: posCenter

    // Size follows content
    width: background.width
    height: background.height

    // 👉 Dynamic positioning (NO states needed)
    anchors.horizontalCenter: position === posCenter
        ? parent.horizontalCenter
        : undefined

    anchors.verticalCenter: parent.verticalCenter

    anchors.right: position === posRight ? parent.right : undefined
    anchors.left: position === posLeft ? parent.left : undefined

    anchors.rightMargin: position === posRight ? 2 : 0
    anchors.leftMargin: position === posLeft ? 2 : 0

    Rectangle {
        id: background
        anchors.centerIn: parent
        color: backgroundColor
        radius: 12

        width: label.width + 20
        height: label.height + 10
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: root.color
    }
}
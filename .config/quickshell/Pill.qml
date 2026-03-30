// Pill.qml
import Quickshell;
import QtQuick;

Item {
    id: root

    property string text: "Pill"
    property string color: "#000000"
    property string backgroundColor: "#77000000"

    readonly property int posCenter: 0
    readonly property int posRight: 1
    readonly property int posLeft: 2

    property int position: posCenter

    implicitWidth: label.implicitWidth + 20
    implicitHeight: 26

    width: implicitWidth
    height: implicitHeight

    anchors.horizontalCenter: position === posCenter
        ? parent.horizontalCenter
        : undefined

    anchors.verticalCenter: parent ? parent.verticalCenter : undefined

    anchors.right: position === posRight ? parent.right : undefined
    anchors.left: position === posLeft ? parent.left : undefined

    anchors.rightMargin: position === posRight ? 4 : 0
    anchors.leftMargin: position === posLeft ? 4 : 0

    Rectangle {
        id: background
        anchors.fill: parent
        color: backgroundColor
        radius: 12
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: root.color
    }
}
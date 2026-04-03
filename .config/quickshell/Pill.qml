// Pill.qml
import Quickshell;
import QtQuick;

Item {
    id: root

    property string text: ""
    property string color: "#000000"
    property string backgroundColor: "#77000000"
    property bool iconVisible: true
    visible: text !== "" || iconVisible
    default property alias content: prefix.data

    readonly property int posCenter: 0
    readonly property int posRight: 1
    readonly property int posLeft: 2

    property int position: posCenter

    implicitWidth: visible ? layout.implicitWidth + 20 : 0
    implicitHeight: visible ? Resources.barHeight - 4 : 0

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

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: prefix.implicitWidth > 0 ? 6 : 0

        Row {
            id: prefix
            spacing: 4
            anchors.verticalCenter: parent.verticalCenter
            visible: iconVisible
        }

        Text {
            id: label
            text: root.text
            color: root.color
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
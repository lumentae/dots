import QtQuick

Rectangle {
    id: root
    property string titleText: "Volume mixer"

    height: 36
    color: "#191919"
    border.color: "#40ffffff"
    radius: 8

    Text {
        text: root.titleText
        color: "#f2f2f2"
        opacity: 0.95
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 12
        font.pixelSize: 14
        font.weight: Font.DemiBold
        renderType: Text.NativeRendering
    }
}

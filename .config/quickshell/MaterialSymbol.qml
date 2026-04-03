import QtQuick

Text {
    id: root
    property real iconSize: 16
    property real fill: 0
    property real truncatedFill: fill.toFixed(1)
    renderType: Text.NativeRendering
    font {
        hintingPreference: Font.PreferNoHinting
        family: "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * truncatedFill
        variableAxes: {
            "FILL": truncatedFill,
            "opsz": iconSize
        }
    }
    verticalAlignment: Text.AlignVCenter
    color: "black"
}
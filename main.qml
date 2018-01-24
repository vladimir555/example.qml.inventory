import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 1.4
//import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3


ApplicationWindow {

    function printObject(obj) {
        var output = '';
        for (var property in obj) {
          output += property + ': ' + obj[property]+';\n';
        }
        console.log(output)
    }


    visible: true
    width: 310
    height: 270
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height
    title: qsTr("Inventory")
    id: windowMain
    objectName: "windowMain"

    GridLayout {
        id: gridWindow
        columns: 1
        rows: 2

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 4
        anchors.bottomMargin: 4

        GridLayout {
            id: gridMenu
            columns: 2
            rows: 1

            Layout.alignment: Qt.AlignCenter
            width: parent.width / 2

            Button {
                text: qsTr("Start")
                id: buttonStart
                width: parent.width / 2
                onClicked: parent.visible = false
            }

            Button {
                text: qsTr("Exit")
                id: buttonExit
                width: parent.width / 2

                onClicked: windowMain.close()
            }
        }

        GridLayout {
            columns: 2
            rows: 1

            Layout.alignment: Qt.AlignCenter

            GridLayout {
                id: gridPlayground
                columns: 3
                rows: 3

                Layout.alignment: Qt.AlignCenter

                Repeater {
                    id: items
                    model: 9

                    delegate: Rectangle {
                        border.width: 1
                        width: 72
                        height: 72

                        Image {
                            id: imageItem
                            sourceSize.width: 64
                            sourceSize.height: 64
                            source: "qrc:///image/apple"
                            anchors.centerIn: parent

                            Text {
                                id: textImage
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                text: qsTr("1")
                            }

                            Drag.active: dragArea.drag.active
                            Drag.dragType: Drag.Automatic
                            Drag.supportedActions: Qt.MoveAction
                            Drag.source: parent
                            Drag.mimeData: {
                                "text/plain": "index " + index
                            }

                            MouseArea {
                                id: dragArea
                                anchors.fill: parent

                                drag.target: parent
                                onPressed: parent.grabToImage(
                                    function(result) {
//                                        console.log("pressed: " + result.url)
                                        parent.Drag.imageSource = result.url
                                        parent.Drag.text = result.url
                                    }
                                )
                            }
                        }

                        DropArea {
                            anchors.fill: parent

                            onDropped: function(drag) {
                                var index_from = drag.text.split(" ")[1]
                                var from = Qt.size(index_from % gridPlayground.columns,
                                    Math.floor(index_from / gridPlayground.columns))
                                var to   = Qt.size(index  % gridPlayground.columns,
                                    Math.floor(index      / gridPlayground.columns))
                                var cell = JSON.parse(form.onMoveCell(from, to))
                                imageItem.source = cell.url
                                if (cell.count === 0)
                                    textImage.text = ""
                                else
                                    textImage.text = cell.count
                                drag.accept()



//                                printObject()
//                                var item_from = items[index_from]
//                                item_from.imageItem.source = ""
//                                item_from.imageItem.textImage.text = ""
                            }
                        }
                    }
                }
            }

            GridLayout {
                columns: 1
                rows: 2
                Layout.alignment: Qt.AlignCenter

                Image {
                    id: imageSource
                    source: "qrc:///image/apple"
                    sourceSize.width: 64
                    sourceSize.height: 64
                }

                Button {
                    text: qsTr("Menu")
                    id: buttonMenu
                    Layout.alignment: Qt.AlignRight
                    onClicked: gridMenu.visible = true
                }
            }
        }
    }
}

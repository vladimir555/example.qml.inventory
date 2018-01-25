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

            Grid {
                id: gridPlayground
                columns: 3
                rows: 3

                Layout.alignment: Qt.AlignCenter

                Repeater {
                    id: items
                    model: 9

                    delegate: Rectangle {
                        id: item
                        border.width: 1
                        width: 72
                        height: 72

                        property string items_text: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

                        Image {
                            id: imageItem
                            sourceSize.width: 64
                            sourceSize.height: 64
                            source: "qrc:///image/apple"
                            anchors.centerIn: parent

                            Text {
                                id: textItem
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                text: items_text[index]
                            }

                            Drag.active: dragArea.drag.active
                            Drag.dragType: Drag.Automatic
                            Drag.supportedActions: Qt.MoveAction
                            Drag.source: item
                            Drag.mimeData: {
                                "text/plain": index
                            }

                            MouseArea {
                                id: dragArea
                                anchors.fill: parent

                                drag.target: parent
                                onPressed: parent.grabToImage(
                                    function(result) {
                                        parent.Drag.imageSource = result.url
                                        parent.Drag.text = result.url
                                        parent.Drag.startDrag()
                                    }
                                )
                            }
                        }

                        DropArea {
                            anchors.fill: parent

                            onDropped: function(drag) {
                                var index_from = drag.text
                                var from = Qt.size(index_from % gridPlayground.columns,
                                    Math.floor(index_from / gridPlayground.columns))
                                var to   = Qt.size(index  % gridPlayground.columns,
                                    Math.floor(index      / gridPlayground.columns))
                                var cell = JSON.parse(form.onMoveCell(from, to))
                                imageItem.source = cell.url
                                if (cell.count === 0) {
                                    textItem.text = ""
                                    imageItem.source = ""
                                } else
                                    textItem.text = cell.count
                                drag.accept()
//                                drag.source = "!";
//                                printObject(gridPlayground.data[1].data.imageItem)
//                                printObject(gridPlayground.data[1].imageItem)


                                console.log("from: " + index_from)
//                                items_text[index_from] = "55"
//                                for (var i = 0; i < items.count; i++) {

//                                    console.log(items.itemAt(i).visible)
//                                }


//                                printObject()
//                                var item_from = gridPlayground.children[index_from]
//                                printObject(item_from)

//                                console.log(gridPlayground)
//                                item_from.enabled = false
//                                item_from.text = ""
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
                    sourceSize.width: 64
                    sourceSize.height: 64
                    source: "qrc:///image/apple"
//                    anchors.top: parent

                    Drag.active: dragArea.drag.active
                    Drag.dragType: Drag.Automatic
                    Drag.supportedActions: Qt.MoveAction
                    Drag.source: parent
                    Drag.mimeData: {
                        "text/plain": index
                    }

                    MouseArea {
                        id: dragAreaSource
                        anchors.fill: parent
                        drag.target: parent
                        onPressed: parent.grabToImage(
                            function(result) {
                                parent.Drag.imageSource = result.url
                                parent.Drag.text = "-1"
                            }
                        )
                    }

                    DropArea {
                        anchors.fill: parent

                        onDropped: function(drag) {
                            drag.accept()
                        }
                    }
                }
//                Image {
//                    id: imageSource
//                    source: "qrc:///image/apple"
//                    sourceSize.width: 64
//                    sourceSize.height: 64
//                }

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

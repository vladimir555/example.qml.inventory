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
                    id: repeaterItems
                    model: 9

                    property var items: []
                    function onIndexCreate(index, text, image) {
                        items.push({"text": text, "image": image})
                        return index
                    }

                    function getCell(index) {
                        var pos  =   Qt.size(index % gridPlayground.columns,
                                  Math.floor(index / gridPlayground.columns))
                        var cell = form.onGetCell(pos)
                        return JSON.stringify(cell)
                    }

                    delegate: Rectangle {
                        id: item
                        border.width: 1
                        width: 72
                        height: 72

                        Image {
                            id: imageItem
                            sourceSize.width: 64
                            sourceSize.height: 64
                            source: ""
                            anchors.centerIn: parent

                            Text {
                                id: textItem
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                text: ""
                            }

                            Drag.active: dragArea.drag.active
                            Drag.dragType: Drag.Automatic
                            Drag.supportedActions: Qt.MoveAction
                            Drag.source: parent
                            Drag.mimeData: {
                                "text/plain": repeaterItems.onIndexCreate(index, textItem, imageItem)
                            }

                            MouseArea {
                                id: dragArea
                                anchors.fill: parent

                                drag.target: parent
                                onPressed: parent.grabToImage(
                                    function(result) {
                                        parent.Drag.imageSource = result.url
                                        parent.Drag.text = result.url
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

                                if (cell.url === "" || cell.count === 0) {
                                    imageItem.visible = false
                                } else {
                                    textItem.text       = cell.count
                                    imageItem.source    = cell.url

                                    imageItem.visible   = true
                                }
                                drag.accept()

                                repeaterItems.items[index_from].image.visible = false
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

//                   todo: Drag.active: dragArea.drag.active
                    Drag.dragType: Drag.Automatic
                    Drag.supportedActions: Qt.MoveAction
                    Drag.source: parent
                    Drag.mimeData: {
                        "text/plain": -1
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

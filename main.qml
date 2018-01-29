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
    id: root
    objectName: "root"

    function initializeQML() {
        for (var i = 0; i < repeaterItems.items.length; i++) {
            var cell = repeaterItems.getCell(i)

            if (cell.count === "0" || cell.url === "") {
                repeaterItems.items[i].text.text        = ""
                repeaterItems.items[i].image.source     = ""
                repeaterItems.items[i].image.visible    = false
            } else {
                repeaterItems.items[i].text.text        = cell.count
                repeaterItems.items[i].image.source     = cell.url
                repeaterItems.items[i].image.visible    = true
            }
        }
    }

    Timer {
        interval: 1
        running: true
        repeat: false
        onTriggered: initializeQML()
    }

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
                onClicked: {
                    for (var i = 0; i < repeaterItems.items.length; i++) {
                        repeaterItems.items[i].image.visible = false
                        repeaterItems.items[i].text = ""
                    }

                    form.onReset()
                    parent.visible = false
                }
            }

            Button {
                text: qsTr("Exit")
                id: buttonExit
                width: parent.width / 2

                onClicked: root.close()
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
                    objectName: "repeaterItems"
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
                        return JSON.parse(cell)
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
                                acceptedButtons: Qt.LeftButton | Qt.RightButton

                                drag.target: parent
                                onPressed: parent.grabToImage(
                                    function(result) {
                                        parent.Drag.imageSource = result.url
                                        parent.Drag.text = result.url
                                    }
                                )
                                onClicked: {
                                    if(mouse.button === Qt.RightButton) {
                                        var to   = Qt.size(index  % gridPlayground.columns,
                                            Math.floor(index      / gridPlayground.columns))
                                        textItem.text       = Number(textItem.text) - 1
                                        if (textItem.text === "0") {
                                            imageItem.source    = ""
                                            textItem.text       = ""
                                        }

                                        form.onBiteCell(to)
                                    }
                                }
                            }
                        }

                        DropArea {
                            anchors.fill: parent

                            onDropped: function(drag) {
                                var index_from = drag.text

                                var to   = Qt.size(index  % gridPlayground.columns,
                                    Math.floor(index      / gridPlayground.columns))

                                if (index_from < 0) {
                                    textItem.text       = Number(textItem.text) + 1
                                    imageItem.source    = imageItem2.source
                                    imageItem.visible   = true
                                    form.onIncCell(to)
                                } else {
                                    var from = Qt.size(index_from % gridPlayground.columns,
                                        Math.floor(index_from / gridPlayground.columns))

                                    if (from === to)
                                        return

                                    var cell = JSON.parse(form.onMoveCell(from, to))

                                    if (cell.url === "" || cell.count === 0) {
                                        imageItem.visible   = false
                                    } else {
                                        textItem.text       = cell.count
                                        imageItem.source    = cell.url
                                        imageItem.visible   = true
                                    }

                                    repeaterItems.items[index_from].image.visible = false
                                }
                                drag.accept()
                            }
                        }

                        states: [
                            State {
                                when: item.Drag.active
                                ParentChange {
                                    target: item
                                }

                                AnchorChanges {
                                    target: item
                                    anchors.horizontalCenter: undefined
                                    anchors.verticalCenter: undefined
                                }
                            }
                        ]
                    }
                }
            }

            GridLayout {
                columns: 1
                rows: 2
                Layout.alignment: Qt.AlignCenter

                GridLayout {
                    columns: 1
                    rows: 1

                    Rectangle {
                        id: item2
                        border.width: 1
                        width: 72
                        height: 72

                        Image {
                            id: imageItem2
                            sourceSize.width: 64
                            sourceSize.height: 64
                            source: "qrc:/image/apple"
                            anchors.centerIn: parent

                            Text {
                                id: textItem2
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                text: ""
                            }

                            Drag.active: dragArea2.drag.active
                            Drag.dragType: Drag.Automatic
                            Drag.supportedActions: Qt.CopyAction
                            Drag.source: parent
                            Drag.mimeData: {
                                "text/plain": "-1"
                            }

                            MouseArea {
                                id: dragArea2
                                anchors.fill: parent

                                drag.target: parent
                                onPressed: parent.grabToImage(
                                    function(result) {
                                        parent.Drag.imageSource = result.url
                                        parent.Drag.text = 1
                                    }
                                )
                            }
                        }

                        states: [
                            State {
                                when: item2.Drag.active
                                ParentChange {
                                    target: item2
                                    parent: root
                                }

                                AnchorChanges {
                                    target: item2
                                    anchors.horizontalCenter: undefined
                                    anchors.verticalCenter: undefined
                                }
                            }
                        ]
                    }
                }

                Button {
                    text: qsTr("Menu")
                    id: buttonMenu
                    Layout.alignment: Qt.AlignRight
                    onClicked: {
                        gridMenu.visible = true
                    }
                }
            }
        }
    }
}

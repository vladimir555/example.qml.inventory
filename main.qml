import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 1.4
//import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3


Window {
    visible: true
    minimumWidth: 310
    minimumHeight: 270
    maximumWidth: 320
    maximumHeight: 240
    title: qsTr("Inventory")
    id: window

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

                onClicked: window.close()
            }
        }

        GridLayout {
            columns: 2
            rows: 1

            Layout.alignment: Qt.AlignCenter

            GridLayout {
                columns: 3
                rows: 3

                Layout.alignment: Qt.AlignCenter

                Repeater {
                    id: buttons
                    model: 9

                    delegate: Rectangle {
                        border.width: 1
                        width: 72
                        height: 72
                        Image {
                            id: image
                            sourceSize.width: 64
                            sourceSize.height: 64
                            source: "qrc:///image/apple"
                            anchors.centerIn: parent
    //                        source: ""

                            Text {
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                text: qsTr("1")
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

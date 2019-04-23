import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
Page {
    id: root
    property alias model: tableContent.model

    function userData(fio, date_, id){
        console.log(fio, date_, id)
    }
    signal userDataSignal(string fio, string date_, string id_)
    title: "Пользователи"
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        RowLayout {
            Layout.fillWidth: true
//                    height: 100
            Rectangle {
                Layout.fillWidth: true
                height: 25
                color: "#dbfbf0"
                Label {
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "ФИО"
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: 25
                color: "#dbfbf0"
                Label {
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Дата"
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: 25
                color: "#dbfbf0"
                Label {
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "ID"
                }
            }
        }
        ListView {
            id: tableContent
            model: testModel

            //flow: GridView.FlowTopToBottom
            Layout.fillWidth: true
            height: 300


            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onDoubleClicked: {
                //var currentItem = tableContent.itemAt(mouse.x, mouse.y)
                //userData(currentItem.fio,currentItem.date_,currentItem.id)
                }
                onClicked: {
                    var currentItem = tableContent.itemAt(mouse.x, mouse.y)
                    //var fio = users[indexItem].fio

                    userDataSignal(currentItem.fio,currentItem.date_,currentItem.id)

                }
            }
           // cellHeight: 30
            //cellWidth: parent.width
            delegate: Rectangle {

                property int indexItem: index
                property alias fio: label_fio.text
                property alias date_: label_date.text
                property alias id: label_id.text
                width: parent.width
                      height: 30
                RowLayout {
                    anchors.fill: parent
                    Rectangle {
//                                width: 70
                        Layout.fillWidth: true
                        height: 25
                        color: "#db1b1b"
                        Label {
                            id: label_fio
                            anchors.fill: parent
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: model.fio
                        }
                    }
                    Rectangle {
//                                width: 120
                        Layout.fillWidth: true
                        height: 25
                        color: "#db1b1b"
                        Label {
                            id: label_date
                            anchors.fill: parent
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: model.date
                        }
                    }
                    Rectangle {
//                                width: 50
                        Layout.fillWidth: true
                        height: 25
                        color: "#db1b1b"
                        Label {
                            id: label_id
                            anchors.fill: parent
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: model.id_
                        }
                    }
                }
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
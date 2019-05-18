import QtQuick 2.12
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.12
Page {
    id: root
    property alias model: visualModel.model
    property int pixelSize: 30
    function userData(fio, date_, id){
        console.log(fio, date_, id)
    }
    signal userDataSignal(string fio, string date_, string id_)


    title: "Пользователи"
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        Button {
            id: deleteButton
            Layout.fillWidth: true
            text: "Удалить"
            font.pixelSize: root.pixelSize
            onClicked: {
                console.log('Удаляем отмеченные строки')

                for (var i = visualModel.items.count-1; i >= 0; --i){

                   // console.log(JSON.stringify(visualModel.items.get(i).inSelected))
                   // visualModel.remove(i)
                   if (visualModel.items.get(i).inSelected === true) {

                       var deleteString = "DELETE FROM Users "
                       deleteString += "WHERE ID = " + visualModel.items.get(i).model.modelData.idUser
                       mySqlProvider.connect(dbType,connectionName)
                       mySqlProvider.execUpdateSqlQuery(deleteString, connectionName)
                       mySqlProvider.disconnect(connectionName)
                       visualModel.items.remove(i)
                   }


                }
            }
        }


        RowLayout {
            Layout.fillWidth: true
//                    height: 100


            CheckBox {
            id: deleteAll
            checked: false
            }
            Rectangle {
                Layout.fillWidth: true
                height: root.pixelSize * 1.25
                color: "#dbfbf0"
                Label {
                    anchors.fill: parent
                    font.pixelSize: root.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "ФИО"
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: root.pixelSize * 1.25
                color: "#dbfbf0"
                Label {
                    anchors.fill: parent
                    font.pixelSize: root.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Дата"
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: root.pixelSize * 1.25
                color: "#dbfbf0"
                Label {
                    anchors.fill: parent
                    font.pixelSize: root.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "ID"
                }
            }
        }
        ListView {
            id: tableContent
            Layout.fillWidth: true
            height: 300
            spacing: 5
            interactive: false
            property int pixelSize: root.pixelSize
//            MouseArea {
//                id: mouseArea
//                anchors.fill: parent
//                onClicked: {
//                    var currentItem = tableContent.itemAt(mouse.x, mouse.y)
//                    //var fio = users[indexItem].fio

//                    userDataSignal(currentItem.fio,currentItem.date_,currentItem.id)

//                }
//            }
            displaced: Transition{
                NumberAnimation {properties: "x,y"; easing.type: Easing.OutQuad }
            }

            model: DelegateModel {
                id: visualModel

                groups: [
                    DelegateModelGroup { name: "selected" }
                ]

                delegate: DropArea {
                    id: delegateRoot
                    height: tableContent.pixelSize * 1.25
                    width: parent.width

                    onEntered: {
                        console.log(drag.source.visualIndex, line.visualIndex)
                        visualModel.items.move(drag.source.visualIndex, line.visualIndex)

                        var tmp = visualModel.model[drag.source.visualIndex]
                       // visualModel.move(1,0);
                        visualModel.model[drag.source.visualIndex] = visualModel.model[line.visualIndex]
                        visualModel.model[line.visualIndex] = tmp
                    }

                    property int visualIndex: DelegateModel.itemsIndex
                    Binding { target: line; property: "visualIndex";value: visualIndex }

                    RowLayout {
                    id: line
                    property int visualIndex: 0

                    property int indexItem: index
                    property alias fio: label_fio.text
                    property alias date_: label_date.text
                    property alias id: label_id.text
                    height: delegateRoot.height
                    width: delegateRoot.width
                    //anchors.fill: parent
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    DragHandler {
                     id: dragHandler

                    }
                    Drag.active: dragHandler.active
                    Drag.source: line
                    Drag.hotSpot.x: line.width / 2
                    Drag.hotSpot.y: line.height / 2

                    states: [
                        State {
                            when: line.Drag.active
                            ParentChange {
                                target: line
                                parent: tableContent
                            }
                            AnchorChanges {
                                target: line
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined

                            }
                        }

                    ]

                    CheckBox {
                        id: deleteCheckBox
                        checked: false
                        onCheckedChanged: {
                            delegateRoot.DelegateModel.inSelected = checked

                        }
                    }

                        Rectangle {
    //                                width: 70
                            Layout.fillWidth: true
                            height: tableContent.pixelSize * 1.25
                            color: "#db1b1b"
                            Label {
                                id: label_fio
                                anchors.fill: parent
                                font.pixelSize: root.pixelSize * 1.25
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: model.modelData.fio
                            }
                        }
                        Rectangle {
    //                                width: 120
                            Layout.fillWidth: true
                            height: tableContent.pixelSize * 1.25
                            color: "#db1b1b"
                            Label {
                                id: label_date
                                anchors.fill: parent
                                font.pixelSize: tableContent.pixelSize
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: model.modelData.date
                            }
                        }
                        Rectangle {
    //                                width: 50
                            Layout.fillWidth: true
                            height: tableContent.pixelSize * 1.25
                            color: "#db1b1b"
                            Label {
                                id: label_id
                                anchors.fill: parent
                                font.pixelSize: root.pixelSize
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: model.modelData.idUser
                            }
                        }
                    //}
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}

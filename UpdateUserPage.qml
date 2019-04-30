import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MySQLProvider 1.0

Page {
    id: root
    property MySQLProvider mySqlProvider
    property alias userFIO: fio.text
    property alias userDate: date.text
    property alias userID: idUser.text
    property string connectionName
    property int dbType
    function functionUserData(fio, date_, id){
        //console.log(fio, date_, id)
        userFIO = fio
        userDate = date_
        userID = id
    }
    CalendarDialog {
        id: calendarDialog
        onAccepted: {
            callItem.text = calendarDialog.selectedDate.toLocaleDateString(Qt.locale("ru_RU"), "dd.MM.yyyy")
        }
    }

    title: "Обновление информации"
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        GridLayout {
            Layout.fillWidth: true
            columns: 2
            Label {
                //Layout.fillWidth: true
                text: "ФИО"
            }
            TextField {
                id: fio
                Layout.fillWidth: true
                selectByMouse: true
            }
            Label {
                //Layout.fillWidth: true
                text: "Дата"
            }
            Button {
                id: date
                text: ""
                onClicked: {
                    calendarDialog.selectedDate = Date.fromLocaleString(Qt.locale("ru_RU"),text, "dd.MM.yyyy")
                    calendarDialog.callItem = this
                    calendarDialog.open()
                }
            }
            /*
            TextField {
                id: date
                Layout.fillWidth: true
                selectByMouse: true
            }
            */
            Label {
                //Layout.fillWidth: true
                text: "ID"
            }
            TextField {
                id: idUser
                Layout.fillWidth: true
                selectByMouse: true
            }
        }
        Button {
            Layout.fillWidth: true
            text: "Обновить"
            onClicked: {
                var updateString = "UPDATE Users SET FIO ="
                updateString += "'" + fio.text + "'" + ", "
                updateString += "reg_date = '" + date.text + "'"
                updateString += "WHERE ID = " + idUser.text
                mySqlProvider.connect(dbType,connectionName)
                mySqlProvider.execUpdateSqlQuery(updateString, connectionName)
                mySqlProvider.disconnect(connectionName)
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}

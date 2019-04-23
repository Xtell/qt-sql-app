import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MySQLProvider 1.0
Page {
    id: addUserView
    property MySQLProvider mySqlProvider
    property string connectionName
    property int dbType
    title: "Добавление пользователя"
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
            }
            Label {
                //Layout.fillWidth: true
                text: "Дата"
            }
            TextField {
                id: date
                Layout.fillWidth: true
            }
            Label {
                //Layout.fillWidth: true
                text: "ID"
            }
            TextField {
                id: idUser
                Layout.fillWidth: true
            }
        }
        Button {
            Layout.fillWidth: true
            text: "Добавить"
            onClicked: {
                var insertString = "INSERT INTO Users (FIO, reg_date, ID) VALUES ("
                insertString += "'" + fio.text + "'" + ", "
                insertString += "'" + date.text + "'" + ", "
                insertString += idUser.text + ")"
                var selectString = "SELECT FIO, reg_date, ID FROM Users WHERE "
                selectString += "FIO = '" + fio.text + "' AND "
                selectString += "reg_date = '" + date.text + "' AND "
                selectString += "ID = " + idUser.text
                mySqlProvider.connect(dbType,connectionName)
                var countString = mySqlProvider.execSelectSqlQuery(selectString, connectionName)
                if (countString === 0)
                    mySqlProvider.execInsertSqlQuery(insertString, connectionName)
                mySqlProvider.disconnect(connectionName)
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}

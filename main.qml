import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MySQLProvider 1.0


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property string connectionName: "MyConnection"

    MySQLProvider {
        id: mySqlProvider
        dbName: "gfgdf"
        hostname: "remotemysql.com"
        port: 3306
        login: "gfdgf"
        password: "gdfgfd"
    }

    TestUsersModel{
        id: testModel
        //model: testModel
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            Label {
                Layout.fillWidth: true
                text: mainView.currentItem.title
            }
        }
    }

    SwipeView {
        id: mainView
        anchors.fill: parent

        Component.onCompleted: {
            if (currentIndex === 0) {
                var selectString = "SELECT FIO, reg_date, ID FROM Users"
                mySqlProvider.connect(connectionName)
                tableContent.model = mySqlProvider.getUsers(selectString, connectionName)
                mySqlProvider.disconnect(connectionName)
            }
        }

        onCurrentIndexChanged: {
            if (currentIndex === 0) {
                var selectString = "SELECT FIO, reg_date, ID FROM Users"
                mySqlProvider.connect(connectionName)
                tableContent.model = mySqlProvider.getUsers(selectString, connectionName)
                mySqlProvider.disconnect(connectionName)
            }
        }
        UsersPage{
            id: userPage
            model: testModel
            onUserDataSignal: {
                updateUserPage.userDate = date_
                updateUserPage.userFIO = fio
                updateUserPage.userID = id_
                updateUserPage.functionUserData(fio, date_, id_)
                mainView.currentIndex = 2

            }

        }
        AddUserPage{

            id: addUserPage
            mySqlProvider: mySqlProvider
        }
        UpdateUserPage {
           id: updateUserPage
           mySqlProvider: mySqlProvider
        }

    }

//    ColumnLayout {
//        anchors.fill: parent
//        anchors.margins: 10

//        GridView {
//            id: tableContent

////            Component.onCompleted: {
////                tableContent.model = mySqlProvider.getUsers(connectionName)
////            }

//            flow: GridView.FlowTopToBottom
//            Layout.fillWidth: true
//            height: 100
//            cellHeight: 30
//            cellWidth: 150
//            delegate: Rectangle {
//                width: 200
//                RowLayout {
//                    anchors.fill: parent
//                    Label {
//                        id: label_fio
//                        Layout.fillWidth: true
//                        text: model.fio
//                    }
//                    Label {
//                        id: label_date
//                        Layout.fillWidth: true
//                        text: model.date
//                    }
//                    Label {
//                        id: label_id
//                        Layout.fillWidth: true
//                        text: model.idUser
//                    }
//                }
//            }
//        }

//        GridLayout {
//            Layout.fillWidth: true
//            columns: 2
//            Label {
//                //Layout.fillWidth: true
//                text: "ФИО"
//            }
//            TextField {
//                id: fio
//                Layout.fillWidth: true
//            }
//            Label {
//                //Layout.fillWidth: true
//                text: "Дата"
//            }
//            TextField {
//                id: date
//                Layout.fillWidth: true
//            }
//            Label {
//                //Layout.fillWidth: true
//                text: "ID"
//            }
//            TextField {
//                id: idUser
//                Layout.fillWidth: true
//            }
//        }
//        Button {
//            Layout.fillWidth: true
//            text: "Добавить"
//            onClicked: {
//                var insertString = "INSERT INTO Users (FIO, reg_date, ID) VALUES ("
//                insertString += "'" + fio.text + "'" + ", "
//                insertString += "str_to_date('" + date.text + "', '%d.%m.%Y')" + ", "
//                insertString += idUser.text + ")"
//                var selectString = "SELECT FIO, reg_date, ID FROM Users WHERE "
//                selectString += "FIO = '" + fio.text + "' AND "
//                selectString += "reg_date = str_to_date('" + date.text + "', '%d.%m.%Y') AND "
//                selectString += "ID = " + idUser.text
//                mySqlProvider.connect(connectionName)
//                var countString = mySqlProvider.execSelectSqlQuery(selectString, connectionName)
//                if (countString === 0)
//                    mySqlProvider.execInsertSqlQuery(insertString, connectionName)
//                mySqlProvider.disconnect(connectionName)
//            }
//        }
//        Item {
//            Layout.fillHeight: true
//        }
//    }
}

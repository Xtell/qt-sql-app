import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MySQLProvider 1.0

Page{
    id: root
    property MySQLProvider mySqlProvider
    property string connectionName
    property int dbType
    RowLayout {
        anchors.fill: parent
        Item {
            Layout.fillWidth: true

        }

        Button {
            text: "Создать таблицу"
            onClicked: {

                var query = "CREATE TABLE Users ("
                query += "ID INT NOT NULL,"
                query += "FIO VARCHAR(200) NOT NULL,"
                query += "reg_date VARCHAR NOT NULL,"
                query += "PRIMARY KEY (ID));"
                mySqlProvider.connect(dbType,connectionName)
                mySqlProvider.createTable(query,connectionName)
                mySqlProvider.disconnect(dbType,connectionName)
            }
        }
        Item {
            Layout.fillWidth: true

        }
    }
}

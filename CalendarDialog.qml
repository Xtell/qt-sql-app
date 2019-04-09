import QtQuick 2.0
import QtQuick.Controls 2.2
import Qt.labs.calendar 1.0
import QtQuick.Layouts 1.3
import QtQml 2.2

Dialog {
    id: root
    title: "Выберите дату"
    modal: true
    property date currentDate: new Date()
    property alias selectedDate: grid.selectedDate
    property var callItem
    property string dateFormat: "MMMM yyyy"

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillWidth: true
            ToolButton {
                Layout.alignment: Qt.AlignLeft
                //icon.name: "left"
                onClicked: {
                    var d = Date.fromLocaleString(grid.locale, monthYearLabel.monthYear, dateFormat)
                    d.setMonth(d.getMonth() - 1)
                    monthYearLabel.monthYear = d.toLocaleString(grid.locale, dateFormat)
                }
            }
            Label {
                id: monthYearLabel
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                property string monthYear: currentDate.toLocaleString(grid.locale, dateFormat)
                font: grid.font
                text: {
                    var d = Date.fromLocaleString(grid.locale, monthYear, dateFormat)
                    var mon = d.toLocaleString(grid.locale, "MM")
                    var year = d.toLocaleString(grid.locale, "yyyy")
                    var result = ""
                    switch (mon) {
                    case "01":
                        result = "январь " + year
                        break;
                    case "02":
                        result = "февраль " + year
                        break;
                    case "03":
                        result = "март " + year
                        break;
                    case "04":
                        result = "апрель " + year
                        break;
                    case "05":
                        result = "май " + year
                        break;
                    case "06":
                        result = "июнь " + year
                        break;
                    case "07":
                        result = "июль " + year
                        break;
                    case "08":
                        result = "август " + year
                        break;
                    case "09":
                        result = "сентябрь " + year
                        break;
                    case "10":
                        result = "октябрь " + year
                        break;
                    case "11":
                        result = "ноябрь " + year
                        break;
                    case "12":
                        result = "декабрь " + year
                        break;
                    }
                    return result
                }
            }
            ToolButton {
                Layout.alignment: Qt.AlignRight
                //icon.name: "right"
                onClicked: {
                    var d = Date.fromLocaleString(grid.locale, monthYearLabel.monthYear, dateFormat)
                    d.setMonth(d.getMonth() + 1)
                    monthYearLabel.monthYear = d.toLocaleString(grid.locale, dateFormat)
                }
            }
        }

        DayOfWeekRow {
            locale: grid.locale
            Layout.fillWidth: true

            delegate: Text {
                text: model.shortName
//                color: workTimeClient.theme === 0 ? "#EE82EE" : "#BA55D3"
                color: "#BA55D3"
                font: grid.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        MonthGrid {
            id: grid
            month: Date.fromLocaleString(grid.locale, monthYearLabel.monthYear, dateFormat).getMonth()
            year: Date.fromLocaleString(grid.locale, monthYearLabel.monthYear, dateFormat).getFullYear()
            locale: Qt.locale("ru_RU")
            Layout.fillWidth: true
            font.bold: true

            property date selectedDate

            delegate: ToolButton {
                display: AbstractButton.TextOnly
                opacity: model.month === grid.month ? 1 : 0.3
                font: grid.font
                text: model.day
                down: (model.day === selectedDate.getDate() && model.month === selectedDate.getMonth() && model.year === selectedDate.getFullYear()) ? true : false
                onClicked: {
                    selectedDate = Date.fromLocaleString(grid.locale, model.day + "." + (model.month + 1) + "." + model.year, "d.M.yyyy")
                    accept()
                }
            }
        }
    }
}

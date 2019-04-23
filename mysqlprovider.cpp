#include "mysqlprovider.h"
#include <QtSql>
#include "testmodel.h"


MySQLProvider::MySQLProvider()
{

}

QString MySQLProvider::hostname() const
{
    return m_hostname;
}

void MySQLProvider::setHostname(const QString &hostname)
{
    if (m_hostname != hostname) {
        m_hostname = hostname;
        emit hostnameChanged();
    }
}

quint16 MySQLProvider::port() const
{
    return m_port;
}

void MySQLProvider::setPort(const quint16 &port)
{
    if (m_port != port) {
        m_port = port;
        emit portChanged();
    }
}

QString MySQLProvider::dbName() const
{
    return m_dbName;
}

void MySQLProvider::setDbName(const QString &dbName)
{
    if (m_dbName != dbName) {
        m_dbName = dbName;
        emit dbNameChanged();
    }
}

QString MySQLProvider::login() const
{
    return m_login;
}

void MySQLProvider::setLogin(const QString &login)
{
    if (m_login != login) {
        m_login = login;
        emit loginChanged();
    }
}

QString MySQLProvider::password() const
{
    return m_password;
}

void MySQLProvider::setPassword(const QString &password)
{
    if (m_password != password) {
        m_password = password;
        emit passwordChanged();
    }
}

QString MySQLProvider::connect(eDbType type, QString connectionName)
{
    QString driverName;
    switch (type) {
    case DB_TYPE_MYSQL:
        driverName = "QMYSQL";
        break;
    case DB_TYPE_SQLITE:
        driverName = "QSQLITE";
        break;
    default:
        qDebug() << "Error: Unknowofdsf";
        return QString();

    }
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE", connectionName);
    db.setHostName(m_hostname);
    db.setPort(m_port);
    db.setUserName(m_login);
    db.setPassword(m_password);
    db.setDatabaseName(m_dbName);
    if (!db.open()) {
        qDebug() << "DB open error:" << db.lastError().text();
        return QString();
    }
    return db.connectionName();
}

void MySQLProvider::disconnect(QString connectionName)
{
    {
        QSqlDatabase db = QSqlDatabase::database(connectionName);
        db.close();
    }
    QSqlDatabase::removeDatabase(connectionName);
}

void MySQLProvider::createTable(QString query, QString connectionName)
{
    QSqlQuery sqlQuery(QSqlDatabase::database(connectionName));
    if (!sqlQuery.exec(query)) {
        qDebug() << "Query exec error:" << sqlQuery.lastError().text();
        qDebug() << "Query:" << query;
    }
}

int MySQLProvider::execSelectSqlQuery(QString query, QString connectionName)
{
    QSqlQuery sqlQuery(QSqlDatabase::database(connectionName));
    if (!sqlQuery.exec(query)) {
        qDebug() << "Query exec error:" << sqlQuery.lastError().text();
        qDebug() << "Query:" << query;
        return -1;
    }

    int countString = 0;

    while (sqlQuery.next()) {
        // Обработка запроса
        // SELECT FIO, DATE, ID
        // FROM USERS
        QString result;
        for (int i = 0; i < sqlQuery.size(); ++i) {
            if (sqlQuery.value(i).canConvert(QMetaType::QString))
                result += sqlQuery.value(i).toString();
            else if (sqlQuery.value(i).canConvert(QMetaType::QDateTime))
                result += sqlQuery.value(i).toDateTime().toString("dd.MM.yyyy hh:mm:ss");
            else if (sqlQuery.value(i).canConvert(QMetaType::Int))
                result += sqlQuery.value(i).toInt();
            result += " ";
        }
        qDebug() << result;
        ++countString;
        //qDebug() << sqlQuery.value("FIO").toString();
        //qDebug() << sqlQuery.value(1).toDateTime().toString("dd.MM.yyyy hh:mm:ss"); // Обращение к DATE
        //qDebug() << sqlQuery.value(2).toUInt();
    }

    sqlQuery.finish();

    return countString;
}

void MySQLProvider::execInsertSqlQuery(QString query, QString connectionName)
{
    qDebug() << query;
    QSqlQuery sqlQuery(QSqlDatabase::database(connectionName));
    if (!sqlQuery.exec(query)) {
        qDebug() << "Query exec error:" << sqlQuery.lastError().text();
        return;
    }
    // INSERT INTO USERS (FIO, DATE, ID) VALUES ('Иванов Иван Иванович', toDate('21.02.2019', 'dd.MM.yyyy'), 44)

    sqlQuery.finish();
}

void MySQLProvider::execUpdateSqlQuery(QString query, QString connectionName)
{
    qDebug() << query;
    QSqlQuery sqlQuery(QSqlDatabase::database(connectionName));
    if (!sqlQuery.exec(query)) {
        qDebug() << "Query exec error:" << sqlQuery.lastError().text();
        return;
    }
    // INSERT INTO USERS (FIO, DATE, ID) VALUES ('Иванов Иван Иванович', toDate('21.02.2019', 'dd.MM.yyyy'), 44)

    sqlQuery.finish();
}

QList<QObject *> MySQLProvider::getUsers(QString connectionName)
{
    QSqlQuery sqlQuery(QSqlDatabase::database(connectionName));
    if (!sqlQuery.exec("SELECT FIO, reg_date, ID FROM USERS")) {
        qDebug() << "Query exec error:" << sqlQuery.lastError().text();
        return QList<QObject *>();
    }

    QList<QObject *> resultList;

    while (sqlQuery.next()) {
        // Обработка запроса
        // SELECT FIO, DATE, ID
        // FROM USERS

        QString fio = sqlQuery.value("FIO").toString();
        QString date = sqlQuery.value("reg_date").toDateTime().toString("dd.MM.yyyy hh:mm:ss");
        int idUser = sqlQuery.value("ID").toUInt();
        resultList.append(new TestModel(fio, date, idUser));
        //qDebug() << sqlQuery.value("FIO").toString();
        //qDebug() << sqlQuery.value(1).toDateTime().toString("dd.MM.yyyy hh:mm:ss"); // Обращение к DATE
        //qDebug() << sqlQuery.value(2).toUInt();
    }

    sqlQuery.finish();

    return resultList;
}

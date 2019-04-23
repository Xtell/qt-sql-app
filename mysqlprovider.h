#ifndef MYSQLPROVIDER_H
#define MYSQLPROVIDER_H

#include <QObject>


class MySQLProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString hostname READ hostname WRITE setHostname NOTIFY hostnameChanged)
    Q_PROPERTY(quint32 port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QString dbName READ dbName WRITE setDbName NOTIFY dbNameChanged)
    Q_PROPERTY(QString login READ login WRITE setLogin NOTIFY loginChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    Q_ENUMS(eDbType)
public:
    MySQLProvider();
    enum eDbType {
        DB_TYPE_MYSQL = 0,
        DB_TYPE_SQLITE = 1
    };

    QString hostname() const;
    void setHostname(const QString &hostname);
    quint16 port() const;
    void setPort(const quint16 &port);
    QString dbName() const;
    void setDbName(const QString &dbName);
    QString login() const;
    void setLogin(const QString &login);
    QString password() const;
    void setPassword(const QString &password);

signals:
    void hostnameChanged();
    void portChanged();
    void dbNameChanged();
    void loginChanged();
    void passwordChanged();

public slots:
    QString connect(eDbType type,QString connectionName);
    void disconnect(QString connectionName);
    void createTable(QString query, QString connectionName);
    int execSelectSqlQuery(QString query, QString connectionName);
    void execInsertSqlQuery(QString query, QString connectionName);
    void execUpdateSqlQuery(QString query, QString connectionName);
    QList<QObject *> getUsers(QString connectionName);

private:
    QString m_hostname;
    quint16 m_port;
    QString m_dbName;
    QString m_login;
    QString m_password;
};

#endif // MYSQLPROVIDER_H

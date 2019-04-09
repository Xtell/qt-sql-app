#ifndef TESTMODEL_H
#define TESTMODEL_H

#include <QObject>


class TestModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fio READ fio WRITE setFio NOTIFY fioChanged)
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(int idUser READ idUser WRITE setIdUser NOTIFY idUserChanged)
public:
    TestModel(QString fio_, QString date_, int idUser_, QObject *parent = nullptr);

    QString fio() const;
    void setFio(const QString &fio);
    QString date() const;
    void setDate(const QString &date);
    int idUser() const;
    void setIdUser(int idUser);

signals:
    void fioChanged();
    void dateChanged();
    void idUserChanged();

private:
    QString m_fio;
    QString m_date;
    int m_idUser;
};

#endif // TESTMODEL_H

#include "testmodel.h"
#include <QVariant>


TestModel::TestModel(QString fio_, QString date_, int idUser_, QObject *parent):
    QObject(parent),
    m_fio(fio_),
    m_date(date_),
    m_idUser(idUser_)
{
    property("fio").toString();
}

QString TestModel::fio() const
{
    return m_fio;
}

void TestModel::setFio(const QString &fio)
{
    m_fio = fio;
    emit fioChanged();
}

QString TestModel::date() const
{
    return m_date;
}

void TestModel::setDate(const QString &date)
{
    m_date = date;
    emit dateChanged();
}

int TestModel::idUser() const
{
    return m_idUser;
}

void TestModel::setIdUser(int idUser)
{
    m_idUser = idUser;
    emit idUserChanged();
}

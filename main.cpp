#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "mysqlprovider.h"


int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseDesktopOpenGL);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<MySQLProvider>("MySQLProvider", 1, 0, "MySQLProvider");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

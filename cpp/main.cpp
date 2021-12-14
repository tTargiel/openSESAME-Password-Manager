#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "authenticate.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

//    QGuiApplication app(argc, argv);

//    app.setWindowIcon(QIcon(":/images/logo/openSESAME.ico"));

//    QQmlApplicationEngine engine;
//    const QUrl url(QStringLiteral("qrc:/qml/login.qml"));
//    QObject::connect(
//        &engine, &QQmlApplicationEngine::objectCreated,
//        &app, [url](QObject *obj, const QUrl &objUrl)
//        {
//            if (!obj && url == objUrl)
//                QCoreApplication::exit(-1);
//        },
//        Qt::QueuedConnection);
//    engine.load(url);

//    return app.exec();
    
    // load login window
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    app.setWindowIcon(QIcon(":/images/logo/openSESAME.ico"));

    Authenticate authenticate;
    engine.rootContext()->setContextProperty("authenticate", &authenticate);

    engine.load(QUrl(QStringLiteral("qrc:/qml/login.qml")));
    if (engine.rootObjects().isEmpty())
    {
        QCoreApplication::exit(-1);
    }

    return app.exec();
    // end
}

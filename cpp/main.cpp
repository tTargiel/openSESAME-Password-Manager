#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "authenticate.h"
#include "myglobalobject.h"
#include "vaultfile.h"

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
    engine.rootContext()->setContextProperty("_authenticate", &authenticate);

    // add global C++ object to the QML context as a property
    /*MyGlobalObject* myGlobalObject = new MyGlobalObject();
    myGlobalObject->doSomething("TEXT FROM C++");
    engine.rootContext()->setContextProperty("_myGlobalObject", myGlobalObject);*/ // the object will be available in QML with name "_myGlobalObject"

    VaultFile* vaultFile = new VaultFile();
    engine.rootContext()->setContextProperty("_vaultFile", vaultFile); // the object will be available in QML with name "_vaultFile"

    engine.load(QUrl(QStringLiteral("qrc:/qml/login.qml")));
    if (engine.rootObjects().isEmpty())
    {
        QCoreApplication::exit(-1);
    }

    return app.exec();
    // end
}

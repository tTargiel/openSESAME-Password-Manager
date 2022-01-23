#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "authenticate.h"
#include "myglobalobject.h"
#include "vaultfile.h"
#include "provider.h"
#include "data_item.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

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

    qmlRegisterUncreatableType<app::DataItem>( "App", 1, 0, "DataItem", "interface" );
    qmlRegisterUncreatableType<app::QObjectListModel_DataItem>( "App", 1, 0, "ListModel_DataItem", "interface" );

    qmlRegisterType<app::Provider>( "App", 1, 0, "Provider" );

    engine.load(QUrl(QStringLiteral("qrc:/qml/login.qml")));
    if (engine.rootObjects().isEmpty())
    {
        QCoreApplication::exit(-1);
    }

    return app.exec();
    // end
}

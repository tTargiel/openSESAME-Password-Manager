#include "authenticate.h"

Authenticate::Authenticate(QObject *parent) : QObject(parent)
{

}

void Authenticate::buttonClicked(const QString &username, const QString &password)
{
    if (username == "JohnDoe" && password == "password1")
    {
//        qDebug() << "Authentication OK!";
        emit loginState("Authentication OK!");
        emit visibilityChanged(true);
    }
    else
    {
//        qDebug() << "Authentication failed!";
        emit loginState("Authentication failed!");
    }
}

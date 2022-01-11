#include "authenticate.h"
#include "vaultfile.h"
#include <QDebug>

Authenticate::Authenticate(QObject *parent) : QObject(parent)
{

}

void Authenticate::buttonClicked(const QString &username, const QString &password)
{
    if (username == "JohnDoe" && password == "password1")
    {
//        qDebug() << "Authentication OK!";
        VaultFile vaultFile;
        vaultFile.loadFile("./.vaults/" + username + ".json");
        emit loginState("Authentication OK!");
        emit visibilityChanged(true);
    }
    else
    {
//        qDebug() << "Authentication failed!";
        emit loginState("Authentication failed!");
    }
}

#include "authenticate.h"
#include "vaultfile.h"
#include <QDebug>
#include <QFile>
#include "provider.h"

Authenticate::Authenticate(QObject *parent) : QObject(parent)
{

}

void Authenticate::buttonClicked(const QString &username, const QString &password)
{
    QString filePath = "./.vaults/" + username + ".json";

    QFile fileContents(filePath);

    if (!fileContents.open(QIODevice::ReadOnly))
    {
        emit loginState("This user doesn't exist!");
    }
    else
    {
        QTextStream fileTextStream(&fileContents);
        QString jsonString = fileTextStream.readAll();
        fileContents.close();
        QByteArray jsonBytesForm = jsonString.toLocal8Bit();

        QString verify;
        char isEncrypted;
        for (int i = 4; i < 22; ++i) {
            isEncrypted = jsonBytesForm.at(i);
            verify += isEncrypted;
        }

        if (verify == "\"encrypted\": false") {
//            qDebug() << verify << "\n" << jsonString << "\n" << jsonBytesForm;
            emit loginState("Authentication OK!");
            emit visibilityChanged(true);

            app::Provider pro;
            pro.addItem();
        }
        else
        {
            emit loginState("Authentication failed!");
        }
    }
}

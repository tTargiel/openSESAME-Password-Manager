#include "authenticate.h"
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include "provider.h"

Authenticate::Authenticate(QObject *parent) : QObject(parent)
{
    // perform custom initialization steps here
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

            this->loadData(jsonBytesForm);
        }
        else
        {
            emit loginState("Authentication failed!");
        }
    }
}

void Authenticate::loadData(QByteArray jsonBytesForm)
{
    auto jsonDocument = QJsonDocument::fromJson(jsonBytesForm);

    if (jsonDocument.isNull())
    {
        qDebug() << "Failed to create JSON document";
        exit(2);
    }

    if (!jsonDocument.isObject())
    {
        qDebug() << "JSON is not an object";
        exit(3);
    }

    QJsonObject jsonObject = jsonDocument.object();

    if (jsonObject.isEmpty())
    {
        qDebug() << "JSON object is empty";
        exit(4);
    }

    QJsonObject root_obj = jsonDocument.object();
    QJsonArray root_array = root_obj["items"].toArray();
    for (int i = 0; i < root_array.size(); ++i)
    {
        QJsonObject obj = root_array[i].toObject();
        QVariantMap inv_list = obj.toVariantMap();
        QVariantMap stat_map = inv_list["login"].toMap();
        QStringList key_list = stat_map.keys();
        for (int i = 0; i < key_list.count(); ++i)
        {
            QString key = key_list.at(i);
            QString stat_val = stat_map[key].toString();
            qDebug() << key << ": " << stat_val;
        }
    }

    //    // when the work is done, we can trigger the loadingFinished() signal and react anyhwhere in C++ or QML
    //    emit loadingFinished(json);
}

void Authenticate::load()
{

}

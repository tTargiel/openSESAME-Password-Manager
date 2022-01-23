#include "vaultfile.h"
#include "provider.h"
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

VaultFile::VaultFile()
{
    // perform custom initialization steps here
}

void VaultFile::loadFile(const QString &filePath)
{
//    this->load(filePath);
}

void VaultFile::load(const QString &filePath)
{
    QFile fileContents(filePath);

    if (!fileContents.open(QIODevice::ReadOnly))
    {
        qDebug() << "Failed to open " << filePath;
        exit(1);
    }

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
    qDebug() << verify;

    if (verify == "\"encrypted\": false") {
        qDebug() << "File is now in decrypted state";
    }

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
            app::Provider pro;
            pro.addItem();
        }
    }

    //    // when the work is done, we can trigger the loadingFinished() signal and react anyhwhere in C++ or QML
    //    emit loadingFinished(json);
}

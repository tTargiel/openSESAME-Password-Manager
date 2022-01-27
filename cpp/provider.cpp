#include "provider.h"
#include <QDebug>

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QClipboard>
#include <QGuiApplication>

#include <iostream>
#include <string>
#include <vector>

using std::cout; using std::endl;
using std::vector; using std::string;

struct loginData {
    QString url;
    QString user;
    QString password;
};

vector<loginData> lD;

string usr = "";
string pass = "";

namespace app
{
Provider::Provider(QObject *parent) : QObject(parent)
{
}

void Provider::addItem(const QString &stat_val2, const QString &stat_val3, const QString &stat_val)
{
    auto item = QSharedPointer<DataItem>(new DataItem(stat_val2, stat_val3, stat_val));
    m_items << item;
    //    qDebug() << m_items;
}

void Provider::addItems21()
{
    QList<QSharedPointer<DataItem>> source;
    source << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem())
           << QSharedPointer<DataItem>(new DataItem());
    m_items << source;
}

void Provider::changeItem()
{
    if (m_items.count() == 0)
        return;

    int index = m_items.count() / 2;
    m_items.replace(index, QSharedPointer<DataItem>(new DataItem("https://website.test/", "Test User", "Test Password")));
}

void Provider::removeItem()
{
    if (m_items.count() == 0)
        return;

    int index = m_items.count() / 2;
    m_items.removeAt(index);
}

void Provider::removeId(int index)
{
    if (m_items.count() == 0)
        return;

    m_items.removeAt(index);
    lD.erase(lD.begin() + index);
}

void Provider::removeAll()
{
    if (m_items.count() == 0)
        return;

    m_items.clear();
    lD.clear();
}

void Provider::copyUser(int index)
{
    if (m_items.count() == 0)
        return;

    cout << lD[index].user.toStdString() << endl;
    this->toClipboard(lD[index].user);
}

void Provider::copyPassword(int index)
{
    if (m_items.count() == 0)
        return;

    cout << lD[index].password.toStdString() << endl;
    this->toClipboard(lD[index].password);
}

void Provider::addItemP(const QString &stat_val2, const QString &stat_val3, const QString &stat_val)
{
    this->addItem(stat_val2, "********", "************");
    lD.push_back({stat_val2, stat_val3, stat_val});
}

void Provider::buttonClicked(const QString &username, const QString &password)
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
            usr = username.toStdString();
            pass = password.toStdString();

            this->loadData(jsonBytesForm);
            //            qDebug() << verify << "\n" << jsonString << "\n" << jsonBytesForm;
            emit loginState("Authentication OK!");
            emit visibilityChanged(true);
        }
        else
        {
            emit loginState("Authentication failed!");
        }
    }
}

void Provider::loadData(QByteArray jsonBytesForm)
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
        for (int i = 0; i < key_list.count(); i+=3)
        {
            QString key = key_list.at(i);
            QString stat_val = stat_map[key].toString();

            QString key2 = key_list.at(i+1);
            QString stat_val2 = stat_map[key2].toString();

            QString key3 = key_list.at(i+2);
            QString stat_val3 = stat_map[key3].toString();

            //            qDebug() << key << ": " << stat_val;

            //            this->addItem(stat_val, stat_val2, stat_val3);

            //            lD.push_back({stat_val2.toStdString(), stat_val3.toStdString(), stat_val.toStdString()});
            lD.push_back({stat_val2, stat_val3, stat_val});

            //            qDebug("Added new element to QList\n");
        }

        //        for (const auto &arr : lD) {
        //            cout << "URL: " << arr.url << endl
        //                 << "user: " << arr.user << endl
        //                 << "password: " << arr.password << endl;
        //        }
    }


    //    // when the work is done, we can trigger the loadingFinished() signal and react anyhwhere in C++ or QML
    //    emit loadingFinished(root_array);
}

void Provider::load()
{
    //    qDebug() << m_items;
    //    for (const auto &arr : lD) {
    //        cout << "URL: " << arr.url << endl
    //             << "user: " << arr.user << endl
    //             << "password: " << arr.password << endl;
    //    }

    m_items.clear();

    for (const auto &arr : lD) {
        this->addItem(arr.url, "********", "************");
    }
}

void Provider::toClipboard(QString textToCopy)
{
    QClipboard *p_Clipboard = QGuiApplication::clipboard();
    p_Clipboard->setText(textToCopy);
}

QObjectListModel_DataItem *Provider::items()
{
    return &m_items;
}
}

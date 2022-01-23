#pragma once

#include "qobject_list_model.h"
#include <QDebug>
#include <QObject>
#include <QString>

namespace app
{
    // Some sort of data structure as a collection element
    class DataItem : public QObject
    {
        Q_OBJECT
        Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY changed)
        Q_PROPERTY(QString user READ user WRITE setUser NOTIFY changed)
        Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY changed)

    public:
        explicit DataItem(QString url = "https://example.com/", QString user = "********", QString password = "************");

        QString url();
        QString user();
        QString password();

        void setUrl(const QString &url);
        void setUser(const QString &user);
        void setPassword(const QString &password);

        // Example of some business logic that changes internal model state.
        Q_INVOKABLE void doubleId();

    signals:
        void changed();

    private:
        QString m_url;
        QString m_user;
        QString m_password;
    };
}

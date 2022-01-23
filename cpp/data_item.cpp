#include "data_item.h"
#include <QDebug>

namespace app
{
    DataItem::DataItem(QString url, QString user, QString password)
        : QObject(NULL), m_url(url), m_user(user), m_password(password)
    {
    }

    QString DataItem::url()
    {
        return m_url;
    }

    void DataItem::setUrl(const QString &u)
    {
        if (u != m_url)
        {
            m_url = u;
            emit changed();
        }
    }

    QString DataItem::user()
    {
        return m_user;
    }

    void DataItem::setUser(const QString &us)
    {
        if (us != m_user)
        {
            m_user = us;
            emit changed();
        }
    }

    QString DataItem::password()
    {
        return m_password;
    }

    void DataItem::setPassword(const QString &pass)
    {
        if (pass != m_password)
        {
            m_password = pass;
            emit changed();
        }
    }

    void DataItem::doubleId()
    {
        m_password = "***** ***";
        emit changed();
    }
}

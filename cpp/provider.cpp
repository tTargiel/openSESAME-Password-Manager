#include "provider.h"
#include <QDebug>

namespace app
{
Provider::Provider(QObject *parent) : QObject(parent)
{
}

void Provider::addItem()
{
    auto item = QSharedPointer<DataItem>(new DataItem());
    m_items << item;
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
}

QObjectListModel_DataItem *Provider::items()
{
    return &m_items;
}
}

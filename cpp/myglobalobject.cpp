#include "myglobalobject.h"
#include <QDebug>

MyGlobalObject::MyGlobalObject() : m_counter(0)
{
    // perform custom initialization steps here
}

void MyGlobalObject::doSomething(const QString &text)
{
    qDebug() << "MyGlobalObject doSomething called with" << text;
}

// getter
int MyGlobalObject::counter() const
{
    return m_counter;
}

// setter
void MyGlobalObject::setCounter(int value)
{
    if (m_counter != value)
    {
        m_counter = value;
        emit counterChanged(); // trigger signal of counter change
    }
}

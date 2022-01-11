#ifndef MYGLOBALOBJECT_H
#define MYGLOBALOBJECT_H

#include <QObject>

class MyGlobalObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int counter READ counter WRITE setCounter NOTIFY counterChanged) // this makes counter available as a QML property

public:
    MyGlobalObject();
    int counter() const; // getter
    void setCounter(int value); // setter

private:
    int m_counter; // initialize private variable (with default value) that can be only modified if getter is used

signals: // signals are sent from C++ to QML
    void counterChanged();

public slots: // slots are public methods available in QML
    void doSomething(const QString &text);
};

#endif // MYGLOBALOBJECT_H

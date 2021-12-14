#ifndef AUTHENTICATE_H
#define AUTHENTICATE_H

#include <QDebug>
#include <QObject>

class Authenticate : public QObject
{
    Q_OBJECT

public:
    explicit Authenticate(QObject *parent = nullptr);

signals:
    void visibilityChanged(bool vis);
    void loginState(QString loginMessage);

public slots:
    void buttonClicked(const QString &username, const QString &password);
};

#endif // AUTHENTICATE_H

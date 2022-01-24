#ifndef AUTHENTICATE_H
#define AUTHENTICATE_H

#include <QObject>

class Authenticate : public QObject
{
    Q_OBJECT

public:
    explicit Authenticate(QObject *parent = nullptr);

    Q_INVOKABLE void load();

private:
    void loadData(QByteArray jsonBytesForm);

signals:
    void visibilityChanged(bool vis);
    void loginState(QString loginMessage);

public slots:
    void buttonClicked(const QString &username, const QString &password);
};

#endif // AUTHENTICATE_H

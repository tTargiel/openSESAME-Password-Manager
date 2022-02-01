#ifndef GENERATOR_H
#define GENERATOR_H

#include <QObject>

class Generator : public QObject
{
    Q_OBJECT

public:
    explicit Generator(QObject *parent = nullptr);

public slots:
    void buttonClicked(int n, bool a, bool b, bool c, bool d);

signals:
    void generatedPassword(QString genPass);
};

#endif // GENERATOR_H

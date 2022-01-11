#ifndef VAULTFILE_H
#define VAULTFILE_H

#include <QObject>

class VaultFile : public QObject
{
    Q_OBJECT

public:
    VaultFile();
    void loadFile(const QString &filePath); // starts loading file containing encrypted user data in load() function

private:
    void load(const QString &filePath); // method for loading file contents

signals: // signals are sent from C++ to QML
    void loadingFinished(QString json); // triggered after file got fully loaded in load() function

public slots: // slots are public methods available in QML
};

#endif // VAULTFILE_H

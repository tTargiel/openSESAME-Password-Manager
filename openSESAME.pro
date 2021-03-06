QT += quick

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        cpp/data_item.cpp \
        cpp/generator.cpp \
        cpp/main.cpp \
        cpp/myglobalobject.cpp \
        cpp/provider.cpp \
        cpp/qaesencryption.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = qml/

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    cpp/data_item.h \
    cpp/generator.h \
    cpp/myglobalobject.h \
    cpp/provider.h \
    cpp/qobject_list_model.h \
    cpp/qaesencryption.h

# Shared library to executable
QMAKE_LFLAGS += -no-pie

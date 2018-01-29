QT += quick sql multimedia
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    source/controller/main_controller.cpp \
    source/model/db.cpp \
    source/model/inventory.cpp \
    source/model/item.cpp \
    source/utility/exception.cpp \
    source/view/main_form.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    source/controller/main_controller.h \
    source/model/cell.h \
    source/model/db.h \
    source/model/inventory.h \
    source/model/item.h \
    source/utility/pattern/initializable.h \
    source/utility/pattern/non_copyable.h \
    source/utility/pattern/non_movable.h \
    source/utility/pattern/singleton.h \
    source/utility/assert.h \
    source/utility/exception.h \
    source/utility/smart_ptr.h \
    source/view/main_form.h

INCLUDEPATH += source/

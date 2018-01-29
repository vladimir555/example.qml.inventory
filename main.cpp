#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "controller/main_controller.h"
#include "view/main_form.h"


using controller::MainController;


#include <QDebug>
int main(int argc, char *argv[]) {

#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);


    MainController::instance().config.inventory_size = QSize(3, 3);
    MainController::instance().initialize();

    view::MainForm main_form;

    auto result = app.exec();

    MainController::instance().finalize();

    return result;
}

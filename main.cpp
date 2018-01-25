#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "controller/main_controller.h"
#include "view/main_form.h"

using controller::MainController;


//struct T {
//    int i;
//};

//QVector<T> v;

//T &f() {
//    return v[1];
//}


#include <QDebug>
int main(int argc, char *argv[]) {
//    v.push_back({1});
//    v.push_back({2});
//    qDebug() << v[1].i;
//    auto &i = f();
//    i.i++;
//    qDebug() << v[1].i;
//    f().i++;
//    qDebug() << v[1].i;
//    return 1;


#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);


//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    if (engine.rootObjects().isEmpty())
//        return -1;

    MainController::instance().config.inventory_size = QSize(3, 3);
    MainController::instance().initialize();

    view::MainForm main_form;

    auto result = app.exec();

    MainController::instance().finalize();

    return result;
}

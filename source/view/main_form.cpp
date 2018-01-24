#include "main_form.h"

#include "controller/main_controller.h"

#include <QDebug>
#include <QQmlContext>
#include <QJsonObject>
#include <QJsonDocument>


using model::TCell;
using controller::MainController;


namespace view {


MainForm::MainForm()
:
    m_qml_engine(QUrl("qrc:/main.qml"))
{
//    auto child = m_qml_engine.findChildren("window");
//    child->setProperty("form", this);
//    m_qml_engine.rootContext()
//    m_qml_engine.set
    m_qml_engine.rootContext()->setContextProperty("form", this);
}


QString MainForm::onMoveCell(const QSize &from, const QSize &to) {
    QJsonObject result;
    auto cell       = MainController::instance().moveCell(from, to);

    if (cell.item)
        result["url"] = cell.item->getIconPath();
    else
        result["url"] = "";

    result["count"] = QString::number(cell.count);

    return QJsonDocument(result).toJson();
}


TCell MainForm::onBiteCell(QSize const &pos) {
    return MainController::instance().bite(pos);
}


} // view

#include "main_form.h"

#include "controller/main_controller.h"

#include <QDebug>
#include <QQmlContext>
#include <QJsonObject>
#include <QJsonDocument>
#include <QQuickItem>


using model::TCell;
using controller::MainController;


namespace view {


MainForm::MainForm()
:
    m_qml_engine(QUrl("qrc:/main.qml"))
{
    m_qml_engine.rootContext()->setContextProperty("form", this);
}


QString MainForm::onMoveCell(const QSize &from, const QSize &to) {
    return convertCellToJson(MainController::instance().moveCell(from, to));
}


QString MainForm::onBiteCell(QSize const &pos) {
    return convertCellToJson(MainController::instance().bite(pos));
}


QString MainForm::onGetCell(QSize const &pos) {
    return convertCellToJson(MainController::instance().get(pos));
}


QString MainForm::convertCellToJson(model::TCell const &cell) {
    QJsonObject result;

    if (cell.item)
        result["url"] = cell.item->getIconPath();
    else
        result["url"] = "";

    result["count"] = QString::number(cell.count);

    return QJsonDocument(result).toJson();
}


} // view

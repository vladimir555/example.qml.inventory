#include "main_form.h"

#include "controller/main_controller.h"


using model::TCell;
using controller::MainController;


namespace view {


MainForm::MainForm()
{}


TCell MainForm::onMoveCell(const QSize &from, const QSize &to) {
    return MainController::instance().moveCell(from, to);
}


TCell MainForm::onBiteCell(QSize const &pos) {
    return MainController::instance().bite(pos);
}


} // view

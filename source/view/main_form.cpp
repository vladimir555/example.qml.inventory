#include "main_form.h"


using model::TCell;


namespace view {


MainForm::MainForm()
{}


TCell MainForm::onMoveCell(const QSize &from, const QSize &to) {
//    return inventory()->moveCell(from, to);
}


TCell MainForm::onBiteCell(QSize const &pos) {
//    return inventory()->get(pos);
}


} // view

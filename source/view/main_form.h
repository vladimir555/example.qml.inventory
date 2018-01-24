#ifndef MAIN_FORM_H
#define MAIN_FORM_H

#include <QObject>

#include "model/cell.h"


namespace view {


class MainForm: public QObject {
    Q_OBJECT
public:
    MainForm();
    virtual ~MainForm() = default;

public slots:
    model::TCell onMoveCell(QSize const &from, QSize const &to);
    model::TCell onBiteCell(QSize const &pos);
};


} // view


#endif // MAIN_FORM_H

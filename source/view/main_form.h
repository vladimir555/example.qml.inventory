#ifndef MAIN_FORM_H
#define MAIN_FORM_H


#include <QObject>
#include <QQmlApplicationEngine>
#include <QString>

#include "model/cell.h"


namespace view {


class MainForm: public QObject {
    Q_OBJECT
public:
    MainForm();
    virtual ~MainForm() = default;

public slots:
    Q_INVOKABLE QString onMoveCell(QSize const &from, QSize const &to);
    Q_INVOKABLE QString onBiteCell(QSize const &pos);
    Q_INVOKABLE QString onGetCell(QSize const &pos);

private:
    static QString convertCellToJson(model::TCell const &cell);
    QQmlApplicationEngine m_qml_engine;
};


} // view


#endif // MAIN_FORM_H

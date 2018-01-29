#include "controller/main_controller.h"
#include "utility/exception.h"
#include "utility/assert.h"

#include <QDebug>
#include <QSound>


using utility::Exception;
using model::DB;
using model::CInventory;
using model::IInventory;
using model::TCell;


namespace controller {


void MainController::initialize() {
    QMutexLocker l(&m_mutex);
    try {
        if (!m_db) {
            m_db = DB::create();
            m_db->initialize();
        }

        if (!m_inventory) {
            m_inventory = CInventory::create(config.inventory_size, m_db);
            m_inventory->initialize();
        }
    } catch (Exception const &e) {
//        QMessageBox mbox;
//        mbox.critical(0, "Fatal error", e.what());
        throw;
    }
}


void MainController::finalize() {
    QMutexLocker l(&m_mutex);
    try {
        if (m_inventory)
            m_inventory->finalize();
        if (m_db)
            m_db->finalize();

    } catch (Exception const &e) {
//        QMessageBox mbox;
//        mbox.critical(0, "Fatal error", e.what());
    }
}


TCell MainController::moveCell(QSize const &from, QSize const &to) {
    QMutexLocker l(&m_mutex);
    return inventory()->moveCell(from, to);
}


TCell MainController::get(QSize const &pos) {
    QMutexLocker l(&m_mutex);
    return inventory()->get(pos);
}


void MainController::set(QSize const &pos, TCell const &cell) {
    QMutexLocker l(&m_mutex);
    inventory()->set(pos, cell);
}


TCell MainController::bite(QSize const &pos) {
    QMutexLocker l(&m_mutex);
    auto cell = inventory()->bite(pos);
    QSound::play(":/sound/bite");
    return cell;
}


void MainController::inc(QSize const &pos) {
    QMutexLocker l(&m_mutex);
    auto cell = inventory()->get(pos);
    cell.count++;
    inventory()->set(pos, cell);
}


IInventory::TSharedPtr MainController::inventory() {
    return utility::assertExists(m_inventory, "inventory not initialized");
}


} // controller

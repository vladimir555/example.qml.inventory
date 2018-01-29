#ifndef ENGINE_H
#define ENGINE_H


#include <QMutex>
#include <QObject>

#include "utility/pattern/singleton.h"
#include "utility/pattern/initializable.h"

#include "model/db.h"
#include "model/inventory.h"


namespace controller {


class MainController:
    public utility::pattern::IInitializable,
    public utility::pattern::Singleton<MainController>,
    public model::IInventory
{
public:
    MainController() = default;
    virtual ~MainController() = default;

    struct TConfig {
        QSize inventory_size;
    } config;

    void initialize() override;
    void finalize() override;

    model::TCell moveCell   (QSize const &from, QSize const &to) override;
    model::TCell get        (QSize const &pos) override;
    void         set        (QSize const &pos, model::TCell const &cell) override;
    model::TCell bite       (QSize const &pos) override;
    void         reset      () override;

    void         inc        (QSize const &pos);

private:
    friend class utility::pattern::Singleton<MainController>;

    IInventory::TSharedPtr          inventory();

    QMutex                          m_mutex;
    model::DB::TSharedPtr           m_db;
    model::CInventory::TSharedPtr   m_inventory;
};


} // controller


#endif // ENGINE_H

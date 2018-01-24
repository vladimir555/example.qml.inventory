#ifndef CELL_H
#define CELL_H


#include "item.h"


namespace model {


struct TCell {
    Item::TSharedPtr    item;
    int                 count;
};


} // model


#endif // CELL_H

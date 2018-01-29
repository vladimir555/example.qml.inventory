#include "item.h"


namespace model {


Item::Item(Item::TType const &type, QString const &resource)
:
    m_icon_path("image/" + resource),
    m_type(type)
{}


QString Item::getIconPath() const {
    return m_icon_path;
}


Item::TType Item::getType() const {
    return m_type;
}


bool Item::operator== (Item const &item) const {
    return m_type == item.m_type;
}


} // model

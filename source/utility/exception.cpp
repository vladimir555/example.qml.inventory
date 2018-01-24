#include "exception.h"


namespace utility {


Exception::Exception(QString const &message)
:
    m_message(message)
{}


QString Exception::what() const {
    return m_message;
}


} // utility

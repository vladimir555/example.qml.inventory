#ifndef EXCEPTION_H
#define EXCEPTION_H


#include <QString>


namespace utility {


class Exception
{
public:
    Exception(QString const &message);
    ~Exception() = default;
    QString what() const;
private:
    QString m_message;
};


} // utility


#endif // EXCEPTION_H

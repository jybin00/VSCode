#include<stdio.h>
int sum(int n, int acc);
int main(){
    sum(3, 0);
    return 0;
}

int sum(int n, int acc){
    if(n>0)
        return printf("중간과정 : %d\n", sum(n-1, acc + n));
    else
        return acc;
}


#include<stdio.h>

/**
 * main - Prints alphabets in lower case and upper case
 *
 * Return: Always 0 (Success)
*/
int main(void)
{
  char alp[52] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  int i;
  for (i = 0; i < 52; i++)
  {
    putchar(alp[i]);
  }
  putchar('\n');
  return (0);
}

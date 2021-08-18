# include <stdio.h>

int main(int argc, const char **argv) {
  if (argc == 2) {
    printf("Hello, %s!\n", argv[1]);
  } else {
    printf("Hello, World!\n");
  }
	return 0;
}

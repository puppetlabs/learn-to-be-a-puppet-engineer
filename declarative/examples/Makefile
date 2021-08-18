WHO ?= Mina Galić

greet: hello
	./hello "$(WHO)"

hello: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

.PHONY: clean
clean:
	rm -f -- hello

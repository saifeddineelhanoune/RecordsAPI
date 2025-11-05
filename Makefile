NAME = RecordsAPI
SRC = main.go
OBJ = $(SRC:.go=.o)

all: $(NAME)

$(NAME): $(OBJ)
	@go build -o $(NAME) $(SRC)
	@echo "Build complete: $(NAME)"

%.o: %.go
	@touch $@

clean:
	@rm -f $(OBJ)
	@echo "Object files cleaned"

fclean: clean
	@rm -f $(NAME)
	@echo "Binary cleaned"

re: fclean all

.PHONY: all clean fclean re

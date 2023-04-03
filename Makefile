CXX = c++

CXXFLAGS = -Wall -Wextra -Werror -std=c++98 -MMD -MP

NAME = btc

SRCS = main.cpp \
	   BitcoinExchange.cpp \

OBJ_DIR = obj

DEPS_FILES = BitcoinExchange.hpp 

OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:.cpp=.o))

DEPS = $(addprefix $(OBJ_DIR)/, $(DEPS_FILES:.hpp=.d))

RM = rm -f

all: $(NAME)

$(NAME): $(OBJS)
	$(CXX) $(CXXFLAGS) $(OBJS) -o $(NAME)

$(OBJ_DIR)/%.o: %.cpp
	mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

-include $(DEPS)

.PHONY: all clean fclean re
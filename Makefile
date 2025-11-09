# Makefile for ALX Low Level Programming Projects
# Follows Betty coding style guide from Holberton School

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=gnu89
DEBUGFLAGS = -g

# Directories
BUILD_DIR = build
# Automatically find all directories containing .c files (excluding build dir)
SRC_DIRS = $(shell find . -name '*.c' -type f ! -path './$(BUILD_DIR)/*' -exec dirname {} \; | sort -u | sed 's|^\./||')

# Betty linter
BETTY = betty
BETTY_STYLE = betty-style
BETTY_DOC = betty-doc

# Colors for output
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
NC = \033[0m # No Color

# Find all C source files (excluding build directory)
SOURCES = $(shell find . -name '*.c' -type f ! -path './$(BUILD_DIR)/*' 2>/dev/null | sed 's|^\./||')

# Generate target names (without .c extension)
TARGETS = $(patsubst %.c,$(BUILD_DIR)/%,$(SOURCES))

# Default target
.PHONY: all
all: $(BUILD_DIR) $(TARGETS)
	@echo "$(GREEN)Build complete! Binaries are in $(BUILD_DIR)/$(NC)"

# Create build directory
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)
	@for dir in $(SRC_DIRS); do \
		mkdir -p $(BUILD_DIR)/$$dir; \
	done

# Pattern rule to compile C files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "$(YELLOW)Compiling $<...$(NC)"
	$(CC) $(CFLAGS) -c $< -o $@

# Pattern rule to create executables
$(BUILD_DIR)/%: %.c
	@mkdir -p $(dir $@)
	@echo "$(YELLOW)Building $@...$(NC)"
	$(CC) $(CFLAGS) $< -o $@
	@echo "$(GREEN)✓ Built $@$(NC)"

# Build a specific file
.PHONY: build
build:
	@if [ -z "$(FILE)" ]; then \
		echo "$(RED)Error: Please specify FILE=path/to/file.c$(NC)"; \
		exit 1; \
	fi
	@mkdir -p $(BUILD_DIR)/$(dir $(FILE))
	@echo "$(YELLOW)Building $(FILE)...$(NC)"
	$(CC) $(CFLAGS) $(FILE) -o $(BUILD_DIR)/$(basename $(FILE))
	@echo "$(GREEN)✓ Built $(BUILD_DIR)/$(basename $(FILE))$(NC)"

# Run a specific program
.PHONY: run
run:
	@if [ -z "$(FILE)" ]; then \
		echo "$(RED)Error: Please specify FILE=path/to/file.c$(NC)"; \
		exit 1; \
	fi
	@if [ ! -f "$(BUILD_DIR)/$(basename $(FILE))" ]; then \
		echo "$(YELLOW)Building $(FILE) first...$(NC)"; \
		$(MAKE) build FILE=$(FILE); \
	fi
	@echo "$(GREEN)Running $(BUILD_DIR)/$(basename $(FILE))...$(NC)"
	@$(BUILD_DIR)/$(basename $(FILE))

# Build with debug symbols
.PHONY: debug
debug: CFLAGS += $(DEBUGFLAGS)
debug: clean all

# Betty style check
.PHONY: betty
betty:
	@echo "$(YELLOW)Running Betty style checker...$(NC)"
	@if command -v $(BETTY) > /dev/null 2>&1; then \
		for file in $(SOURCES); do \
			echo "Checking $$file..."; \
			$(BETTY) $$file; \
		done; \
		echo "$(GREEN)✓ Betty style check complete$(NC)"; \
	else \
		echo "$(RED)Error: Betty is not installed!$(NC)"; \
		echo "Install from: https://github.com/holbertonschool/Betty"; \
		exit 1; \
	fi

# Betty check for a specific file
.PHONY: betty-file
betty-file:
	@if [ -z "$(FILE)" ]; then \
		echo "$(RED)Error: Please specify FILE=path/to/file.c$(NC)"; \
		exit 1; \
	fi
	@if command -v $(BETTY) > /dev/null 2>&1; then \
		echo "$(YELLOW)Checking $(FILE) with Betty...$(NC)"; \
		$(BETTY) $(FILE); \
		echo "$(GREEN)✓ Betty check complete$(NC)"; \
	else \
		echo "$(RED)Error: Betty is not installed!$(NC)"; \
		echo "Install from: https://github.com/holbertonschool/Betty"; \
		exit 1; \
	fi

# Check if Betty is installed
.PHONY: check-betty
check-betty:
	@if command -v $(BETTY) > /dev/null 2>&1; then \
		echo "$(GREEN)✓ Betty is installed$(NC)"; \
		$(BETTY) --version 2>/dev/null || echo "Betty linter ready"; \
	else \
		echo "$(RED)✗ Betty is not installed$(NC)"; \
		echo ""; \
		echo "To install Betty:"; \
		echo "  git clone https://github.com/holbertonschool/Betty.git /tmp/Betty"; \
		echo "  cd /tmp/Betty && sudo ./install.sh"; \
	fi

# Clean build artifacts
.PHONY: clean
clean:
	@echo "$(YELLOW)Cleaning build directory...$(NC)"
	@rm -rf $(BUILD_DIR)
	@echo "$(GREEN)✓ Clean complete$(NC)"

# Full clean including temporary files
.PHONY: fclean
fclean: clean
	@echo "$(YELLOW)Removing temporary files...$(NC)"
	@find . -name '*~' -delete
	@find . -name '*.swp' -delete
	@find . -name '*.o' -delete
	@find . -name 'a.out' -delete
	@echo "$(GREEN)✓ Full clean complete$(NC)"

# Rebuild everything
.PHONY: re
re: fclean all

# List all available C files
.PHONY: list
list:
	@echo "$(YELLOW)Available C source files:$(NC)"
	@for file in $(SOURCES); do \
		echo "  - $$file"; \
	done

# Show help
.PHONY: help
help:
	@echo "$(GREEN)ALX Low Level Programming Makefile$(NC)"
	@echo ""
	@echo "$(YELLOW)Available targets:$(NC)"
	@echo "  make all           - Build all C programs"
	@echo "  make build FILE=<path/to/file.c> - Build a specific file"
	@echo "  make run FILE=<path/to/file.c>   - Build and run a specific file"
	@echo "  make betty         - Run Betty style checker on all files"
	@echo "  make betty-file FILE=<path/to/file.c> - Check specific file with Betty"
	@echo "  make check-betty   - Check if Betty is installed"
	@echo "  make debug         - Build with debug symbols"
	@echo "  make clean         - Remove build directory"
	@echo "  make fclean        - Remove build directory and temporary files"
	@echo "  make re            - Rebuild everything from scratch"
	@echo "  make list          - List all C source files"
	@echo "  make help          - Show this help message"
	@echo ""
	@echo "$(YELLOW)Examples:$(NC)"
	@echo "  make build FILE=0x00-hello_world/4-puts.c"
	@echo "  make run FILE=0x00-hello_world/4-puts.c"
	@echo "  make betty-file FILE=0x00-hello_world/4-puts.c"

# Prevent make from deleting intermediate files
.SECONDARY:

# Default to help if no target specified
.DEFAULT_GOAL := help

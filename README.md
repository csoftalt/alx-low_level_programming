# ALX Low Level Programming

This repository contains projects and exercises for the ALX Low Level Programming curriculum, focusing on C programming fundamentals.

## 🛠️ Makefile Build System

This repository includes a comprehensive Makefile for building, testing, and style-checking C programs.

### Quick Start

```bash
# Show all available commands
make help

# Build and run a specific program
make run FILE=0x00-hello_world/4-puts.c

# Build a specific file
make build FILE=0x00-hello_world/4-puts.c

# Build all C programs
make all

# Check code style with Betty
make betty

# Check a specific file with Betty
make betty-file FILE=0x00-hello_world/4-puts.c
```

### Available Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands with examples |
| `make all` | Build all C programs in the repository |
| `make build FILE=<path>` | Build a specific C file |
| `make run FILE=<path>` | Build and run a specific C file |
| `make betty` | Run Betty style checker on all C files |
| `make betty-file FILE=<path>` | Check a specific file with Betty |
| `make check-betty` | Verify if Betty linter is installed |
| `make debug` | Build all programs with debug symbols |
| `make list` | List all C source files in the repository |
| `make clean` | Remove build directory |
| `make fclean` | Remove build directory and temporary files |
| `make re` | Rebuild everything from scratch |

### Features

- ✅ **Automatic Directory Discovery**: No need to update Makefile when adding new directories
- ✅ **Betty Style Integration**: Built-in Betty linter support for code style compliance
- ✅ **Build Directory**: All binaries stored in `build/` with preserved directory structure
- ✅ **Strict Compilation**: Uses `-Wall -Werror -Wextra -pedantic -std=gnu89` flags
- ✅ **Color-Coded Output**: Easy-to-read build messages
- ✅ **Debug Support**: Build with debug symbols using `make debug`

### Installing Betty Linter

If Betty is not installed:

```bash
git clone https://github.com/holbertonschool/Betty.git /tmp/Betty
cd /tmp/Betty
sudo ./install.sh
```

Verify installation:
```bash
make check-betty
```

### Project Structure

All compiled binaries are stored in the `build/` directory, maintaining the source directory structure:

```
build/
├── 0x00-hello_world/
│   ├── 4-puts
│   ├── 5-printf
│   └── 6-size
└── 0x01-variables_if_else_while/
    ├── 0-positive_or_negative
    └── 1-last_digit
```

## 📚 Projects

- **0x00-hello_world**: Introduction to C programming
- **0x01-variables_if_else_while**: Variables, conditionals, and loops

## 🎓 Learning Objectives

- Understanding C compilation process
- Following Betty coding style guidelines
- Writing clean, maintainable C code
- Using proper error handling and memory management
# Compiler and Flags
CXX = g++
CXXFLAGS = -Wall -std=c++11

# Directories
SRC_DIR = src
OBJ_DIR = obj

# Target Executable
TARGET = helloworld

# Find all .cpp files automatically
SRCS = $(wildcard $(SRC_DIR)/*.cpp)

# Convert .cpp files to .o (object files)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))

# Default rule: build the executable
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

# Compile .cpp to .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Create the obj directory if it doesn't exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(TARGET)

.PHONY: clean

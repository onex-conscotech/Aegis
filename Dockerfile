# Use the official GCC image as the base image
FROM gcc:latest

# Set the working directory in the container
WORKDIR /app

# Copy the source code, headers, and Makefile into the container
COPY src/ /app/src/
COPY include/ /app/include/
COPY Makefile /app/

# Create the obj directory
RUN mkdir -p obj

# Build the application using make
RUN make

# Command to run when the container starts
CMD ["./helloworld"] 
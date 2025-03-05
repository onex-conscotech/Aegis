# MYCPPPROJECT

This project demonstrates a simple C++ application that prints "Hello" messages every 10 seconds, containerized using Docker.

## Prerequisites

1. Install Docker on your system:
   - [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
   - [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)
   - For Linux:
     ```bash
     sudo apt-get update
     sudo apt-get install docker.io
     ```

2. Verify Docker installation:
   ```bash
   docker --version
   ```

## Project Structure 
```bash
MYCPPPROJECT/
├── Dockerfile
├── Makefile
├── src/
│   └── helloworld.cpp
├── include/
└── obj/
```

## Quick Start

1. Clone and enter the repository:
   ```bash
   git clone https://github.com/onex-conscotech/Aegis.git
   cd MYCPPPROJECT
   ```

2. Build and run with Docker:
   ```bash
   docker build -t cpp-hello-world .
   docker run cpp-hello-world
   ```

3. To stop the container:
   ```bash
   docker ps
   docker stop <container-id>
   ```

## Development Options

### Using Docker (Recommended)
- Build: `docker build -t cpp-hello-world .`
- Run: `docker run cpp-hello-world`
- Stop: `docker stop <container-id>`



## Project Components

### Dockerfile
- Uses gcc:latest as base image
- Sets up working directory
- Copies source files and builds the application

## License

Licensed under Conscotech private license.
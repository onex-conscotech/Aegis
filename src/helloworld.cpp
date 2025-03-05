#include <iostream>
#include <chrono>
#include <thread>

int main() {
    // Get start time
    auto start_time = std::chrono::steady_clock::now();
    
    for (int i = 1; ; i++) {
        std::cout << "Hello from VS Code C++! Count: " << i << std::endl;
        
        // Check if 10 seconds have elapsed
        auto current_time = std::chrono::steady_clock::now();
        auto elapsed = std::chrono::duration_cast<std::chrono::seconds>
                        (current_time - start_time).count();
        
        // Add a small delay to prevent flooding the console
        std::this_thread::sleep_for(std::chrono::milliseconds(10000));
    }
    
    return 0;
}

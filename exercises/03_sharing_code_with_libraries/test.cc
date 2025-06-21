#include "library.hh"

int main() {
    std::string expected = "World";
    return who() == expected ? 0 : 1;
}
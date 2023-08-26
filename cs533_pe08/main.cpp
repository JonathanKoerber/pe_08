#include <cstdio>

extern "C" {
    void quadratic_roots(unsigned char* coefficients);
}

template <typename T1, typename T2>
void PrintResult(const char* msg, T1 a, T1 b, T2 result) {
    printf("%s\n", msg);
    printf("a = %d, b = %d, result = %d\n",
           static_cast<int>(a), static_cast<int>(b),
           static_cast<int>(result));
}

int main() {
    unsigned char coefficients[3] = {1, 4, 3}; // Example coefficients (a=1, b=4, c=3)
    
    quadratic_roots(coefficients);

    // Read the results from the coefficients array
    int num_roots = coefficients[8];
    int root1 = coefficients[0];
    int root2 = coefficients[4];

    // Display the results using the PrintResult function
    if (num_roots == 0) {
        PrintResult("No real roots.", 0, 0, 0);
    } else if (num_roots == 1) {
        PrintResult("One real root:", root1, 0, 0);
    } else if (num_roots == 2) {
        PrintResult("Two real roots:", root1, root2, 0);
    }

    return 0;
}

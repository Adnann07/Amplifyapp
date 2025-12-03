





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IctPage extends StatefulWidget {
  const IctPage({super.key});

  @override
  State<IctPage> createState() => _IctPageState();
}

class _IctPageState extends State<IctPage> {
  int _selectedProblemIndex = 0;
  final TextEditingController _codeController = TextEditingController();
  String _output = '';
  bool _isCompiling = false;

  final List<Map<String, dynamic>> _problems = [
    {
      'title': 'Even or Odd Checker',
      'description': 'Check if a given number is even or odd.',
      'hint': 'Use the modulo operator (%) to check divisibility by 2.',
      'starter': '''#include <stdio.h>

int main() {
    int num = 7;  // Change this value to test
    
    if(num % 2 == 0) {
        printf("%d is even\\n", num);
    } else {
        printf("%d is odd\\n", num);
    }
    
    return 0;
}''',
    },
    {
      'title': 'Positive, Negative, or Zero',
      'description': 'Determine if a number is positive, negative, or zero.',
      'hint': 'Use if-else statements to compare with 0.',
      'starter': '''#include <stdio.h>

int main() {
    int num = -5;  // Change this value to test
    
    if(num > 0) {
        printf("%d is positive\\n", num);
    } else if(num < 0) {
        printf("%d is negative\\n", num);
    } else {
        printf("%d is zero\\n", num);
    }
    
    return 0;
}''',
    },
    {
      'title': 'Largest of Three Numbers',
      'description': 'Find the largest number among three given numbers.',
      'hint': 'Use nested if-else to compare all three numbers.',
      'starter': '''#include <stdio.h>

int main() {
    int a = 15, b = 28, c = 12;  // Change values to test
    int largest;
    
    if(a >= b && a >= c) {
        largest = a;
    } else if(b >= a && b >= c) {
        largest = b;
    } else {
        largest = c;
    }
    
    printf("Largest number is: %d\\n", largest);
    return 0;
}''',
    },
    {
      'title': 'Basic Calculator',
      'description': 'Calculate sum, difference, product, and quotient of two numbers.',
      'hint': 'Perform all four operations and handle division by zero.',
      'starter': '''#include <stdio.h>

int main() {
    float num1 = 20, num2 = 5;  // Change values to test
    
    printf("Sum: %.2f\\n", num1 + num2);
    printf("Difference: %.2f\\n", num1 - num2);
    printf("Product: %.2f\\n", num1 * num2);
    
    if(num2 != 0) {
        printf("Quotient: %.2f\\n", num1 / num2);
    } else {
        printf("Cannot divide by zero\\n");
    }
    
    return 0;
}''',
    },
    {
      'title': 'Celsius to Fahrenheit',
      'description': 'Convert temperature from Celsius to Fahrenheit.',
      'hint': 'Formula: F = (C × 9/5) + 32',
      'starter': '''#include <stdio.h>

int main() {
    float celsius = 25.0;  // Change this value to test
    float fahrenheit;
    
    fahrenheit = (celsius * 9.0 / 5.0) + 32.0;
    
    printf("%.2f Celsius = %.2f Fahrenheit\\n", celsius, fahrenheit);
    
    return 0;
}''',
    },
    {
      'title': 'Leap Year Checker',
      'description': 'Check if a given year is a leap year.',
      'hint': 'Divisible by 4, but century years must be divisible by 400.',
      'starter': '''#include <stdio.h>

int main() {
    int year = 2024;  // Change this value to test
    
    if((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        printf("%d is a leap year\\n", year);
    } else {
        printf("%d is not a leap year\\n", year);
    }
    
    return 0;
}''',
    },
    {
      'title': 'GCD and LCM Calculator',
      'description': 'Find GCD and LCM of two numbers.',
      'hint': 'Use Euclidean algorithm for GCD. LCM = (a × b) / GCD',
      'starter': '''#include <stdio.h>

int main() {
    int a = 48, b = 18;  // Change values to test
    int num1 = a, num2 = b;
    int gcd, lcm, temp;
    
    // Find GCD using Euclidean algorithm
    while(num2 != 0) {
        temp = num2;
        num2 = num1 % num2;
        num1 = temp;
    }
    gcd = num1;
    
    // Calculate LCM
    lcm = (a * b) / gcd;
    
    printf("GCD of %d and %d = %d\\n", a, b, gcd);
    printf("LCM of %d and %d = %d\\n", a, b, lcm);
    
    return 0;
}''',
    },
    {
      'title': 'Area of Triangle',
      'description': 'Calculate area of triangle using base and height.',
      'hint': 'Formula: Area = 0.5 × base × height',
      'starter': '''#include <stdio.h>

int main() {
    float base = 10.0, height = 5.0;  // Change values to test
    float area;
    
    area = 0.5 * base * height;
    
    printf("Area of triangle: %.2f\\n", area);
    
    return 0;
}''',
    },
    {
      'title': 'Star Triangle Pattern',
      'description': 'Print a triangle pattern using stars.',
      'hint': 'Use nested loops: outer for rows, inner for stars.',
      'starter': '''#include <stdio.h>

int main() {
    int rows = 5;  // Change this value to test
    int i, j;
    
    for(i = 1; i <= rows; i++) {
        for(j = 1; j <= i; j++) {
            printf("* ");
        }
        printf("\\n");
    }
    
    return 0;
}''',
    },
    {
      'title': 'Loop Constructs Demo',
      'description': 'Demonstrate for, while, and do-while loops.',
      'hint': 'Show each loop type printing numbers.',
      'starter': '''#include <stdio.h>

int main() {
    int n = 5;  // Change this value to test
    int i;
    
    printf("For loop: ");
    for(i = 1; i <= n; i++) {
        printf("%d ", i);
    }
    printf("\\n");
    
    printf("While loop: ");
    i = 1;
    while(i <= n) {
        printf("%d ", i);
        i++;
    }
    printf("\\n");
    
    printf("Do-while loop: ");
    i = 1;
    do {
        printf("%d ", i);
        i++;
    } while(i <= n);
    printf("\\n");
    
    return 0;
}''',
    },
    {
      'title': 'Sum of Natural Numbers',
      'description': 'Find sum of first n natural numbers (1+2+3+...+n).',
      'hint': 'Use loop or formula: sum = n×(n+1)/2',
      'starter': '''#include <stdio.h>

int main() {
    int n = 10;  // Change this value to test
    int sum = 0, i;
    
    for(i = 1; i <= n; i++) {
        sum += i;
    }
    
    printf("Sum of first %d natural numbers = %d\\n", n, sum);
    
    return 0;
}''',
    },
    {
      'title': 'Factorial Calculator',
      'description': 'Find factorial of a given number.',
      'hint': 'Factorial of n = n × (n-1) × (n-2) × ... × 1',
      'starter': '''#include <stdio.h>

int main() {
    int n = 5;  // Change this value to test
    long long factorial = 1;
    int i;
    
    for(i = 1; i <= n; i++) {
        factorial *= i;
    }
    
    printf("Factorial of %d = %lld\\n", n, factorial);
    
    return 0;
}''',
    },
    {
      'title': 'Prime Number Checker',
      'description': 'Check if a given number is prime.',
      'hint': 'A prime number has only two divisors: 1 and itself.',
      'starter': '''#include <stdio.h>

int main() {
    int n = 29;  // Change this value to test
    int i, isPrime = 1;
    
    if(n <= 1) {
        isPrime = 0;
    } else {
        for(i = 2; i * i <= n; i++) {
            if(n % i == 0) {
                isPrime = 0;
                break;
            }
        }
    }
    
    if(isPrime) {
        printf("%d is a prime number\\n", n);
    } else {
        printf("%d is not a prime number\\n", n);
    }
    
    return 0;
}''',
    },
    {
      'title': 'Fibonacci Series',
      'description': 'Generate Fibonacci series up to n terms.',
      'hint': 'Each term is sum of previous two terms.',
      'starter': '''#include <stdio.h>

int main() {
    int n = 10;  // Change this value to test
    int first = 0, second = 1, next, i;
    
    printf("Fibonacci series up to %d terms:\\n", n);
    
    for(i = 0; i < n; i++) {
        if(i <= 1) {
            next = i;
        } else {
            next = first + second;
            first = second;
            second = next;
        }
        printf("%d ", next);
    }
    printf("\\n");
    
    return 0;
}''',
    },
    {
      'title': 'Sum of Squares',
      'description': 'Find sum of series: 1² + 2² + 3² + ... + n².',
      'hint': 'Calculate square of each number and add.',
      'starter': '''#include <stdio.h>

int main() {
    int n = 5;  // Change this value to test
    int sum = 0, i;
    
    for(i = 1; i <= n; i++) {
        sum += i * i;
    }
    
    printf("Sum of squares from 1 to %d = %d\\n", n, sum);
    
    return 0;
}''',
    },
    {
      'title': 'Reverse Digits',
      'description': 'Reverse the digits of a given number.',
      'hint': 'Extract last digit, add to reverse, remove last digit.',
      'starter': '''#include <stdio.h>

int main() {
    int num = 12345;  // Change this value to test
    int reverse = 0, remainder;
    int original = num;
    
    while(num != 0) {
        remainder = num % 10;
        reverse = reverse * 10 + remainder;
        num /= 10;
    }
    
    printf("Original number: %d\\n", original);
    printf("Reversed number: %d\\n", reverse);
    
    return 0;
}''',
    },
    {
      'title': 'Palindrome Checker',
      'description': 'Check if a number is a palindrome.',
      'hint': 'A palindrome reads same forwards and backwards.',
      'starter': '''#include <stdio.h>

int main() {
    int num = 12321;  // Change this value to test
    int reverse = 0, remainder, original;
    original = num;
    
    while(num != 0) {
        remainder = num % 10;
        reverse = reverse * 10 + remainder;
        num /= 10;
    }
    
    if(original == reverse) {
        printf("%d is a palindrome\\n", original);
    } else {
        printf("%d is not a palindrome\\n", original);
    }
    
    return 0;
}''',
    },
    {
      'title': 'Sum of Even and Odd Numbers',
      'description': 'Find sum of even and odd numbers in a range.',
      'hint': 'Check each number if even or odd, add to respective sum.',
      'starter': '''#include <stdio.h>

int main() {
    int start = 1, end = 20;  // Change range to test
    int evenSum = 0, oddSum = 0, i;
    
    for(i = start; i <= end; i++) {
        if(i % 2 == 0) {
            evenSum += i;
        } else {
            oddSum += i;
        }
    }
    
    printf("Sum of even numbers: %d\\n", evenSum);
    printf("Sum of odd numbers: %d\\n", oddSum);
    
    return 0;
}''',
    },
    {
      'title': 'Largest and Smallest in Array',
      'description': 'Find largest and smallest number in an array.',
      'hint': 'Initialize with first element, compare with rest.',
      'starter': '''#include <stdio.h>

int main() {
    int arr[] = {45, 12, 78, 23, 67, 34, 89};
    int n = 7;  // Change array to test
    int i, largest, smallest;
    
    largest = smallest = arr[0];
    
    for(i = 1; i < n; i++) {
        if(arr[i] > largest) {
            largest = arr[i];
        }
        if(arr[i] < smallest) {
            smallest = arr[i];
        }
    }
    
    printf("Largest: %d\\n", largest);
    printf("Smallest: %d\\n", smallest);
    
    return 0;
}''',
    },
    {
      'title': 'Array Sum and Average',
      'description': 'Calculate sum and average of array elements.',
      'hint': 'Add all elements, divide by count for average.',
      'starter': '''#include <stdio.h>

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    int n = 5;  // Change array to test
    int sum = 0, i;
    float average;
    
    for(i = 0; i < n; i++) {
        sum += arr[i];
    }
    
    average = (float)sum / n;
    
    printf("Sum: %d\\n", sum);
    printf("Average: %.2f\\n", average);
    
    return 0;
}''',
    },
    {
      'title': 'Search Element in Array',
      'description': 'Search for a specific element in an array.',
      'hint': 'Compare each element with search value.',
      'starter': '''#include <stdio.h>

int main() {
    int arr[] = {15, 23, 8, 42, 17, 31};
    int n = 6;
    int search = 42;  // Change values to test
    int i, found = 0, position = -1;
    
    for(i = 0; i < n; i++) {
        if(arr[i] == search) {
            found = 1;
            position = i;
            break;
        }
    }
    
    if(found) {
        printf("%d found at position %d\\n", search, position);
    } else {
        printf("%d not found\\n", search);
    }
    
    return 0;
}''',
    },
    {
      'title': 'Sort Array Ascending',
      'description': 'Sort array in ascending order using bubble sort.',
      'hint': 'Compare adjacent elements and swap if needed.',
      'starter': '''#include <stdio.h>

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int n = 7;  // Change array to test
    int i, j, temp;
    
    // Bubble sort
    for(i = 0; i < n - 1; i++) {
        for(j = 0; j < n - i - 1; j++) {
            if(arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
    
    printf("Sorted array: ");
    for(i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\\n");
    
    return 0;
}''',
    },
    {
      'title': 'Meters to Feet Conversion',
      'description': 'Convert meters to feet.',
      'hint': '1 meter = 3.28084 feet',
      'starter': '''#include <stdio.h>

int main() {
    float meters = 10.0;  // Change this value to test
    float feet;
    
    feet = meters * 3.28084;
    
    printf("%.2f meters = %.2f feet\\n", meters, feet);
    
    return 0;
}''',
    },
    {
      'title': 'Kilograms to Pounds',
      'description': 'Convert kilograms to pounds.',
      'hint': '1 kilogram = 2.20462 pounds',
      'starter': '''#include <stdio.h>

int main() {
    float kg = 5.0;  // Change this value to test
    float pounds;
    
    pounds = kg * 2.20462;
    
    printf("%.2f kg = %.2f pounds\\n", kg, pounds);
    
    return 0;
}''',
    },
    {
      'title': 'Multiplication Table',
      'description': 'Print multiplication table for a number.',
      'hint': 'Use loop to multiply number by 1 to 10.',
      'starter': '''#include <stdio.h>

int main() {
    int num = 7;  // Change this value to test
    int i;
    
    printf("Multiplication table of %d:\\n", num);
    
    for(i = 1; i <= 10; i++) {
        printf("%d x %d = %d\\n", num, i, num * i);
    }
    
    return 0;
}''',
    },
    {
      'title': 'Number Pyramid Pattern',
      'description': 'Print number pyramid pattern.',
      'hint': 'Use nested loops for rows and numbers.',
      'starter': '''#include <stdio.h>

int main() {
    int rows = 5;  // Change this value to test
    int i, j;
    
    for(i = 1; i <= rows; i++) {
        for(j = 1; j <= i; j++) {
            printf("%d ", j);
        }
        printf("\\n");
    }
    
    return 0;
}''',
    },
    {
      'title': 'Star Pyramid Pattern',
      'description': 'Print centered star pyramid.',
      'hint': 'Print spaces for centering, then stars.',
      'starter': '''#include <stdio.h>

int main() {
    int rows = 5;  // Change this value to test
    int i, j, k;
    
    for(i = 1; i <= rows; i++) {
        // Print spaces
        for(j = 1; j <= rows - i; j++) {
            printf(" ");
        }
        // Print stars
        for(k = 1; k <= 2 * i - 1; k++) {
            printf("*");
        }
        printf("\\n");
    }
    
    return 0;
}''',
    },
    {
      'title': 'Triangle Area - Heron\'s Formula',
      'description': 'Calculate triangle area using three sides (Heron\'s formula).',
      'hint': 's = (a+b+c)/2, Area = √(s(s-a)(s-b)(s-c))',
      'starter': '''#include <stdio.h>
#include <math.h>

int main() {
    float a = 3.0, b = 4.0, c = 5.0;  // Change sides to test
    float s, area;
    
    s = (a + b + c) / 2.0;
    area = sqrt(s * (s - a) * (s - b) * (s - c));
    
    printf("Area of triangle: %.2f\\n", area);
    
    return 0;
}''',
    },
    {
      'title': 'Rectangle Perimeter and Area',
      'description': 'Calculate perimeter and area of rectangle.',
      'hint': 'Perimeter = 2(l+w), Area = l×w',
      'starter': '''#include <stdio.h>

int main() {
    float length = 10.0, width = 5.0;  // Change values to test
    float perimeter, area;
    
    perimeter = 2 * (length + width);
    area = length * width;
    
    printf("Perimeter: %.2f\\n", perimeter);
    printf("Area: %.2f\\n", area);
    
    return 0;
}''',
    },
    {
      'title': 'Circle Circumference and Area',
      'description': 'Calculate circumference and area of circle.',
      'hint': 'Circumference = 2πr, Area = πr²',
      'starter': '''#include <stdio.h>
#define PI 3.14159

int main() {
    float radius = 7.0;  // Change this value to test
    float circumference, area;
    
    circumference = 2 * PI * radius;
    area = PI * radius * radius;
    
    printf("Circumference: %.2f\\n", circumference);
    printf("Area: %.2f\\n", area);
    
    return 0;
}''',
    },
    {
      'title': 'Switch-Case Grade Calculator',
      'description': 'Demonstrate switch-case with grade calculator.',
      'hint': 'Use switch to match grade letters.',
      'starter': '''#include <stdio.h>

int main() {
    char grade = 'B';  // Change this to test (A, B, C, D, F)
    
    switch(grade) {
        case 'A':
            printf("Excellent! (90-100)\\n");
            break;
        case 'B':
            printf("Good! (80-89)\\n");
            break;
        case 'C':
            printf("Fair (70-79)\\n");
            break;
        case 'D':
            printf("Pass (60-69)\\n");
            break;
        case 'F':
            printf("Fail (Below 60)\\n");
            break;
        default:
            printf("Invalid grade\\n");
    }
    
    return 0;
}''',
    },
  ];

  @override
  void initState() {
    super.initState();
    _codeController.text = _problems[0]['starter'];
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _compileAndRun() async {
    setState(() {
      _isCompiling = true;
      _output = 'Compiling...';
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.jdoodle.com/v1/execute'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'clientId': 'ee949609ce8800a0eb9cd2eb4ada0f2b',
          'clientSecret': '6509e345c88fe84136efd5d0d59441ba40247580d2aa8b23f669340925642ec6',
          'script': _codeController.text,
          'language': 'c',
          'versionIndex': '4',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _output = data['output'] ?? 'No output';
          if (data['error'] != null && data['error'].toString().isNotEmpty) {
            _output = 'Error:\n${data['error']}';
          }
          _isCompiling = false;
        });
      } else {
        setState(() {
          _output = 'Error: ${response.statusCode}\n${response.body}';
          _isCompiling = false;
        });
      }
    } catch (e) {
      setState(() {
        _output = 'Error: $e\n\nNote: Sign up at jdoodle.com for API credentials.';
        _isCompiling = false;
      });
    }
  }

  void _loadProblem(int index) {
    setState(() {
      _selectedProblemIndex = index;
      _codeController.text = _problems[index]['starter'];
      _output = '';
    });
  }

  void _resetCode() {
    setState(() {
      _codeController.text = _problems[_selectedProblemIndex]['starter'];
      _output = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ICT - C Programming Lab'),
        backgroundColor: Colors.indigo.shade800,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade50,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Problem Selector Dropdown
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list_alt, color: Colors.indigo.shade600),
                          const SizedBox(width: 10),
                          Text(
                            'Select Problem (${_problems.length} Total)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo.shade200),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.indigo.shade50,
                        ),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: _selectedProblemIndex,
                          underline: const SizedBox(),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.indigo.shade700),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.indigo.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                          items: List.generate(_problems.length, (index) {
                            return DropdownMenuItem<int>(
                              value: index,
                              child: Text(
                                '${index + 1}. ${_problems[index]['title']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            );
                          }),
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              _loadProblem(newValue);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Problem Details Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.code, color: Colors.indigo.shade600, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _problems[_selectedProblemIndex]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _problems[_selectedProblemIndex]['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: Colors.amber.shade700,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Hint: ${_problems[_selectedProblemIndex]['hint']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.amber.shade900,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Code Editor
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.edit_note, color: Colors.grey.shade700, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Code Editor',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: _resetCode,
                            icon: const Icon(Icons.refresh),
                            color: Colors.grey.shade600,
                            tooltip: 'Reset Code',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _codeController,
                          maxLines: 18,
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 13,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(12),
                            border: InputBorder.none,
                            hintText: 'Modify the code and run...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontFamily: 'Courier',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isCompiling ? null : _compileAndRun,
                          icon: _isCompiling
                              ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Icon(Icons.play_arrow),
                          label: Text(_isCompiling ? 'Compiling...' : 'Run Code'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Output Console
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.terminal, color: Colors.grey.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Output Console',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(minHeight: 120),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _output.isEmpty
                              ? 'Click "Run Code" to see output...'
                              : _output,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 13,
                            color: _output.startsWith('Error')
                                ? Colors.red.shade300
                                : _output.isEmpty
                                ? Colors.grey.shade500
                                : Colors.green.shade300,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'How to Use',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1. Select code from drop down\n'
                            '2. Read and understand the code\n'
                            '3. Clear screen and try for yourself\n'
                            '4. Run the code to see output',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade800,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}














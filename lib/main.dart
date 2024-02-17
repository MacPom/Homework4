import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFD3BBFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF6F43C0),
          title: const Center(
            child: Text(
              'CP-SP LED MATRIX',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: const LedMatrix(),
      ),
    );
  }
}

class LedMatrix extends StatefulWidget {
  const LedMatrix({Key? key}) : super(key: key);

  @override
  _LedMatrixState createState() => _LedMatrixState();
}

class _LedMatrixState extends State<LedMatrix> {
  int currentIndex = 0;

  void increaseIndex() {
    setState(() {
      currentIndex = (currentIndex < 99) ? (currentIndex + 1) : 0;
    });
  }

  void decreaseIndex() {
    setState(() {
      currentIndex = (currentIndex > 0) ? (currentIndex - 1) : 99;
    });
  }

  @override
  Widget build(BuildContext context) {
    int tens = currentIndex ~/ 10;
    int ones = currentIndex % 10;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildButton('+', increaseIndex),
        _buildFrame(tens, ones),
        _buildButton('-', decreaseIndex),
      ],
    );
  }

  Widget _buildButton(String button, void Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6F43C0).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            button,
            style: TextStyle(
              color: const Color(0xFF250059),
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrame(int tens, int ones) {
    return Center(
      child: Container(
        width: 380,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6F43C0).withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 18,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDigit(tens), // Display tens digit
              const SizedBox(width: 36), // Spacer between digits
              _buildDigit(ones), // Display ones digit
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigit(int digit) {
    // Fetch the LED matrix data for the given digit
    List<List<int>> digitData = dotsData[digit];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var row in digitData)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var dot in row)
                _buildLed(dot == 1), // Pass whether LED should be on
            ],
          ),
      ],
    );
  }

  Widget _buildLed(bool on) {
    return Padding(
      padding: const EdgeInsets.all(1.6),
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: on ? Colors.red : const Color(0xFF333333),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// 0 = (LED off), 1 = (LED on)
const dotsData = [
  // Digit 0
  [
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ],
  // Digit 1
  [
    [0, 0, 1, 0, 0],
    [0, 1, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 1, 1, 1, 0],
  ],
  // Digit 2
  [
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [0, 0, 0, 0, 1],
    [0, 0, 0, 1, 0],
    [0, 0, 1, 0, 0],
    [0, 1, 0, 0, 0],
    [1, 1, 1, 1, 1],
  ],
  // Digit 3
  [
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [0, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ],
  // Digit 4
  [
    [0, 0, 0, 1, 0],
    [0, 0, 1, 1, 0],
    [0, 1, 0, 1, 0],
    [1, 0, 0, 1, 0],
    [1, 1, 1, 1, 1],
    [0, 0, 0, 1, 0],
    [0, 0, 0, 1, 0],
  ],
  // Digit 5
  [
    [1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [0, 0, 0, 0, 1],
    [0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ],
  // Digit 6
  [
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ],
  // Digit 7
  [
    [1, 1, 1, 1, 1],
    [0, 0, 0, 0, 1],
    [0, 0, 0, 1, 0],
    [0, 0, 1, 0, 0],
    [0, 1, 0, 0, 0],
    [0, 1, 0, 0, 0],
    [0, 1, 0, 0, 0],
  ],
  // Digit 8
  [
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ],
  // Digit 9
  [
    [0, 1, 1, 1, 0],
    [1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 1],
    [0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ]
];

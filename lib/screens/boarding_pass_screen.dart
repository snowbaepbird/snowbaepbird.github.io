import 'package:family_invitation/screens/home_screen.dart';
import 'package:family_invitation/designs/dotted_line_painter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BoardingPassScreen extends StatefulWidget {
  const BoardingPassScreen({super.key});

  @override
  State<BoardingPassScreen> createState() => _BoardingPassScreenState();
}

List<Text> makeLocationText(String korean, String english, String IATA) {
  return [
    Text(
      IATA,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    Text(korean, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    Text(english, style: TextStyle(fontSize: 12, color: Colors.grey)),
  ];
}

List<Widget> makeElementText(
  String key,
  String value,
  double fontSize_, {
  bool bold = false,
}) {
  return [
    Text(key, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
    SizedBox(height: 8),
    Text(
      value,
      style: TextStyle(
        fontSize: fontSize_,
        fontWeight: bold ? FontWeight.bold : FontWeight.w600,
      ),
    ),
  ];
}

class _BoardingPassScreenState extends State<BoardingPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0F7FF), // Much lighter blue
              Color(0xFFFFF0F5), // Much lighter pink/lavender
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  width: 350, // Fixed width for the card
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'BOARDING PASS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                      ),

                      // QR Code Section (Gradient 1)
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFEFF6FF), Colors.white],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: Image.asset(
                              'public/assets/qrcode.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // Dotted Line
                      CustomPaint(
                        size: const Size(double.infinity, 1),
                        painter: DottedLinePainter(),
                      ),

                      // Bottom Section (Gradient 2)
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFEFF6FF), Colors.white],
                          ),
                        ),
                        child: Column(
                          children: [
                            // Flight Info
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SEL
                                  Column(
                                    children: makeLocationText(
                                      "서울",
                                      "Seoul",
                                      "SEL",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Plane Path
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomPaint(
                                                  size: const Size(
                                                    double.infinity,
                                                    1,
                                                  ),
                                                  painter: DottedLinePainter(),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                child: Transform.rotate(
                                                  angle: 90 * math.pi / 180,
                                                  child: const Icon(
                                                    Icons.flight,
                                                    size: 40,
                                                    color: Color(0xFF1E3A8A),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomPaint(
                                                  size: const Size(
                                                    double.infinity,
                                                    1,
                                                  ),
                                                  painter: DottedLinePainter(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  // ICN
                                  Column(
                                    children: makeLocationText(
                                      "인천",
                                      "Incheon",
                                      "ICN",
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Dotted Line
                            CustomPaint(
                              size: const Size(double.infinity, 1),
                              painter: DottedLinePainter(),
                            ),

                            // Passenger Info
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PASSENGER',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Text(
                                        '한종우',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '한채은',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: makeElementText(
                                          "항공편명",
                                          "HAN721",
                                          16,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: makeElementText(
                                          "YEAR",
                                          "2026",
                                          16,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: makeElementText(
                                          "DATE",
                                          "0110",
                                          16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1E3A8A),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    '청첩장 확인하기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

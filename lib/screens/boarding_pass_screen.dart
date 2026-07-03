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

class _BoardingPassScreenState extends State<BoardingPassScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _tearController;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _tearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _tearController.reset(); // Ensure it starts from the beginning

    _slideAnimation = Tween<double>(begin: 0.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _tearController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInBack),
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.15).animate(
      CurvedAnimation(
        parent: _tearController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _tearController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _tearController.dispose();
    super.dispose();
  }

  void _handleTear() async {
    await _tearController.forward();
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      // When the user comes back (pops), reset the animation
      _tearController.reset();
    }
  }

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
                  clipBehavior: Clip.none, // Allow children to move out
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // --- TOP FRAGMENT (Static) ---
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            // Header
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E3A8A),
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
                            // Unified QR & Flight Info Section with continuous gradient
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
                                  // QR Code
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: Center(
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
                                  // Static Flight Info Section
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      30,
                                      0,
                                      30,
                                      25,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: makeLocationText(
                                            "서울",
                                            "Seoul",
                                            "SEL",
                                          ),
                                        ),
                                        const SizedBox(width: 10),
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
                                                          5,
                                                        ),
                                                        painter:
                                                            DottedLinePainter(
                                                              isDash: true,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Transform.rotate(
                                                        angle:
                                                            90 * math.pi / 180,
                                                        child: const Icon(
                                                          Icons.flight,
                                                          size: 40,
                                                          color: Color(
                                                            0xFF1E3A8A,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: CustomPaint(
                                                        size: const Size(
                                                          double.infinity,
                                                          5,
                                                        ),
                                                        painter:
                                                            DottedLinePainter(
                                                              isDash: true,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. BOTTOM FRAGMENT (Animated)
                      AnimatedBuilder(
                        animation: _tearController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Transform.rotate(
                              angle: _rotationAnimation.value,
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                opacity: _opacityAnimation.value,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(20),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      width: double.infinity,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFFEFF6FF),
                                              Colors.white,
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            // Passenger Info
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 35,
                                                    vertical: 30,
                                                  ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'PASSENGER',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        '한종우',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children:
                                                            makeElementText(
                                                              "항공편명",
                                                              "HAN721",
                                                              16,
                                                            ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children:
                                                            makeElementText(
                                                              "YEAR",
                                                              "2026",
                                                              16,
                                                            ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children:
                                                            makeElementText(
                                                              "DATE",
                                                              "07/04",
                                                              16,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Button
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                    30,
                                                    0,
                                                    30,
                                                    30,
                                                  ),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 50,
                                                child: ElevatedButton(
                                                  onPressed: _handleTear,
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF1E3A8A),
                                                    foregroundColor:
                                                        Colors.white,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    '청첩장 확인하기',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // The Overlapping Perforation Line
                                    Positioned(
                                      top: -2.5,
                                      left: 0,
                                      right: 0,
                                      child: CustomPaint(
                                        size: const Size(double.infinity, 5),
                                        painter: DottedLinePainter(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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

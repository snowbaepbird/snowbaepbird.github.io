import 'dart:async';
import 'package:flutter/material.dart';
import 'package:family_invitation/screens/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int heroIndex = 0;
  Timer? _slideTimer;

  @override
  void initState() {
    super.initState();
    _slideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() => heroIndex = heroIndex + 1);
    });
  }

  @override
  void dispose() {
    _slideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text(
          '종우 ♥ 채은의 소식',
          style: TextStyle(fontFamily: 'MemomentKkukkukk', fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(
            context,
          ).textTheme.apply(fontFamily: 'MemomentKkukkukk'),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'MemomentKkukkukk',
            color: Colors.black,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: HomeView(heroIndex: heroIndex),
          ),
        ),
      ),
    );
  }
}

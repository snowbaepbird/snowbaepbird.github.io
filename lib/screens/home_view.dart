import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:family_invitation/designs/petal_animation.dart';
import 'package:family_invitation/widgets/info_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.heroIndex});

  final int heroIndex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> _imageAssets = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.startsWith('lib/assets/'))
        .toList();
    if (mounted) {
      setState(() {
        _imageAssets = imagePaths;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageAssets.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Hero image
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE6E0D9)),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        child: Image.asset(
                          _imageAssets[widget.heroIndex % _imageAssets.length],
                          key: ValueKey<int>(widget.heroIndex),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const PetalLayer(),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0x99000000), Color(0x00000000)],
                            ),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '소중한 분들께,',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'ChangwonDangamRound',
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '저희는 결혼식을 진행하지 않기로 했습니다. 대신 1월 10일 소중한 가족분들을 모시고 식사를 진행하고자 하니 시간 되시는 분들은 참석하시어 축복해주시면 감사드리겠습니다.',
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 1.4,
                                  fontFamily: 'ChangwonDangamRound',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const InfoSection(),
            ],
          ),
        ),
      ),
    );
  }
}

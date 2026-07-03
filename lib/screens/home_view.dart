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
                          gaplessPlayback: true,
                        ),
                      ),
                      const PetalLayer(),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xff000000), Color(0x00000000)],
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
                                '저희 두 사람의 뜻에 따라 결혼식은 생략하고 가족분들께 식사를 대접하며 정식으로 인사드리고자 합니다. 바쁘신 중에도 귀한 시간을 내시어 저희의 앞날을 함께 축복해 주시면 감사드리겠습니다.',
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

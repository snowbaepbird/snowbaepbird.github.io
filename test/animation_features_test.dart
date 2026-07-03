import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('boarding pass waits for tear animation before opening home', () {
    final source = File(
      'lib/screens/boarding_pass_screen.dart',
    ).readAsStringSync();

    expect(source, contains('with SingleTickerProviderStateMixin'));
    expect(source, contains('late AnimationController _tearController'));
    expect(source, contains('await _tearController.forward()'));
    expect(source, contains('Transform.translate'));
    expect(source, contains('Transform.rotate'));
    expect(source, contains('Opacity'));
  });

  test('home hero image keeps the previous frame during asset switches', () {
    final source = File('lib/screens/home_view.dart').readAsStringSync();

    expect(source, contains('gaplessPlayback: true'));
  });

  test('web loader matches the airplane loading screen', () {
    final source = File('web/index.html').readAsStringSync();

    expect(source, contains('id="loading-app"'));
    expect(source, contains('class="clouds-background"'));
    expect(source, contains('class="airplane-icon"'));
    expect(source, contains('설레는 마음으로 이륙 준비 중'));
    expect(source, contains("window.addEventListener('flutter-first-frame'"));
  });
}

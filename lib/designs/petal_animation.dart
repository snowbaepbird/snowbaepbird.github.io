import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ---------- Petal Layer (항상 떨어지게: Timer 기반) ----------
class PetalLayer extends StatefulWidget {
  const PetalLayer({super.key});
  @override
  State<PetalLayer> createState() => _PetalLayerState();
}

class _PetalLayerState extends State<PetalLayer> {
  Timer? _loop;
  final math.Random rng = math.Random();
  late List<_Petal> petals = List<_Petal>.generate(20, (_) => _random());

  _Petal _random() {
    final double s = rng.nextDouble() * 5 + 4; // 작은 꽃잎
    return _Petal(
      x: rng.nextDouble(),
      y: -rng.nextDouble(),
      size: s,
      speed: rng.nextDouble() * 0.005 + 0.005, // 속도 차등
      swayAmp: rng.nextDouble() * 100 + 20,
      swayFreq: rng.nextDouble() * 1.5 + 0.6,
      rot: rng.nextDouble() * math.pi,
      rotSpeed: (rng.nextDouble() - 0.5) * 0.3,
    );
  }

  @override
  void initState() {
    super.initState();
    // 약 30fps로 계속 리페인트 → 사진이 안 바뀌어도 꽃잎 낙하 유지
    _loop = Timer.periodic(const Duration(milliseconds: 33), (_) {
      setState(() {
        // 위치 업데이트는 painter에서 수행 (p.y += p.speed 등)
        // 여기선 리페인트만 트리거
      });
    });
  }

  @override
  void dispose() {
    _loop?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _PetalPainter(
          petals: petals,
          onReset: (p) {
            final int i = petals.indexOf(p);
            if (i != -1) petals[i] = _random();
          },
        ),
      ),
    );
  }
}

class _PetalPainter extends CustomPainter {
  final List<_Petal> petals;
  final void Function(_Petal) onReset;
  _PetalPainter({required this.petals, required this.onReset});

  @override
  void paint(Canvas canvas, Size size) {
    for (final _Petal p in petals) {
      p.y += p.speed; // fall
      final double sway =
          math.sin((p.phase + p.y * p.swayFreq) * math.pi) * p.swayAmp;
      final double dx = p.x * size.width + sway;
      final double dy = p.y * size.height - 20; // start above
      p.rot += p.rotSpeed * 0.1;

      if (dy > size.height + 40) {
        onReset(p);
        continue;
      }

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(p.rot);

      // Cherry blossom petal shape
      final Path petal = Path()
        ..moveTo(0, 0) // Base of the petal
        // Right side curve to the top-right lobe
        ..cubicTo(6, -8, 10, -18, 5, -25)
        // Curve from top-right lobe, across the top with a notch, to the top-left lobe
        ..cubicTo(2, -28, -2, -28, -5, -25)
        // Left side curve back to the base
        ..cubicTo(-10, -18, -6, -8, 0, 0)
        ..close();

      final Matrix4 m = Matrix4.identity()..scale(p.size / 8, p.size / 8);
      final Path scaled = petal.transform(m.storage);

      final Rect bounds = scaled.getBounds();

      final Paint fill = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.pink.shade100.withAlpha(230), // Lighter pink
            Colors.white.withAlpha(230), // White
          ],
        ).createShader(bounds);

      canvas.drawPath(scaled, fill);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Petal {
  double x, y, size, speed, swayAmp, swayFreq, rot, rotSpeed;
  double phase = math.Random().nextDouble();
  _Petal({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.swayAmp,
    required this.swayFreq,
    required this.rot,
    required this.rotSpeed,
  });
}

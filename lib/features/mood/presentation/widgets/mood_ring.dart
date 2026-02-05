import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/features/dashboard/data/models/mood_steps.dart';

class InteractiveMoodRing extends StatefulWidget {
  final double initialProgress; // 0..1
  final List<MoodStep> steps;
  final ValueChanged<double>? onChanged;

  final double size; // desired size
  final double stroke; // ring thickness

  const InteractiveMoodRing({
    super.key,
    this.initialProgress = 0.75,
    required this.steps,
    this.onChanged,
    this.size = 260,
    this.stroke = 26,
  });

  @override
  State<InteractiveMoodRing> createState() => _InteractiveMoodRingState();
}

class _InteractiveMoodRingState extends State<InteractiveMoodRing> {
  late double _p;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _p = widget.initialProgress.clamp(0.0, 1.0);
  }

  MoodStep get _currentStep {
    for (final s in widget.steps) {
      if (s.contains(_p)) return s;
    }
    return widget.steps.last;
  }

  double _progressFromOffset(Offset localPos, Size size) {
    final c = size.center(Offset.zero);
    final dx = localPos.dx - c.dx;
    final dy = localPos.dy - c.dy;
    final ang = atan2(dy, dx);

    // 0 at top (-pi/2), clockwise
    double p = (ang + pi / 2) / (2 * pi);
    if (p < 0) p += 1;
    return p.clamp(0.0, 1.0);
  }

  Offset _knobCenterForProgress(double p, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2 - widget.stroke / 2;

    final a = -pi / 2 + (2 * pi) * p;
    return Offset(c.dx + r * cos(a), c.dy + r * sin(a));
  }

  bool _isTouchOnKnob(Offset localPos, Size size) {
    final knob = _knobCenterForProgress(_p, size);

    // MUST match painter
    final knobRadius = widget.stroke * 0.62;

    // make grabbing easy
    const tolerance = 18.0;

    return (localPos - knob).distance <= (knobRadius + tolerance);
  }

  void _setProgress(double p) {
    final clamped = p.clamp(0.0, 1.0);
    if ((_p - clamped).abs() < 0.0005) return;
    setState(() => _p = clamped);
    widget.onChanged?.call(_p);
  }

  @override
  Widget build(BuildContext context) {
    final step = _currentStep;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // ✅ Use actual available size, but don’t exceed widget.size
            final shortest = constraints.biggest.shortestSide.isFinite
                ? constraints.biggest.shortestSide
                : widget.size;

            final side = min(widget.size, shortest);
            final s = Size.square(side);

            return SizedBox(
              width: side,
              height: side,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,

                // ✅ start drag ONLY if finger is on knob
                onPanDown: (d) {
                  if (!_isTouchOnKnob(d.localPosition, s)) return;
                  _dragging = true;
                  _setProgress(_progressFromOffset(d.localPosition, s));
                },

                onPanUpdate: (d) {
                  if (!_dragging) return;
                  _setProgress(_progressFromOffset(d.localPosition, s));
                },

                onPanEnd: (_) => _dragging = false,
                onPanCancel: () => _dragging = false,

                child: CustomPaint(
                  size: s,
                  painter: _MoodRingPainter(
                    progress: _p,
                    stroke: widget.stroke,
                  ),
                  child: Center(child: _CenterCard(child: step.center)),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 24.h),
        Text(
          step.label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500, // Medium
            height: 1.3, // 130%
            letterSpacing: -0.56, // -2%
          ),
        ),
      ],
    );
  }
}

class _CenterCard extends StatelessWidget {
  final Widget child;
  const _CenterCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0D11),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: const Color(0xFFF2D6CE),
            borderRadius: BorderRadius.circular(28),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class _MoodRingPainter extends CustomPainter {
  final double progress;
  final double stroke;

  _MoodRingPainter({required this.progress, required this.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2 - stroke / 2;

    final grad = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: const [
        Color(0xFFFF7AC8),
        Color(0xFFFFB368),
        Color(0xFF7FE9D6),
        Color(0xFFBBA7FF),
        Color(0xFFFF7AC8),
      ],
      stops: const [0.0, 0.28, 0.55, 0.78, 1.0],
    );

    final ringPaint = Paint()
      ..shader = grad.createShader(Rect.fromCircle(center: c, radius: r))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    canvas.drawCircle(c, r, ringPaint);

    final glowPaint = Paint()
      ..shader = grad.createShader(Rect.fromCircle(center: c, radius: r))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke + 10
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0);

    canvas.drawCircle(c, r, glowPaint);

    _drawSeparators(canvas, c, r, stroke);

    final p = progress.clamp(0.0, 1.0);
    final a = -pi / 2 + (2 * pi) * p;
    final knob = Offset(c.dx + r * cos(a), c.dy + r * sin(a));
    final knobRadius = stroke * 1.2;

    canvas.drawCircle(
      knob.translate(2.5, 3.5),
      knobRadius,
      Paint()
        ..color = Colors.black.withOpacity(0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    canvas.drawCircle(
      knob,
      knobRadius,
      Paint()..color = const Color(0xFFEFF7F5),
    );

    canvas.drawCircle(
      knob,
      knobRadius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white.withOpacity(0.85),
    );
  }

  void _drawSeparators(Canvas canvas, Offset c, double r, double stroke) {
    const segments = 12;

    final sepPaint = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < segments; i++) {
      final a = -pi / 2 + (2 * pi) * (i / segments);

      final inner = Offset(
        c.dx + (r - stroke / 2 + 2) * cos(a),
        c.dy + (r - stroke / 2 + 2) * sin(a),
      );
      final outer = Offset(
        c.dx + (r + stroke / 2 - 2) * cos(a),
        c.dy + (r + stroke / 2 - 2) * sin(a),
      );

      canvas.drawLine(inner, outer, sepPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MoodRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.stroke != stroke;
}

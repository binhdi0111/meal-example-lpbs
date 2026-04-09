import 'dart:ui';
import 'package:clean_architecture/shared_ui/ui/measure_size_widget.dart';
import 'package:flutter/material.dart';

class BounceLoopButton extends StatefulWidget {
  final Widget child;
  final BoxDecoration boxDecoration;

  final double offsetX;
  final double offsetY;
  final double scaleMax;

  const BounceLoopButton({
    super.key,
    required this.child,
    required this.boxDecoration,
    this.offsetX = 6,
    this.offsetY = 10,
    this.scaleMax = 1.1,
  });

  @override
  State<BounceLoopButton> createState() => _BounceLoopButtonState();
}

class _BounceLoopButtonState extends State<BounceLoopButton>
    with SingleTickerProviderStateMixin {
  Size? childSize;

  late AnimationController c;
  late Animation<double> t;

  @override
  void initState() {
    super.initState();

    c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    t = CurvedAnimation(parent: c, curve: Curves.easeInOut);

    c.repeat(reverse: true);
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (s) => setState(() => childSize = s),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (childSize != null)
            Container(
              width: childSize!.width,
              height: childSize!.height,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: widget.boxDecoration.borderRadius,
                boxShadow: widget.boxDecoration.boxShadow,
              ),
            ),

          AnimatedBuilder(
            animation: t,
            builder: (_, child) {
              final dx = lerpDouble(0, widget.offsetX, t.value)!;
              final dy = lerpDouble(0, -widget.offsetY, t.value)!;
              final scale = lerpDouble(1, widget.scaleMax, t.value)!;

              return Transform.translate(offset: Offset(dx, dy), child: child);
            },
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

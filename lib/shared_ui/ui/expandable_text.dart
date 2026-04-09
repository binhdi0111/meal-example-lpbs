import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableTextInlineEllipsis extends StatefulWidget {

  const ExpandableTextInlineEllipsis({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 3,
    this.expandText = 'Show more',
    this.collapseText = 'Show less',
    this.linkColor = Colors.red,
    this.textAlign = TextAlign.start,
  });
  final String text;
  final int maxLines;
  final TextStyle? style;
  final String expandText;
  final String collapseText;
  final Color linkColor;
  final TextAlign textAlign;

  @override
  State<ExpandableTextInlineEllipsis> createState() =>
      _ExpandableTextInlineEllipsisState();
}

class _ExpandableTextInlineEllipsisState
    extends State<ExpandableTextInlineEllipsis> {
  bool _expanded = false;
  bool _isOverflow = false;
  String _truncatedText = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _measure(constraints.maxWidth);

        if (_expanded || !_isOverflow) {
          /// FULL TEXT MODE
          return RichText(
            textAlign: widget.textAlign,
            text: TextSpan(
              style: widget.style,
              children: [
                TextSpan(text: widget.text),
                if (_isOverflow) const TextSpan(text: '\n'),
                if (_isOverflow)
                  TextSpan(
                    text: widget.collapseText,
                    style: widget.style?.copyWith(
                      color: widget.linkColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() => _expanded = false);
                      },
                  ),
              ],
            ),
          );
        }

        /// COLLAPSED MODE
        return RichText(
          maxLines: widget.maxLines,
          overflow: TextOverflow.clip,
          textAlign: widget.textAlign,
          text: TextSpan(
            style: widget.style,
            children: [
              TextSpan(text: _truncatedText),
              TextSpan(
                text: '... ', // Ellipsis
                style: widget.style,
              ),
              TextSpan(
                text: widget.expandText,
                style: widget.style?.copyWith(
                  color: widget.linkColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() => _expanded = true);
                  },
              ),
            ],
          ),
        );
      },
    );
  }

  void _measure(double maxWidth) {
    if (_expanded) return;

    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    _isOverflow = textPainter.didExceedMaxLines;

    if (!_isOverflow) return;

    _truncatedText = _computeTruncatedText(
      maxWidth: maxWidth,
    );
  }

  String _computeTruncatedText({required double maxWidth}) {
    final text = widget.text;

    final TextPainter fullPainter = TextPainter(
      text: TextSpan(text: text, style: widget.style),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    if (!fullPainter.didExceedMaxLines) {
      return text;
    }

    final suffixPainter = TextPainter(
      text: TextSpan(
        text: '... ${widget.expandText}',
        style: widget.style?.copyWith(
          color: widget.linkColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final double suffixWidth = suffixPainter.width + 12;

    int low = 0;
    int high = text.length;

    while (low < high) {
      final mid = (low + high) ~/ 2;

      final painter = TextPainter(
        text: TextSpan(
          text: text.substring(0, mid),
          style: widget.style,
        ),
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);

      final lines = painter.computeLineMetrics();

      final lastLineWidth =
      lines.isNotEmpty ? lines.last.width : 0;

      final fits = lines.length < widget.maxLines ||
          (lines.length == widget.maxLines &&
              lastLineWidth + suffixWidth <= maxWidth);

      if (fits) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }

    final safeIndex = low.clamp(1, text.length);

    return text.substring(0, safeIndex);
  }
}
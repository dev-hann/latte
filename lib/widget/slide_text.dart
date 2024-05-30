import 'package:flutter/material.dart';

class SlideText extends StatefulWidget {
  const SlideText(
    this.text, {
    super.key,
    this.style,
  });
  final String text;
  final TextStyle? style;

  @override
  State<SlideText> createState() => _SlideTextState();
}

class _SlideTextState extends State<SlideText> with TickerProviderStateMixin {
  late AnimationController animationController;
  late ScrollController scrollController;

  int count = 1;
  final maxCount = 100;
  final duration = const Duration(seconds: 20);
  double textMaxWidth = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initController();
    });
  }

  @override
  void didUpdateWidget(covariant SlideText oldWidget) {
    disposeController();
    initController();
    super.didUpdateWidget(oldWidget);
  }

  void disposeController() {
    animationController.stop();
    animationController.dispose();
    scrollController.dispose();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  void initController() {
    count = 1;
    textMaxWidth = computeTextWidth();
    scrollController = ScrollController();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
    animationController.addListener(() {
      if (scrollController.hasClients) {
        final value = animationController.value;
        scrollController.jumpTo(value * count * textMaxWidth);
        if (animationController.isCompleted) {
          count++;
        }
      }
    });
    animationController.repeat();
  }

  double computeTextWidth() {
    final painter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: widget.style,
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    return painter.maxIntrinsicWidth;
  }

  @override
  Widget build(BuildContext context) {
    final child = Text(
      widget.text,
      maxLines: 1,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        if (textMaxWidth < maxWidth) {
          return child;
        }
        return SingleChildScrollView(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.filled(maxCount, child),
          ),
        );
      },
    );
  }
}

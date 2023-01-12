import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedFadedText extends StatefulWidget {
  final Widget child;
  final double direction;

  const AnimatedFadedText({Key? key,required this.child,required this.direction})
      : super(key: key);

  @override
  State<AnimatedFadedText> createState() => _AnimatedFadedTextState();
}

class _AnimatedFadedTextState extends State<AnimatedFadedText>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(widget.direction, 0),
        end: Offset.zero,
      ).animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: widget.child,
      ),
    );
  }
}

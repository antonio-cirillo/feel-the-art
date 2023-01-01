import 'dart:async';

import 'package:flutter/material.dart';

class CustomDelayedDisplay extends StatefulWidget {
  final Widget child;
  final Duration fadingDuration;
  final Curve slidingCurve;
  final Offset slidingBeginOffset;
  final bool fadeIn;

  const CustomDelayedDisplay({
    Key? key,
    required this.child,
    this.fadingDuration = const Duration(milliseconds: 800),
    this.slidingCurve = Curves.decelerate,
    this.slidingBeginOffset = const Offset(0.0, 0.35),
    this.fadeIn = true,
  }) : super(key: key);

  @override
  State<CustomDelayedDisplay> createState() => _CustomDelayedDisplayState();
}

class _CustomDelayedDisplayState extends State<CustomDelayedDisplay> with SingleTickerProviderStateMixin {
  /// Controller of the opacity animation
  late AnimationController _opacityController;

  /// Sliding Animation offset
  late Animation<Offset> _slideAnimationOffset;

  /// Simple getter for widget's opacityTransitionDuration
  Duration get opacityTransitionDuration => widget.fadingDuration;

  /// Simple getter for widget's slidingCurve
  Curve get slidingCurve => widget.slidingCurve;

  /// Simple getter for widget's beginOffset
  Offset get beginOffset => widget.slidingBeginOffset;

  /// Simple getter for widget's fadeIn
  bool get fadeIn => widget.fadeIn;

  late bool _visibility;

  /// Initialize controllers, curve and offset with given parameters or default values
  /// Use a Timer in order to delay the animations if needed
  @override
  void initState() {
    super.initState();
    _visibility = fadeIn;

    _opacityController = AnimationController(
      vsync: this,
      duration: opacityTransitionDuration,
    )..addStatusListener((status) {
        if (mounted) {
          if (status == AnimationStatus.forward) {
            setState(() {
              _visibility = fadeIn;
            });
          } else if (status == AnimationStatus.reverse) {
            Timer(const Duration(milliseconds: 320), () {
              setState(() {
                _visibility = fadeIn;
              });
            });
          }
        }
      });

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: slidingCurve,
      parent: _opacityController,
    );

    _slideAnimationOffset = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(curvedAnimation);

    _runFadeAnimation();
  }

  /// Dispose the opacity controller
  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  /// Whenever the widget is updated and that fadeIn is different from the oldWidget, triggers the fade in
  /// or out animation.
  @override
  void didUpdateWidget(CustomDelayedDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fadeIn == fadeIn) {
      return;
    }
    _runFadeAnimation();
  }

  void _runFadeAnimation() {
    fadeIn ? _opacityController.forward() : _opacityController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visibility,
      child: FadeTransition(
        opacity: _opacityController,
        child: SlideTransition(
          position: _slideAnimationOffset,
          child: widget.child,
        ),
      ),
    );
  }
}

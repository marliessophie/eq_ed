import 'package:flutter/material.dart';

// TODO: extract ground to not hover

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(
      reverse: true,
    );
  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.06),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image(
        image: AssetImage('images/penguin.png'),
      ),
    );
  }
}

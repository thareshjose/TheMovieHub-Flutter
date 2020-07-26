import 'package:flutter/material.dart';

class ListLoadingAnimation extends StatefulWidget {
  ListLoadingAnimation({this.height});
  double height;
  @override
  _ListLoadingAnimationState createState() => _ListLoadingAnimationState();
}

class _ListLoadingAnimationState extends State<ListLoadingAnimation>
    with SingleTickerProviderStateMixin {
  double height;
  AnimationController _controller;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    height = widget.height;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.1, end: 0.5).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FadeTransition(
          opacity: _fadeInFadeOut,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: height,
              color: Color(0xFF282828),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:speed_test_app/screens/speed_test_screen.dart';

class GlowingButton extends StatefulWidget {
  final Color color1;
  final Color color2;

  const GlowingButton({
    Key? key,
    this.color1 = Colors.cyan,
    this.color2 = Colors.greenAccent,
  }) : super(key: key);

  @override
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        // Navigate to the SpeedTestScreen
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SpeedTestScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutQuart;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 900),
          ),
        );
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                widget.color1.withOpacity(0.8),
                widget.color2.withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color1.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(-10, 0),
              ),
              BoxShadow(
                color: widget.color2.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

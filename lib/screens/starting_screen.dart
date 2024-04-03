import 'package:flutter/material.dart';
import 'package:speed_test_app/design/app_colors.dart';
import 'package:speed_test_app/widgets/glowing_button.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 225, 255),
                    Color(0xFFF4E9CD),
                  ],
                  tileMode: TileMode.clamp,
                ).createShader(bounds);
              },
              child: const Text(
                "Diamond Test",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 40,
                  color: Color(0xFFF4E9CD),
                ),
              ),
            ),
            const Text(
              "Fast Internet, Faster Diamond Test",
              style: TextStyle(
                fontFamily: "FiraCode",
                fontSize: 17,
                color: Color(0xFFF4E9CD),
              ),
            ),
            const SizedBox(height: 50),
            const GlowingButton(
              color1: Color(0xFFF4E9CD),
              color2: Color.fromARGB(255, 0, 225, 255),
            ),
          ],
        ),
      ),
    );
  }
}

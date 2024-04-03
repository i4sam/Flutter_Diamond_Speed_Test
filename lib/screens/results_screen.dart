import 'dart:ui';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:speed_test_app/design/app_colors.dart';
import 'package:speed_test_app/widgets/subtext.dart';
import 'package:flutter/services.dart';

class ResultsScreen extends StatelessWidget {
  final double downloadRate;
  final double uploadRate;
  final String isp;
  final String ip;
  final String asn;

  const ResultsScreen({
    Key? key,
    required this.downloadRate,
    required this.uploadRate,
    required this.isp,
    required this.ip,
    required this.asn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.bgColor,
              AppColors.bgColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 230,
              left: 220,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color(0xFFA06CD5),
                    Color.fromARGB(255, 0, 225, 255),
                    Color(0xFFF4E9CD),
                  ]),
                ),
              ),
            ),
            Positioned(
              bottom: 250,
              right: 210,
              child: Transform.rotate(
                angle: 8,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color(0xff8da0cb),
                      Color.fromARGB(255, 0, 225, 255),
                      Color(0xFFF4E9CD),
                    ]),
                  ),
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 15),
                  child: Container(
                    width: 350,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SubTextWidget(
                            label:
                                "Download Rate: ${downloadRate.toStringAsFixed(2)} Mbps",
                            fontSize: 18,
                            icon: Icons.arrow_downward,
                            lineHeight: 2,
                            iconColor: const Color(0xFFA06CD5),
                          ),
                          SubTextWidget(
                            label:
                                "Upload Rate: ${uploadRate.toStringAsFixed(2)} Mbps",
                            fontSize: 18,
                            icon: Icons.arrow_upward,
                            lineHeight: 2,
                          ),
                          const SizedBox(height: 10),
                          SubTextWidget(
                            label: "IP: $ip",
                            fontSize: 16,
                            icon: Icons.location_on,
                            lineHeight: 2,
                            iconColor: Colors.red,
                          ),
                          SubTextWidget(
                            label: "ASN: $asn",
                            fontSize: 16,
                            icon: Icons.network_check,
                            lineHeight: 2.0,
                            iconColor: const Color.fromARGB(255, 0, 225, 255),
                          ),
                          SubTextWidget(
                            label: "ISP: $isp?",
                            fontSize: 16,
                            icon: Icons.wifi,
                            lineHeight: 2,
                            iconColor: Colors.amber,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 240,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.content_copy,
                                  color: Color.fromARGB(255, 227, 217, 236),
                                ),
                                onPressed: () {
                                  _copyToClipboard(context);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: 20,
              child: Row(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 2), // Adjust the spacing as needed
                  const Text(
                    'Back',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            const Positioned(
                top: 150,
                right: 37,
                child: Row(
                  children: [
                    Text(
                      "The Speed Test Results",
                      style: TextStyle(
                          fontFamily: "FiraCode",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF4E9CD),
                          fontSize: 25),
                    )
                  ],
                )),
            Positioned(
              bottom: 50,
              left: 48,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimateIcon(
                    key: UniqueKey(),
                    onTap: () {},
                    iconType: IconType.continueAnimation,
                    height: 25,
                    width: 40,
                    color: Color.fromARGB(255, 0, 225, 255),
                    animateIcon: AnimateIcons.diamond,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'developed by: ',
                    style: TextStyle(
                      fontFamily: "FiraCode",
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          "Hussain Al-Hasan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            color: Color(0xFFF4E9CD),
                          ),
                        ),
                      ),
                      AnimateIcon(
                        key: UniqueKey(),
                        onTap: () {},
                        iconType: IconType.continueAnimation,
                        height: 25,
                        width: 40,
                        color: Colors.white,
                        animateIcon: AnimateIcons.angel,
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Follow Me On Instagram: ',
                        style: TextStyle(
                          fontFamily: "FiraCode",
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '@F4sam ',
                        style: TextStyle(
                          fontFamily: "FiraCode",
                          color: Color(0xFFA06CD5),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    // Create a string with the details you want to copy
    String detailsText = '''
      Download Rate: ${downloadRate.toStringAsFixed(2)} Mbps
      Upload Rate: ${uploadRate.toStringAsFixed(2)} Mbps
      IP: $ip
      ASN: $asn
      ISP: $isp?
    ''';

    // Copy to clipboard
    Clipboard.setData(
      ClipboardData(
        text: detailsText,
      ),
    );

    // Show a snackbar to indicate that the text has been copied
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Details copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

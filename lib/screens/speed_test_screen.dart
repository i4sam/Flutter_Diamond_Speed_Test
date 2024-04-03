import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:speed_test_app/design/app_colors.dart';
import 'package:speed_test_app/widgets/dynamic_dots_widget.dart';
import 'package:speed_test_app/screens/results_screen.dart';
import 'package:speed_test_app/widgets/subtitle.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({super.key});
  @override
  State<SpeedTestScreen> createState() => SpeedTestState();
}

enum SpeedTestType {
  none,
  download,
  upload,
}

class SpeedTestState extends State<SpeedTestScreen> {
  double progressPercentValue = 0.0;
  double downloadRateValue = 0.0;
  double uploadRateValue = 0.0;
  double rateValue = 0.0;
  bool isServerSelectionInProgress = false;
  bool isTestingHasStarted = false;
  String? ip;
  String? isp;
  String? asn;
  String unitText = '';
  final speedTest = FlutterInternetSpeedTest();

  SpeedTestType currentTestType = SpeedTestType.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 90),
            child: ShaderMask(
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
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 73),
              Expanded(
                child: LinearPercentIndicator(
                  percent: progressPercentValue / 100.0,
                  lineHeight: 10,
                  backgroundColor: const Color.fromARGB(255, 127, 169, 193),
                  linearGradient: LinearGradient(
                    colors: [
                      AppColors.friendColor.withOpacity(0.8),
                      AppColors.parchmentColor.withOpacity(0.8),
                    ],
                  ),
                  barRadius: const Radius.circular(10),
                ),
              ),
              const SizedBox(width: 73),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          SfRadialGauge(
            axes: [
              RadialAxis(
                radiusFactor: 0.85,
                minorTicksPerInterval: 1,
                tickOffset: 3,
                useRangeColorForAxis: true,
                interval: 10,
                minimum: 0,
                maximum: 100,
                showLastLabel: true,
                axisLabelStyle: const GaugeTextStyle(color: Colors.white),
                ranges: [
                  GaugeRange(
                    startValue: 0,
                    endValue: 100,
                    color: AppColors.secondColor,
                    startWidth: 5,
                    endWidth: 10,
                  )
                ],
                pointers: [
                  NeedlePointer(
                    value: rateValue,
                    needleColor: AppColors.friendColor,
                    enableAnimation: true,
                    tailStyle: const TailStyle(
                        borderColor: Colors.blue,
                        color: Color(0xFFF4E9CD),
                        borderWidth: 0.3),
                    knobStyle: const KnobStyle(
                        borderColor: Color.fromARGB(255, 0, 225, 255),
                        color: Colors.white,
                        borderWidth: 0.01),
                  )
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Text(
                      rateValue.toStringAsFixed(2) + unitText,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                    angle: 90,
                    positionFactor: 0.8,
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SubtitleTextWidget(
                    label: getTestingLabel(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    icon: getTestingIcon(),
                    iconColor: AppColors.secondColor,
                  ),
                  if (isTestingHasStarted) const DynamicDotsWidget(),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          GestureDetector(
            onTapDown: (_) {
              // Add your custom logic here if needed
              setState(() {
                if (!isServerSelectionInProgress && !isTestingHasStarted) {
                  isTestingHasStarted = true;
                  testFuntion();
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: isTestingHasStarted ? 95 : 100,
              width: isTestingHasStarted ? 95 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondColor.withOpacity(0.8),
                    AppColors.friendColor.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.friendColor.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(-10, 0),
                  ),
                  BoxShadow(
                    color: AppColors.secondColor.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(5, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isTestingHasStarted
                    ? AnimateIcon(
                        key: UniqueKey(),
                        onTap: () {},
                        iconType: IconType.continueAnimation,
                        height: 25,
                        width: 70,
                        color: Colors.white,
                        animateIcon: AnimateIcons.diamond,
                      )
                    : const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 45,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 5,
              ),
              const Text(
                'developed by : ',
                style: TextStyle(
                  fontFamily: "FiraCode",
                  color: Colors.white,
                  fontSize: 16,
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
                        fontSize: 17,
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
            ],
          ),
        ],
      ),
    );
  }

  String getTestingLabel() {
    switch (currentTestType) {
      case SpeedTestType.download:
        return 'testing download speed in progress';
      case SpeedTestType.upload:
        return 'testing upload speed in progress';
      default:
        return 'let\'s test';
    }
  }

  IconData getTestingIcon() {
    switch (currentTestType) {
      case SpeedTestType.download:
        return Icons.arrow_downward;
      case SpeedTestType.upload:
        return Icons.arrow_upward;
      default:
        return Icons.play_arrow;
    }
  }

  testFuntion() async {
    resetValues();
    await speedTest.startTesting(
      onStarted: () {
        setState(() {
          isTestingHasStarted = true;
        });
      },
      onCompleted: (TestResult download, TestResult upload) {
        setState(() {
          unitText = download.unit == SpeedUnit.kbps ? 'Kp/s' : 'Mp/s';
          downloadRateValue = download.transferRate;
          rateValue = downloadRateValue;
          uploadRateValue = upload.transferRate;
        });
        setState(() {
          uploadRateValue = upload.transferRate;
          progressPercentValue = 100.0;
          rateValue = uploadRateValue;
          isTestingHasStarted = false;
        });

        // Navigate to the Results Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              downloadRate: downloadRateValue,
              uploadRate: uploadRateValue,
              isp: isp ?? "??",
              ip: ip ?? "N/A",
              asn: asn ?? "N/A",
            ),
          ),
        );
      },
      onProgress: (double percent, TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'Kp/s' : 'Mp/s';
          if (data.type == TestType.download) {
            downloadRateValue = data.transferRate;
            rateValue = downloadRateValue;
            progressPercentValue = percent;

            // Update the current test type
            currentTestType = SpeedTestType.download;
          } else {
            uploadRateValue = data.transferRate;
            rateValue = uploadRateValue;
            progressPercentValue = percent;

            // Update the current test type
            currentTestType = SpeedTestType.upload;
          }
        });
      },
      onError: (String errorMessage, String speedTestError) {
        print('error $errorMessage$speedTestError');
      },
      onDefaultServerSelectionInProgress: () {
        setState(() {
          isServerSelectionInProgress = true;
        });
      },
      onDefaultServerSelectionDone: (Client? client) {
        setState(() {
          isServerSelectionInProgress = false;
          ip = client!.ip;
          asn = client.asn;
          isp = client.isp;
        });
      },
      onDownloadComplete: (TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'Kp/s' : 'Mp/s';
          downloadRateValue = data.transferRate;
          rateValue = downloadRateValue;
        });
      },
      onUploadComplete: (TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'Kp/s' : 'Mp/s';
          uploadRateValue = data.transferRate;
          rateValue = uploadRateValue;
        });
      },
      // onCancel: () {
      //   // TODO Request cancelled callback
      // },
    );
  }

  resetValues() {
    setState(() {
      downloadRateValue = 0.0;
      uploadRateValue = 0.0;
      rateValue = 0.0;
      isTestingHasStarted = false;
      progressPercentValue = 0.0;
      isp = null;
      ip = null;
      asn = null;
    });
  }
}

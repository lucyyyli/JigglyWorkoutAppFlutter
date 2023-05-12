import 'dart:async';

import 'package:jiggly/constants/assets.dart';
import 'package:jiggly/constants/app_theme.dart';
import 'package:jiggly/utils/routes/routes.dart';
import 'package:jiggly/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: AppIconWidget(image: Assets.appLogoWithText, widthPct: 0.40),
      ),
      color: AppThemeData.appTheme.primaryColor,
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }
}

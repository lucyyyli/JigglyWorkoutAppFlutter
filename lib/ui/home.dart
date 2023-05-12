import 'package:jiggly/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import '../constants/app_theme.dart';
import '../constants/assets.dart';
import '../constants/strings.dart';
import '../widgets/app_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return _buildMainContent();
  }

  // widgets:--------------------------------------------------------------------
  Widget _buildMainContent() {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppThemeData.appTheme.colorScheme.tertiary,
              AppThemeData.appTheme.colorScheme.secondary,
              AppThemeData.appTheme.colorScheme.primary,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome back!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Text(
              "Ready to get Jiggly?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 30),
            MirrorAnimationBuilder<double>(
              tween: Tween(begin: -15.0, end: 15.0), // value for offset y-coordinate
              duration: const Duration(seconds: 1),

              curve: Curves.easeInOutSine, // non-linear animation
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value), // use animated value for y-coordinate
                  child: child,
                );
              },
              child: Hero(
                tag: Strings.logoHeroTag,
                child: AppIconWidget(image: Assets.appLogoNoText, widthPct: 0.5),
              ),
            ),
            SizedBox(height: 30),
            homeButton("Choose A Workout", Routes.chooseWorkout),
            SizedBox(height: 20),
            homeButton("Create New Workout", Routes.createWorkout),
          ],
        ),
      ),
    );
  }

  Widget homeButton(String text, String route) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: AppThemeData.appTheme.colorScheme.tertiary,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

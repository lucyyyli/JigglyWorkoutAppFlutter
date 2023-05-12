import 'package:jiggly/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import '../constants/assets.dart';
import '../constants/strings.dart';

class FloatingActionLogoWidget extends StatelessWidget {
  final doAction;
  final goToPage;

  const FloatingActionLogoWidget({
    bool this.doAction = true,
    String this.goToPage = "/home",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MirrorAnimationBuilder<double>(
      tween: Tween(begin: -5.0, end: 5.0), // value for offset y-coordinate
      duration: const Duration(seconds: 2),

      curve: Curves.easeInOutSine, // non-linear animation
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value), // use animated value for y-coordinate
          child: child,
        );
      },
      child: IconButton(
        onPressed: () {
          if (doAction) {
            returnHomeDialog(context);
          }
        },
        icon: Hero(
          tag: Strings.logoHeroTag,
          child: AppIconWidget(image: Assets.appLogoNoText),
        ),
        iconSize: 75,
      ),
    );
  }
}

returnHomeDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Stay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Go Home"),
    onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Just Checking"),
    content: Text("Would you like to return home?"),
    actions: [
      continueButton,
      cancelButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new, color: AppThemeData.appTheme.colorScheme.primary),
      onPressed: () {
        returnDialog(context);
      },
    );
  }
}

returnDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Stay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Go Back"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Are you sure you want to go back?",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
    content: Text(
      "Your unsaved changes will be discarded.",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodySmall,
    ),
    actions: [
      continueButton,
      cancelButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

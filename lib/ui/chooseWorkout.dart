import 'package:jiggly/utils/routes/routes.dart';
import 'package:flutter/material.dart';

// PLACEHOLDER SCREEN

class ChooseWorkoutScreen extends StatefulWidget {
  @override
  _ChooseWorkoutScreenState createState() => _ChooseWorkoutScreenState();
}

class _ChooseWorkoutScreenState extends State<ChooseWorkoutScreen> {
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Choose Workout"),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.doWorkout);
            },
            child: Text("Start Workout"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.createWorkout);
            },
            child: Text("Create New Workout"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
            },
            child: Text("Return Home"),
          ),
        ],
      ),
    );
  }
}

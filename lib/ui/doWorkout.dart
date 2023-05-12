import 'package:jiggly/utils/routes/routes.dart';
import 'package:flutter/material.dart';

// PLACEHOLDER SCREEN

class DoWorkoutScreen extends StatefulWidget {
  @override
  _DoWorkoutScreenState createState() => _DoWorkoutScreenState();
}

class _DoWorkoutScreenState extends State<DoWorkoutScreen> {
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
      title: Text("Do Workout"),
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
              Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
            },
            child: Text("Return Home"),
          ),
        ],
      ),
    );
  }
}

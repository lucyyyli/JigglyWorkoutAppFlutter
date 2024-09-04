import 'dart:math';
import 'dart:developer' as dev;
import 'package:jiggly/utils/routes/routes.dart';
import 'package:jiggly/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../constants/app_theme.dart';
import '../widgets/floating_action_logo_widget.dart';

// WORK IN PROGRESS

class CreateWorkoutScreen extends StatefulWidget {
  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  int numBlocks = 0;
  final _formKey = GlobalKey<FormBuilderState>();

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
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: FloatingActionLogoWidget()),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: BackButtonWidget(),
      title: Text(
        "Create Your Workout",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      backgroundColor: AppThemeData.appTheme.colorScheme.tertiary,
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
    return Expanded(
      child: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppThemeData.appTheme.colorScheme.secondaryContainer,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                _buildForm(),
                const SizedBox(height: 100),
              ],
            ))),
      ),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          Container(
              height: 165,
              width: 380,
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppThemeData.appTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(15.0), // Uniform radius
                // border: Border.all(
                //   width: 1,
                //   color: Theme.of(context).colorScheme.primaryContainer,
                // ),
              ),
              child: Column(children: [
                _buildFormWorkoutName(),
                _buildFormWorkoutType(),
              ])),
          const SizedBox(height: 15),
          for (int i = 0; i < numBlocks; i++) _buildFormWorkoutBlock(),
          Container(
              alignment: Alignment.center,
              width: 380,
              child: _buildFormAddRemoveBlockButton()),
          const SizedBox(height: 15),
          _saveWorkoutButton(),
        ],
      ),
    );
  }

  Widget _buildFormWorkoutName() {
    bool _titleHasError = false;

    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.disabled,
      name: 'workout_name',
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        labelText: "Workout Name",
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        errorStyle: TextStyle(height: 0.01),
        suffixIcon: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return workoutTypeExplanationDialog();
              },
            );
          },
          icon: Icon(Icons.question_mark_rounded),
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.maxLength(40),
        FormBuilderValidators.required(),
      ]),
      initialValue: 'Untitled Workout',
    );
  }

  Widget _buildFormWorkoutType() {
    return FormBuilderChoiceChip<String>(
      autovalidateMode: AutovalidateMode.disabled,
      alignment: WrapAlignment.spaceEvenly,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          height: 1.5, // sets the distance between label and input
        ),
        hintText: '',
        // needed to create space between label and input
        labelText: "Workout Type",
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        errorStyle: TextStyle(height: 0.01),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      name: 'type',
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      selectedColor: Theme.of(context).colorScheme.onTertiary,
      options: [
        FormBuilderChipOption(value: 'Circuit'),
        FormBuilderChipOption(value: 'Continuous'),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget workoutTypeExplanationDialog() {
    return AlertDialog(
      title: const Text("Workout Types"),
      titleTextStyle: Theme.of(context).textTheme.displayMedium,
      content: const Text("A circuit workout is finite."),
      contentTextStyle: Theme.of(context).textTheme.bodyLarge,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }

  Widget _buildFormWorkoutBlock() {
    return Column(
      children: [
        Container(
          height: 210,
          width: 380,
          padding: new EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppThemeData.appTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(15.0), // Uniform radius
          ),
          child: Column(
            children: <Widget>[
              _buildFormWorkoutBlockName(),
              _buildFormWorkoutBlockType(),
              _buildFormWorkoutBlockLength(),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildFormWorkoutBlockName() {
    bool _blockTitleHasError = false;
    String fieldName = 'block_name_' + numBlocks.toString();

    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.disabled,
      name: fieldName,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        labelText: "Block Name",
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        errorStyle: TextStyle(height: 0.01),
        suffixIcon: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return blockTypeExplanationDialog();
              },
            );
          },
          icon: Icon(Icons.question_mark_rounded),
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(40),
      ]),
      initialValue: 'Untitled Block ' + numBlocks.toString(),
      // textInputAction: TextInputAction.next,
    );
  }

  Widget _buildFormWorkoutBlockType() {
    String fieldName = 'block_type_' + numBlocks.toString();

    return FormBuilderChoiceChip<String>(
      autovalidateMode: AutovalidateMode.disabled,
      alignment: WrapAlignment.spaceEvenly,
      decoration: InputDecoration(
        labelText: "Block Type",
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        errorStyle: TextStyle(height: 0.01),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      name: fieldName,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      selectedColor: Theme.of(context).colorScheme.onTertiary,
      options: [
        FormBuilderChipOption(value: 'Active'),
        FormBuilderChipOption(value: 'Rest'),
        FormBuilderChipOption(value: 'None'),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget _buildFormAddRemoveBlockButton() {
    if (numBlocks == 0) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            addBlockButton(380),
          ]);
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            addBlockButton(185),
            removeBlockButton(),
          ]);
    }
  }

  Widget blockTypeExplanationDialog() {
    return AlertDialog(
      title: const Text("Block Types"),
      titleTextStyle: Theme.of(context).textTheme.displayMedium,
      contentTextStyle: Theme.of(context).textTheme.bodyLarge,
      content: const Text("Active or Rest."),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }

  Widget _buildFormWorkoutBlockLength() {
    return Container(
      width: 210,
      child: Row(
        children: <Widget>[
          _buildFormWorkoutBlockLengthMins(),
          SizedBox(width: 10),
          _buildFormWorkoutBlockLengthSecs(),
        ],
      ),
    );
  }

  Widget _buildFormWorkoutBlockLengthMins() {
    bool _blockLengthMinsError = false;
    String fieldNameMins = 'block_length_mins_' + numBlocks.toString();

    return SizedBox(
      width: 100,
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.disabled,
        name: fieldNameMins,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          hintText: "0",
          errorStyle: TextStyle(height: 0.01),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Text(
              "mins",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ],
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildFormWorkoutBlockLengthSecs() {
    bool _blockLengthSecsError = false;
    String fieldNameSecs = 'block_length_secs_' + numBlocks.toString();

    return SizedBox(
      width: 100,
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.disabled,
        name: fieldNameSecs,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          hintText: "0",
          errorStyle: TextStyle(height: 0.01),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Text(
              "secs",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 2.0)),
          disabledBorder: InputBorder.none,
        ),
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ],
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _saveWorkoutButton() {
    return Container(
      padding: EdgeInsets.all(0.0),
      width: 380,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: AppThemeData.appTheme.colorScheme.tertiary,
      ),
      child: TextButton(
        onPressed: () {
          _formKey.currentState?.validate();
          if (_formKey.currentState?.isValid == true) {
            _formKey.currentState?.save();
          }
        },
        child: Text(
          "Save Workout",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  Widget addBlockButton(double width) {
    return Container(
      padding: EdgeInsets.all(0.0),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: AppThemeData.appTheme.colorScheme.tertiary,
      ),
      child: TextButton(
        onPressed: () {
          setState(
            () {
              numBlocks++;
            },
          );
        },
        child: Text(
          "Add Block",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  Widget removeBlockButton() {
    return Container(
      padding: EdgeInsets.all(0.0),
      width: 185,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: AppThemeData.appTheme.colorScheme.tertiary,
      ),
      child: TextButton(
        onPressed: () {
          setState(
            () {
              numBlocks--;
            },
          );
        },
        child: Text(
          "Remove Block",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}

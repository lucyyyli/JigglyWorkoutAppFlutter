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
  int numBlocks = 1;
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
        floatingActionButton: FloatingActionLogoWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      backgroundColor: AppThemeData.appTheme.colorScheme.background,
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppThemeData.appTheme.colorScheme.background,
                  AppThemeData.appTheme.colorScheme.secondary,
                  AppThemeData.appTheme.colorScheme.secondaryContainer,
                  AppThemeData.appTheme.colorScheme.primary,
                ],
              ),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                _buildForm(),
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
          _buildFormWorkoutName(),
          _buildFormWorkoutType(),
          for (int i = 0; i < numBlocks; i++) _buildFormWorkoutBlock(),
          TextButton(
            onPressed: () {
              setState(
                () {
                  numBlocks++;
                  print(numBlocks);
                },
              );
            },
            child: Text("Add Another Workout Block"),
          ),
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
      decoration: InputDecoration(
        labelText: "Workout Name",
        suffixIcon: _titleHasError ? const Icon(Icons.error, color: Colors.red) : null,
      ),
      onChanged: (val) {
        _formKey.currentState?.fields['workout_name']?.validate();
        setState(
          () {
            _titleHasError = !(_formKey.currentState?.fields['title']?.validate() ?? false);
          },
        );
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(40),
      ]),
      initialValue: 'Untitled Workout',
      // textInputAction: TextInputAction.next,
    );
  }

  Widget _buildFormWorkoutType() {
    return FormBuilderChoiceChip<String>(
      autovalidateMode: AutovalidateMode.disabled,
      alignment: WrapAlignment.spaceEvenly,
      decoration: InputDecoration(
        labelText: "Workout Type",
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
      ),
      name: 'type',
      options: [
        FormBuilderChipOption(value: 'Circuit'),
        FormBuilderChipOption(value: 'Continuous'),
      ],
      onChanged: (val) {
        _formKey.currentState?.fields['type']?.validate();
      },
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget workoutTypeExplanationDialog() {
    return AlertDialog(
      title: const Text("Workout Types"),
      content: const Text("A circuit workout is finite."),
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
      children: <Widget>[
        _buildFormWorkoutBlockName(),
        _buildFormWorkoutBlockType(),
        _buildFormWorkoutBlockLength(),
      ],
    );
  }

  Widget _buildFormWorkoutBlockName() {
    bool _blockTitleHasError = false;
    String fieldName = 'block_name_' + numBlocks.toString();

    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.disabled,
      name: fieldName,
      decoration: InputDecoration(
        labelText: "Block Name",
        suffixIcon: _blockTitleHasError ? const Icon(Icons.error, color: Colors.red) : null,
      ),
      onChanged: (val) {
        _formKey.currentState?.fields[fieldName]?.validate();
        setState(
          () {
            _blockTitleHasError = !(_formKey.currentState?.fields[fieldName]?.validate() ?? false);
          },
        );
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(30),
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
      ),
      name: fieldName,
      options: [
        FormBuilderChipOption(value: 'Active'),
        FormBuilderChipOption(value: 'Rest'),
        FormBuilderChipOption(value: 'None'),
      ],
      onChanged: (val) {
        _formKey.currentState?.fields[fieldName]?.validate();
      },
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget blockTypeExplanationDialog() {
    return AlertDialog(
      title: const Text("Block Types"),
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
    return Column(
      children: <Widget>[
        _buildFormWorkoutBlockLengthMins(),
        _buildFormWorkoutBlockLengthSecs(),
      ],
    );
  }

  Widget _buildFormWorkoutBlockLengthMins() {
    bool _blockLengthMinsError = false;
    String fieldNameMins = 'block_length_mins_' + numBlocks.toString();

    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.disabled,
      name: fieldNameMins,
      decoration: InputDecoration(
        labelText: "mins",
        hintText: "0",
        suffixIcon: _blockLengthMinsError ? const Icon(Icons.error, color: Colors.red) : null,
      ),
      onChanged: (val) {
        _formKey.currentState?.fields[fieldNameMins]?.validate();
        setState(
          () {
            _blockLengthMinsError = !(_formKey.currentState?.fields[fieldNameMins]?.validate() ?? false);
          },
        );
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
        ],
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildFormWorkoutBlockLengthSecs() {
    bool _blockLengthSecsError = false;
    String fieldNameSecs = 'block_length_secs_' + numBlocks.toString();

    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.disabled,
      name: fieldNameSecs,
      decoration: InputDecoration(
        labelText: "secs",
        hintText: "30",
        suffixIcon: _blockLengthSecsError ? const Icon(Icons.error, color: Colors.red) : null,
      ),
      onChanged: (val) {
        _formKey.currentState?.fields[fieldNameSecs]?.validate();
        setState(
          () {
            _blockLengthSecsError = !(_formKey.currentState?.fields[fieldNameSecs]?.validate() ?? false);
          },
        );
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
        ],
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _saveWorkoutButton() {
    return Text("Save");
  }
}

// child: Column(
// children: <Widget>[
// TextButton(
// onPressed: () {
// Navigator.of(context).pushReplacementNamed(Routes.doWorkout);
// },
// child: Text("Start Workout"),
// ),
// TextButton(
// onPressed: () {
// Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
// },
// child: Text("Return Home"),
// ),
// ],
// ),

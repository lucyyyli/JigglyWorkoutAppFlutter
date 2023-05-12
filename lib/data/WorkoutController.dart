import "package:jiggly/data/Workout.dart";

// WORK IN PROGRESS

class WorkoutController {
  int? length;
  List? workoutList;

  WorkoutController() {
    length = 0;
    workoutList = new List.filled(0, null, growable: true);
  }
}

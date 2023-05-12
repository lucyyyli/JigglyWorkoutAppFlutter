import 'WorkoutBlock.dart';

// WORK IN PROGRESS

class Workout {
  String title;
  bool isContinuous;
  List<WorkoutBlock> blocks;
  int currBlock = -1;

  Workout(this.title, this.isContinuous, this.blocks);

  String getTitle() {
    return title;
  }

  WorkoutBlock getCurrBlock(int index) {
    return blocks[index];
  }
}

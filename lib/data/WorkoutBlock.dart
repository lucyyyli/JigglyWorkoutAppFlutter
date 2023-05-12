// WORK IN PROGRESS

enum BlockType { ACTIVE, REST }

class WorkoutBlock {
  String blockName;
  int blockDuration;
  BlockType blockType;

  WorkoutBlock(this.blockName, this.blockDuration, this.blockType);

  String getBlockName() {
    return blockName;
  }

  int getBlockDuration() {
    return blockDuration;
  }

  BlockType getBlockType() {
    return blockType;
  }
}

abstract class NewPageEvent{}

class NameChanged extends NewPageEvent{
  NameChanged({required this.name});
  String name;
}

class PackageCountChanged extends NewPageEvent{
  PackageCountChanged({required this.packageCount});
  int packageCount;
}

class ServingTypeChanged extends NewPageEvent{
  ServingTypeChanged({required this.servingType});
  String servingType;
}

class CurrentCountChanged extends NewPageEvent{
  CurrentCountChanged({required this.currentCount});
  int currentCount;
}

class ServingSizeChanged extends NewPageEvent{
  ServingSizeChanged({required this.servingSize});
  int servingSize;
}

class AddServingTime extends NewPageEvent{
  AddServingTime({required this.servingTime});
  String servingTime;
}

class RemoveServingTime extends NewPageEvent{
  RemoveServingTime({required this.servingTime});
  String servingTime;
}

class InstructionsChanged extends NewPageEvent{
  InstructionsChanged({required this.instruction});
  String instruction;
}


class SaveNew extends NewPageEvent{}

class CancelNew extends NewPageEvent{}
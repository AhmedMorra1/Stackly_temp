import 'package:stackly/models/supplement.dart';

abstract class EditPageEvent{}

class NewEdit extends EditPageEvent{
  NewEdit({required this.supplement});
  final Supplement supplement;
}

class NameChanged extends EditPageEvent{
  NameChanged({required this.name});
  String name;
}

class PackageCountChanged extends EditPageEvent{
  PackageCountChanged({required this.packageCount});
  int packageCount;
}

class ServingTypeChanged extends EditPageEvent{
  ServingTypeChanged({required this.servingType});
  String servingType;
}

class CurrentCountChanged extends EditPageEvent{
  CurrentCountChanged({required this.currentCount});
  int currentCount;
}

class ServingSizeChanged extends EditPageEvent{
  ServingSizeChanged({required this.servingSize});
  int servingSize;
}

class AddServingTime extends EditPageEvent{
  AddServingTime({required this.servingTime});
  String servingTime;
}

class RemoveServingTime extends EditPageEvent{
  RemoveServingTime({required this.servingTime});
  String servingTime;
}

class InstructionsChanged extends EditPageEvent{
  InstructionsChanged({required this.instruction});
  String instruction;
}

class DeleteEdit extends EditPageEvent{}

class SaveEdit extends EditPageEvent{}

class CancelEdit extends EditPageEvent{}
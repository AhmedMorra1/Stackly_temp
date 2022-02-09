import 'package:equatable/equatable.dart';
import 'package:stackly/models/supplement.dart';

enum NewPageStateStatus {
  initial,
  emptyName,
  packageCountEmpty,
  currentPackageCountEmpty,
  currentCountMoreThanPackageCount,
  servingSizeEmpty,
  servingTimesEmpty,
  successSave,
}

extension NewPageStateStatusX on NewPageStateStatus {
  bool get isInitial => this == NewPageStateStatus.initial;
  bool get isEmptyName => this == NewPageStateStatus.emptyName;
  bool get isPackageCountEmpty => this == NewPageStateStatus.packageCountEmpty;
  bool get isCurrentPackageCountEmpty => this == NewPageStateStatus.currentPackageCountEmpty;
  bool get isCurrentCountMoreThanPackageCount => this == NewPageStateStatus.currentCountMoreThanPackageCount;
  bool get isServingSizeEmpty => this == NewPageStateStatus.servingSizeEmpty;
  bool get isServingTimesEmpty => this == NewPageStateStatus.servingTimesEmpty;
  bool get isSuccessSave => this == NewPageStateStatus.successSave;
}

class NewPageState extends Equatable {
  const NewPageState({required this.status, required this.supplement});

  final Supplement supplement;
  final NewPageStateStatus status;

  NewPageState copyWith({
    Supplement? supplement,
    NewPageStateStatus? status,
  }) {
    return NewPageState(
      supplement: supplement ?? this.supplement,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [supplement,status];
}

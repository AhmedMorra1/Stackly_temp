import 'package:equatable/equatable.dart';
import 'package:stackly/models/supplement.dart';

enum EditPageStatus {
  initial,
  emptyName,
  packageCountEmpty,
  currentPackageCountEmpty,
  currentCountMoreThanPackageCount,
  servingSizeEmpty,
  servingTimesEmpty,
  successSave,
  successDelete,
}

extension EditPageStateStatusX on EditPageStatus {
  bool get isInitial => this == EditPageStatus.initial;
  bool get isEmptyName => this == EditPageStatus.emptyName;
  bool get isPackageCountEmpty => this == EditPageStatus.packageCountEmpty;
  bool get isCurrentPackageCountEmpty => this == EditPageStatus.currentPackageCountEmpty;
  bool get isCurrentCountMoreThanPackageCount => this == EditPageStatus.currentCountMoreThanPackageCount;
  bool get isServingSizeEmpty => this == EditPageStatus.servingSizeEmpty;
  bool get isServingTimesEmpty => this == EditPageStatus.servingTimesEmpty;
  bool get isSuccessSave => this == EditPageStatus.successSave;
  bool get isSuccessDelete => this == EditPageStatus.successDelete;
}

class EditPageState extends Equatable {
  const EditPageState({required this.status, required this.supplement});

  final Supplement supplement;
  final EditPageStatus status;

  EditPageState copyWith({
    Supplement? supplement,
    EditPageStatus? status,
  }) {
    return EditPageState(
      supplement: supplement ?? this.supplement,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [supplement,status];
}
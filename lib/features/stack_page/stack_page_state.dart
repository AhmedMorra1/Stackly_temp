import 'package:equatable/equatable.dart';
import 'package:stackly/models/supplement.dart';

enum StackPageStatus { initial, success, error, loading }

extension StackPageStatusX on StackPageStatus {
  bool get isInitial => this == StackPageStatus.initial;
  bool get isLoading => this == StackPageStatus.loading;
  bool get isSuccess => this == StackPageStatus.success;
  bool get isError => this == StackPageStatus.error;
}

class StackPageState extends Equatable {
  const StackPageState({
    this.status = StackPageStatus.initial,
    List<Supplement>? stackList,
  }) : stackList = stackList ?? const [];

  final List<Supplement> stackList;
  final StackPageStatus status;

  StackPageState copyWith({
    List<Supplement>? stackList,
    StackPageStatus? status,
  }) {
    return StackPageState(
      stackList: stackList ?? this.stackList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stackList,
      ];
}

import 'package:equatable/equatable.dart';

enum SupsListStatus { initial, success, error, loading }

extension SupsListStatusX on SupsListStatus {
  bool get isInitial => this == SupsListStatus.initial;
  bool get isSuccess => this == SupsListStatus.success;
  bool get isError => this == SupsListStatus.error;
  bool get isLoading => this == SupsListStatus.loading;
}

class SupsListState extends Equatable {
  const SupsListState({
    List<Map>? supsList,
    this.status = SupsListStatus.initial,
  }) : supsList = supsList ?? const [];

  final List<Map> supsList;
  final SupsListStatus status;

  SupsListState copyWith({
    List<Map>? supsList,
    SupsListStatus? status,
  }) {
    return SupsListState(
      supsList: supsList ?? this.supsList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        supsList,
        status,
      ];
}

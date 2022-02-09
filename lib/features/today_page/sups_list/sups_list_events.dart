abstract class SupsListEvent {}

class SupsListEventLoad extends SupsListEvent {
  SupsListEventLoad({required this.dateTime});
  DateTime dateTime;
}

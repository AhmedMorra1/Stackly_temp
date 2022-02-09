import 'package:bloc/bloc.dart';

class DateRowCubit extends Cubit<DateTime>{
  DateRowCubit() : super(DateTime.now());
  changeDate(DateTime dateTime) => emit(dateTime);
}
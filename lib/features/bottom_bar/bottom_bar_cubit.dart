import 'package:bloc/bloc.dart';

class BottomAppBarCubit extends Cubit<int>{
  BottomAppBarCubit() : super(0);
  changeTab(int tabIndex) => emit(tabIndex);
}
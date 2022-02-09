import 'package:bloc/bloc.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_events.dart';
import 'package:stackly/features/today_page/sups_list/sups_list_states.dart';
import 'package:stackly/repositories/sups_list_repository.dart';

class SupsListBloc extends Bloc<SupsListEvent,SupsListState> {
  SupsListBloc() : super(const SupsListState()){
    on<SupsListEventLoad>((event, emit) async {
      // print('Subs List Event Called');
      emit(state.copyWith(status: SupsListStatus.loading));
      try{
        List<Map> supsList = await SupsRepository(today: event.dateTime.toString().substring(0,10)).getSpecifics();
        //Load the list
        if (supsList.isEmpty) {
          emit(state.copyWith(status: SupsListStatus.initial));
        }else{
          emit(state.copyWith(status: SupsListStatus.success,supsList: supsList));
        }
      }catch(e){
        emit(state.copyWith(status: SupsListStatus.error));
      }
    });
  }
}
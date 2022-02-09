import 'package:bloc/bloc.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/repositories/sups_list_repository.dart';
import 'stack_page_state.dart';
import 'stack_page_event.dart';

class StackPageBloc extends Bloc<StackPageEvent,StackPageState> {
  StackPageBloc() : super(const StackPageState()){
    on<StackPageEventLoad>((event, emit) async {
      //print('StackPageEventLoad called.... When the state status was${state.status} and the state list was${state.stackList}');
      emit(state.copyWith(status: StackPageStatus.loading));
      //print('Loading State Should be Emitted');
      //print('Lets Check the current state if it is loading : ${state.status}');
      try{
        List<Supplement> stackList = await SupsRepository().getSupplements();
        if (stackList.isEmpty) {
          emit(state.copyWith(status: StackPageStatus.initial));
        }else{
          emit(state.copyWith(status: StackPageStatus.success,stackList: stackList));
        }
      }catch(e){
        emit(state.copyWith(status: StackPageStatus.error));
      }
    });
  }
}
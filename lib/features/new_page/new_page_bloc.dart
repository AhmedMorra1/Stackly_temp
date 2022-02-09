import 'package:bloc/bloc.dart';
import 'package:stackly/features/new_page/new_page_event.dart';
import 'package:stackly/features/new_page/new_page_state.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/repositories/new_sup_repository.dart';

class NewPageBloc extends Bloc<NewPageEvent, NewPageState> {
  NewPageBloc() : super(NewPageState(supplement: Supplement.initial(), status: NewPageStateStatus.initial )) {
    on<NameChanged>(_onNameChanged);
    on<PackageCountChanged>(_onPackageCountChanged);
    on<ServingTypeChanged>(_onServingTypeChanged);
    on<CurrentCountChanged>(_onCurrentCountChanged);
    on<ServingSizeChanged>(_onServingSizeChanged);
    on<AddServingTime>(_onAddServingTime);
    on<RemoveServingTime>(_onRemoveServingTime);
    on<InstructionsChanged>(_onInstructionsChanged);
    on<SaveNew>(_onSaveNew);
    on<CancelNew>(_onCancelNew);
  }

  void _onNameChanged(NameChanged event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(name: event.name),status: NewPageStateStatus.initial));
  }

  void _onPackageCountChanged(PackageCountChanged event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(totalCount: event.packageCount),status: NewPageStateStatus.initial));
  }

  void _onServingTypeChanged(ServingTypeChanged event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(servingType: event.servingType),status: NewPageStateStatus.initial));
  }

  void _onCurrentCountChanged(CurrentCountChanged event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(currentCount: event.currentCount),status: NewPageStateStatus.initial));
  }

  void _onServingSizeChanged(ServingSizeChanged event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(servingSize: event.servingSize),status: NewPageStateStatus.initial));
  }

  void _onAddServingTime(AddServingTime event, Emitter<NewPageState> emit) {
    List<String> servingTimes = state.supplement.servingTimes!;
    servingTimes.add(event.servingTime);
    emit(state.copyWith(supplement: state.supplement.copyWith(servingTimes: servingTimes),status: NewPageStateStatus.initial));
  }

  void _onRemoveServingTime(RemoveServingTime event, Emitter<NewPageState> emit) {
    List<String> servingTimes = state.supplement.servingTimes!;
    servingTimes.remove(event.servingTime);
    emit(state.copyWith(supplement: state.supplement.copyWith(servingTimes: servingTimes),status: NewPageStateStatus.initial));
  }

  void _onInstructionsChanged(InstructionsChanged event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(instructions: event.instruction),status: NewPageStateStatus.initial));
  }

  void _onSaveNew(SaveNew event, Emitter<NewPageState> emit) async {
    if (state.supplement.name!.isEmpty==true){
      emit(state.copyWith(status: NewPageStateStatus.emptyName));
    }else if (state.supplement.totalCount == 0){
      emit(state.copyWith(status: NewPageStateStatus.packageCountEmpty));
    }else if (state.supplement.currentCount == 0){
      emit(state.copyWith(status: NewPageStateStatus.currentPackageCountEmpty));
    }else if (state.supplement.currentCount! > state.supplement.totalCount!){
      emit(state.copyWith(status: NewPageStateStatus.currentCountMoreThanPackageCount));
    }else if (state.supplement.servingSize ==0){
      emit(state.copyWith(status: NewPageStateStatus.servingSizeEmpty));
    }else if (state.supplement.servingTimes!.isEmpty){
      emit(state.copyWith(status: NewPageStateStatus.servingTimesEmpty));
    }else{
      await NewSupRepository(supplement: state.supplement).addNewSupplement();
      emit(state.copyWith(status: NewPageStateStatus.successSave,supplement: Supplement.initial()));
    }

  }

  void _onCancelNew(CancelNew event, Emitter<NewPageState> emit) {
    emit(state.copyWith(supplement:Supplement.initial(),status: NewPageStateStatus.initial));
  }
}

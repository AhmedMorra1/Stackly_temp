import 'package:bloc/bloc.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/repositories/edit_sup_repository.dart';

import 'edit_page_event.dart';
import 'edit_page_state.dart';

class EditPageBloc extends Bloc<EditPageEvent, EditPageState> {
  EditPageBloc() : super(EditPageState(supplement: Supplement.initial(), status: EditPageStatus.initial )) {
    on<NewEdit>(_onNewEdit);
    on<NameChanged>(_onNameChanged);
    on<PackageCountChanged>(_onPackageCountChanged);
    on<ServingTypeChanged>(_onServingTypeChanged);
    on<CurrentCountChanged>(_onCurrentCountChanged);
    on<ServingSizeChanged>(_onServingSizeChanged);
    on<AddServingTime>(_onAddServingTime);
    on<RemoveServingTime>(_onRemoveServingTime);
    on<InstructionsChanged>(_onInstructionsChanged);
    on<DeleteEdit>(_onDeleteEdit);
    on<SaveEdit>(_onSaveEdit);
    on<CancelEdit>(_onCancelEdit);
  }

  void _onNewEdit(NewEdit event, Emitter<EditPageState> emit){
    emit(state.copyWith(supplement: event.supplement ,status: EditPageStatus.initial));
  }

  void _onNameChanged(NameChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(name: event.name),status: EditPageStatus.initial));
  }

  void _onPackageCountChanged(PackageCountChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(totalCount: event.packageCount),status: EditPageStatus.initial));
  }

  void _onServingTypeChanged(ServingTypeChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(servingType: event.servingType),status: EditPageStatus.initial));
  }

  void _onCurrentCountChanged(CurrentCountChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(currentCount: event.currentCount),status: EditPageStatus.initial));
  }

  void _onServingSizeChanged(ServingSizeChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(servingSize: event.servingSize),status: EditPageStatus.initial));
  }

  void _onAddServingTime(AddServingTime event, Emitter<EditPageState> emit) {
    List<String> servingTimes = state.supplement.servingTimes!;
    servingTimes.add(event.servingTime);
    emit(state.copyWith(supplement: state.supplement.copyWith(servingTimes: servingTimes),status: EditPageStatus.initial));
  }

  void _onRemoveServingTime(RemoveServingTime event, Emitter<EditPageState> emit) {
    List<String> servingTimes = state.supplement.servingTimes!;
    servingTimes.remove(event.servingTime);
    emit(state.copyWith(supplement: state.supplement.copyWith(servingTimes: servingTimes),status: EditPageStatus.initial));
  }

  void _onInstructionsChanged(InstructionsChanged event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement: state.supplement.copyWith(instructions: event.instruction),status: EditPageStatus.initial));
  }

  void _onDeleteEdit(DeleteEdit event, Emitter<EditPageState> emit) async {
    await EditSupRepository(supplement: state.supplement).deleteSupplement();
    emit(state.copyWith(status: EditPageStatus.successDelete,supplement: Supplement.initial()));
  }

  void _onSaveEdit(SaveEdit event, Emitter<EditPageState> emit) async {
    if (state.supplement.name!.isEmpty==true){
      emit(state.copyWith(status: EditPageStatus.emptyName));
    }else if (state.supplement.totalCount == 0){
      emit(state.copyWith(status: EditPageStatus.packageCountEmpty));
    }else if (state.supplement.currentCount == 0){
      emit(state.copyWith(status: EditPageStatus.currentPackageCountEmpty));
    }else if (state.supplement.currentCount! > state.supplement.totalCount!){
      emit(state.copyWith(status: EditPageStatus.currentCountMoreThanPackageCount));
    }else if (state.supplement.servingSize ==0){
      emit(state.copyWith(status: EditPageStatus.servingSizeEmpty));
    }else if (state.supplement.servingTimes!.isEmpty){
      emit(state.copyWith(status: EditPageStatus.servingTimesEmpty));
    }else{
      await EditSupRepository(supplement: state.supplement).updateOldSupplement();
      emit(state.copyWith(status: EditPageStatus.successSave,supplement: Supplement.initial()));
    }

  }

  void _onCancelEdit(CancelEdit event, Emitter<EditPageState> emit) {
    emit(state.copyWith(supplement:Supplement.initial(),status: EditPageStatus.initial));
  }
}

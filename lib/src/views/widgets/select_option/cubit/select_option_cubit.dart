import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'select_option_state.dart';
part 'select_option_cubit.freezed.dart';

@lazySingleton
class SelectCubit extends Cubit<SelectState> {
  SelectCubit() : super(const SelectState.initial());

  void select(SelectOptionModel option) =>
      emit(SelectState.chosen(option: option));

  void toggleOpen() {
    final openState = state.mapOrNull(open: (s) => s);
    if (openState != null) {
      emit(openState.selected != null
          ? SelectState.chosen(option: openState.selected!)
          : const SelectState.initial());
    } else {
      emit(SelectState.open(
          selected: state.mapOrNull(chosen: (s) => s.option)));
    }
  }

  void dismiss() {
    final openState = state.mapOrNull(open: (s) => s);
    if (openState == null) return;
    emit(openState.selected != null
        ? SelectState.chosen(option: openState.selected!)
        : const SelectState.initial());
  }
}

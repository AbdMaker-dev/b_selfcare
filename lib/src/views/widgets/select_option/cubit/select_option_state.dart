part of 'select_option_cubit.dart';

@freezed
class SelectState with _$SelectState {
  const factory SelectState.initial() = _SelectInitial;
  const factory SelectState.open({SelectOptionModel? selected}) = _SelectOpen;
  const factory SelectState.chosen({required SelectOptionModel option}) = _SelectChosen;
}

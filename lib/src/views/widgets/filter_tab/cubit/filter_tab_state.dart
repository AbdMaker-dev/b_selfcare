import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_tab_state.freezed.dart';

@freezed
class FilterTabState with _$FilterTabState {
  const factory FilterTabState.initial() = _Initial;
  const factory FilterTabState.changeLoading() = ChangeLoading;
  const factory FilterTabState.change({required int selectedIndex}) = Change;
}
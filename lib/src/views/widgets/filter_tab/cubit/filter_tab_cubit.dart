import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'filter_tab_state.dart';
export 'filter_tab_state.dart';

@lazySingleton
class FilterTabCubit extends Cubit<FilterTabState> {
  FilterTabCubit() : super(const FilterTabState.initial());

  void selectTab(int index)  {
    emit(FilterTabState.changeLoading());
    emit(FilterTabState.change(selectedIndex: index));
  }
}

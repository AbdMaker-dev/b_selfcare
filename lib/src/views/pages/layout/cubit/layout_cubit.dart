import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'layout_state.dart';
part 'layout_cubit.freezed.dart';

@lazySingleton
class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState.initial());



  void onRouteChange({String? route, dynamic args}) {
    emit(LayoutState.initial());
    emit(LayoutState.routeChanged(route, args));
  }
}

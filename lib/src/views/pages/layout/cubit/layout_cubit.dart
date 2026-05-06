import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'layout_state.dart';
part 'layout_cubit.freezed.dart';

@lazySingleton
class LayoutCubit extends Cubit<LayoutState> {
  final HttpHelper _httpHelper;

  UserProfileModel? currentUser;

  LayoutCubit(this._httpHelper) : super(LayoutState.initial());

  void onRouteChange({String? route, dynamic args}) {
    emit(LayoutState.initial());
    emit(LayoutState.routeChanged(route, args));
  }

  Future<bool> fetchCurrentUser() async {
    final response = await _httpHelper.handleGetRequest("auth/user");
    return response.fold(
      (left) => false,
      (right) {
        final data = right.response?['data'];
        if (data != null) {
          currentUser = UserProfileModel.fromJson(data as Map<String, dynamic>);
          return true;
        }
        return false;
      },
    );
  }
}

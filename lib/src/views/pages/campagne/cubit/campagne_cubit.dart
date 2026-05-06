import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/domain/usecases/campaign_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'campagne_state.dart';
part 'campagne_cubit.freezed.dart';

@lazySingleton
class CampagneCubit extends Cubit<CampagneState> {
  final CampaignUsecase campaignUsecase;

  CampagneCubit(this.campaignUsecase) : super(const CampagneState.initial());

  Future<void> getCampaigns({required dynamic data}) async {
    emit(const CampagneState.getCampaignsLoading());
    final res = await campaignUsecase.getCampaigns(data: data);
    res.fold(
      (failure) => emit(CampagneState.getCampaignsFailed(failure.message)),
      (data) => emit(CampagneState.getCampaignsLoaded(data: data)),
    );
  }
}

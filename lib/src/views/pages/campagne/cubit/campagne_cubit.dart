import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/provisioning/provisioning_log_model.dart';
import 'package:b_selfcare/src/domain/usecases/campaign_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'campagne_state.dart';
part 'campagne_cubit.freezed.dart';

@lazySingleton
class CampagneCubit extends Cubit<CampagneState> {
  final CampaignUsecase campaignUsecase;

  CampagneCubit(this.campaignUsecase) : super(const CampagneState.initial());

  ProvisioningLogsResponseModel? provisioningLogsData;
  bool logsLoading = false;

  Future<void> getProvisioningLogs({dynamic params}) async {
    logsLoading = true;
    final res = await campaignUsecase.getProvisioningLogs(params: params);
    logsLoading = false;
    res.fold(
      (_) {},
      (data) {
        provisioningLogsData = data;
        emit(state);
      },
    );
  }

  Future<void> getCampaigns({required dynamic data}) async {
    emit(const CampagneState.getCampaignsLoading());
    final res = await campaignUsecase.getCampaigns(data: data);
    res.fold(
      (failure) => emit(CampagneState.getCampaignsFailed(failure.message)),
      (data) => emit(CampagneState.getCampaignsLoaded(data: data)),
    );
  }

  static const _postActions = {'execute', 'retrigger'};

  Future<void> executeCampaigns({required int id, required String execute}) async {
    emit(const CampagneState.executeCampaignsLoading());
    final res = _postActions.contains(execute)
        ? await campaignUsecase.triggerAndExecuteCampaigns(id: id, execute: execute)
        : await campaignUsecase.pauseAndCancelAndReactivateCampaigns(id: id, execute: execute);

    res.fold(
          (failure) => emit(CampagneState.executeCampaignsFailed(failure.message)),
          (data) => emit(CampagneState.executeCampaignsLoaded(data: data)),
    );
  }
}

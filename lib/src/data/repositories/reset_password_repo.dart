import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class ResetPasswordRepo {
  final LocaHelper localHelper;
  final HttpHelper htttHelper;
  ResetPasswordRepo(this.localHelper, this.htttHelper);

  Future<Either<Failure, DataResponseModel>> forgetPassword({required String email}) async {
    var res = await htttHelper.handlePostRequest("auth/password/forgot", {"email": email},showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var forgetPasswordData = DataResponseModel.fromJson(success.response);
        return Right(forgetPasswordData);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> resetPassword({required String email,required String password,required String passwordConfirmation,required String token}) async {
    var res = await htttHelper.handlePostRequest("auth/password/reset ",
        {
          "token":token,
          "email": email,
          "password":password,
          "password_confirmation":passwordConfirmation
        },
        showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var forgetPasswordData = DataResponseModel.fromJson(success.response);
        return Right(forgetPasswordData);
      },
    );
  }
}
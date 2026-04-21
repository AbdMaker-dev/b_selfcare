

import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/repositories/reset_password_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUsecase {
  final ResetPasswordRepo resetPasswordRepo;
  ResetPasswordUsecase({required this.resetPasswordRepo});

  Future<Either<Failure, DataResponseModel>> forgetPassword({required String email}) async {
    var res = await resetPasswordRepo.forgetPassword(email: email);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> resetPassword({required String email,required String password,required String passwordConfirmation,required String token}) async {
    var res = await resetPasswordRepo.resetPassword(email: email, password: password, passwordConfirmation: passwordConfirmation, token: token);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

}
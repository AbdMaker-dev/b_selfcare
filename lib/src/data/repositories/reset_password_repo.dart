import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:injectable/injectable.dart';

@singleton
class ResetPasswordRepo {
  final LocaHelper localHelper;
  final HttpHelper htttHelper;
  ResetPasswordRepo(this.localHelper, this.htttHelper);
}
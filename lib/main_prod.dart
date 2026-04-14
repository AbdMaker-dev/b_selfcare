import 'main.dart';
import 'src/data/models/app_config.dart';

void main() {
  AppConfig.create(
    appName: "Fttx App Agent",
    baseUrl: "https://fttx-appliterrain.free.sn/fttx_bo/api/v1",
    countryCode: 'SN',
    langue: "fr",
  );
  mainCommon();
}

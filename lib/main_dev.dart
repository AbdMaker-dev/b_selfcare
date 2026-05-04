import 'main.dart';
import 'src/data/models/app_config.dart';

void main() {
  AppConfig.create(
      appName: "Fttx App Agent Dev",
      baseUrl: "https://b2b-operateur.yasbusiness.sn:8273/api/v1",
      countryCode: 'SN',
      langue: "fr");
  mainCommon();
}

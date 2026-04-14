import 'main.dart';
import 'src/data/models/app_config.dart';

void main() {
  AppConfig.create(
      appName: "Fttx App Agent Dev",
      baseUrl: "https://10.0.92.10:10009/api/v1",
      countryCode: 'SN',
      langue: "fr");
  mainCommon();
}

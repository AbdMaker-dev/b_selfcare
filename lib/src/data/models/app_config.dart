class AppConfig {
  String appName = "";
  String baseUrl = "";
  String countryCode = "";
  String langue = "fr";

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = "",
    String baseUrl = "",
    String countryCode = "",
    String langue = "fr",
  }) {
    return shared = AppConfig(appName, baseUrl, countryCode, langue);
  }

  AppConfig(this.appName, this.baseUrl, this.countryCode, this.langue);

  bool canImsi() {
    return countryCode.toUpperCase() == "SN";
  }
}

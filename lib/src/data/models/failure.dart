class Failure {
  int code;
  String message;

  dynamic error;

  String? errorName;
  String? errorDescription;
  String? codeError;

  Failure(
    this.code,
    this.message, {
    this.errorName,
    this.errorDescription,
    this.codeError,
  });
}

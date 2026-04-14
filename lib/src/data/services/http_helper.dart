import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

import '../models/app_config.dart';
import '../models/failure.dart';
import '../models/success.dart';
import 'local_helper.dart';

@injectable
class HttpHelper {
  final Dio _dio = Dio();
  final LocaHelper locaHelper;
  bool showL = false;
  bool isGet = false;

  HttpHelper(this.locaHelper) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onError: _handleError,
        onResponse: _handleResponse,
      ),
    );
  }

  void _showLoader() {
    EasyLoading.show(status: 'Chargement...');
  }

  void _hideLoader() {
    EasyLoading.dismiss();
  }

  void _showMessage(String message, {bool isError = false}) {
    if (isError) {
      EasyLoading.showError(message, dismissOnTap: true);
      return;
    }
    EasyLoading.showSuccess(message, dismissOnTap: true);
  }

  Future<void> _handleResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (showL) {
      _hideLoader();
    }
    return handler.next(response);
  }

  Future<void> _handleRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      print("========= API PATH ===========");
      print(options.path);
    }
    if (!_isContainsPath(options.path)) {
      final String accessToken = (await locaHelper.getToken()) ?? "";
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  Future<void> _handleError(DioException error, ErrorInterceptorHandler handler) async {
    try {
      if (showL || isGet) {
        _hideLoader();
      }
      if (kDebugMode) {
        print("========== HTTP ERROR =========");
        print(error.response?.statusCode);
        print(error.response?.statusMessage);
        // print(((error.response?.data?['data']?['errors'] is List && (error.response?.data?['data']?['errors'])?.isNotEmpty))
        //   ? error.response?.data?['data']?['errors'][0]
        //   : error.response?.data?['data']?['errors'] is Map<String, dynamic>
        //   ? error.response?.data?['data']?['errors']['message']
        //   : error.response?.data?['message'] ?? "An error has occurred. Please check your connection status.",
        // );
      }
      // _showMessage(
      //   (((error.response?.data?['data']?['errors'] is List && (error.response?.data?['data']?['errors'])?.isNotEmpty))
      //   ? error.response?.data?['data']?['errors'][0]
      //   : error.response?.data?['data']?['errors'] is Map<String, dynamic>
      //   ? error.response?.data?['data']?['errors']['message']
      //   : error.response?.data?['message'] ?? "An error has occurred. Please check your connection status.").toString(),
      //   isError: true,
      // );
      if (error.response?.statusCode == 401) {}
      handler.next(error);
    } catch (e) {
      _showMessage("An error has occurred. Please check your connection status.", isError: true);
    }
  }

  bool _isContainsPath(String path) {
    return path.contains('/auth/login') || path.contains('/auth/check-otp');
  }

  Future<Either<Failure, Success>> handlePostRequest(String api, Map<String, dynamic> data, { showSuccessToast = true, showLoader = true}) async {
    try {
      showL = showLoader;
      if (showLoader) {
        _showLoader();
      }
      final res = await _dio.post('${AppConfig.shared.baseUrl}/$api', data: data);
      if (showSuccessToast) {
        _showMessage((res.data?['message'] ?? res.data.toString()).toString());
      }
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handlePutRequest(
    String api,
    Map<String, dynamic> data, {
    showSuccessToast = false,
    showLoader = true,
  }) async {
    try {
      showL = showLoader;
      if (showLoader) {
        _showLoader();
      }
      final res = await _dio.put(
        '${AppConfig.shared.baseUrl}/$api',
        data: data,
      );
      if (showSuccessToast) {
        _showMessage((res.data?['message'] ?? res.data.toString()).toString());
      }
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handleFormDataPutRequest(
    String api,
    FormData data, {
    showSuccessToast = true,
    showLoader = true,
  }) async {
    try {
      showL = showLoader;
      if (showLoader) {
        _showLoader();
      }
      final res = await _dio.put(
        '${AppConfig.shared.baseUrl}/$api',
        data: data,
      );
      if (showSuccessToast) {
        _showMessage((res.data?['message'] ?? res.data.toString()).toString());
      }
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handleFormDataPostRequest(
    String api,
    FormData data, {
    showSuccessToast = true,
    showLoader = true,
  }) async {
    try {
      showL = showLoader;
      if (showLoader) {
        _showLoader();
      }
      final res = await _dio.post(
        '${AppConfig.shared.baseUrl}/$api',
        data: data,
      );
      if (showSuccessToast) {
        _showMessage((res.data?['message'] ?? res.data.toString()).toString());
      }
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handleGetRequest(
    String api, {
    params,
    data,
    showLoader = false,
  }) async {
    try {
      showL = showLoader;
      isGet = true;
      if (showLoader) {
        _showLoader();
      }
      var res = await _dio.get(
        '${AppConfig.shared.baseUrl}/$api',
        data: data,
        queryParameters: params,
      );
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handleGetFileRequest(
    String api,
    String ref, {
    params,
    data,
    showLoader = false,
  }) async {
    try {
      showL = showLoader;
      isGet = true;
      if (showLoader) {
        _showLoader();
      }
      var res = await _dio.get(
        api,
        data: data,
        queryParameters: params,
        options: Options(responseType: ResponseType.bytes),
      );
      if (res.statusCode == 200) {
        print(res.data);
        Uint8List bytes = Uint8List.fromList(res.data);
        var blob = html.Blob([bytes], 'application/pdf');
        var blobUrl = html.Url.createObjectUrlFromBlob(blob);
        var anchorElement = html.AnchorElement(href: blobUrl);
        anchorElement.download = '$ref.pdf';
        anchorElement.click();
        html.Url.revokeObjectUrl(blobUrl);
      }
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handleGetFileRequest2(
    String api,
    String ref, {
    params,
    data,
    showLoader = false,
  }) async {
    try {
      showL = showLoader;
      isGet = true;
      if (showLoader) {
        _showLoader();
      }
      var res = await _dio.get(
        '${AppConfig.shared.baseUrl}/$api',
        data: data,
        queryParameters: params,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/pdf'},
        ),
      );
      if (res.statusCode == 200) {
        Uint8List bytes = Uint8List.fromList(res.data);

        // Vérifier si c'est vraiment un PDF
        String header = String.fromCharCodes(bytes.take(10));
        if (!header.startsWith('%PDF')) {
          print(
            'Erreur: Le fichier reçu n\'est pas un PDF. Contenu: ${String.fromCharCodes(bytes.take(100))}',
          );
          return Left(
            Failure(400, "Le fichier téléchargé n'est pas un PDF valide"),
          );
        }

        var blob = html.Blob([bytes], 'application/pdf');
        var blobUrl = html.Url.createObjectUrlFromBlob(blob);
        var anchorElement = html.AnchorElement(href: blobUrl);
        anchorElement.download = '$ref.pdf';
        anchorElement.click();
        html.Url.revokeObjectUrl(blobUrl);
      }
      return Right(Success(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          e.response?.data['message'] ?? e.response?.statusMessage ?? "",
        ),
      );
    }
  }
}

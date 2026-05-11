import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:toastification/toastification.dart';
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
    try {
      toastification.show(
        type: isError ? ToastificationType.error : ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text(message),
        autoCloseDuration: const Duration(seconds: 4),
        alignment: Alignment.topRight,
      );
    } catch (_) {}
  }

  Future<void> _handleResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (showL) {
      _hideLoader();
    }
    return handler.next(response);
  }

  Future<void> _handleRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!_isContainsPath(options.path)) {
      final String accessToken = (await locaHelper.getToken()) ?? "";
      options.headers['Authorization'] = 'Bearer $accessToken';
      final slug = getIt<LayoutCubit>().currentUser?.company?.slug;
      print(getIt<LayoutCubit>().currentUser?.toJson());
      if (slug != null) {
        options.headers['X-Tenant'] = slug;
      }
    }
    return handler.next(options);
  }

  Future<void> _handleError(DioException error, ErrorInterceptorHandler handler) async {
    if (showL || isGet) _hideLoader();

    final showError = error.requestOptions.extra['showError'] as bool? ?? true;
    if (kDebugMode && showError) {
      debugPrint("========== HTTP ERROR =========");
      debugPrint(error.toString());
    }
    if (error.response?.statusCode == 401) {
      await locaHelper.logOut();
    }
    if (showError) {
      _showMessage(_extractMessage(error), isError: true);
    }
    handler.next(error);
  }

  bool _isContainsPath(String path) {
    return path.contains('/auth/login') || path.contains('/auth/mfa/challenge') || path.contains('/auth/mfa/send');
  }

  String _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is! Map) return e.response?.statusMessage ?? '';

    final errors = data['errors'];
    if (errors is String && errors.isNotEmpty) return errors;
    if (errors is Map && errors.isNotEmpty) {
      final firstField = errors.values.first;
      if (firstField is List && firstField.isNotEmpty) {
        return firstField.first.toString();
      }
    }
    return data['message']?.toString() ?? e.response?.statusMessage ?? '';
  }

  Future<Either<Failure, Success>> handlePostRequest(
    String api,
    Map<String, dynamic> data, {
    showSuccessToast = true,
    showLoader = true,
    bool showErrorToast = true,
  }) async {
    try {
      showL = showLoader;
      if (showLoader) {
        _showLoader();
      }
      if (kDebugMode) {
        debugPrint("============ POST HTTP DEBUG ${AppConfig.shared.baseUrl}/$api");
      }

      final res = await _dio.post(
        '${AppConfig.shared.baseUrl}/$api',
        data: data,
        options: Options(extra: {'showError': showErrorToast}),
      );
      if (showSuccessToast) {
        _showMessage((res.data?['message'] ?? res.data.toString()).toString());
      }
      return Right(Success<Map<String, dynamic>?>(res.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.statusCode ?? 0,
          _extractMessage(e),
        ),
      );
    }
  }

  Future<Either<Failure, Success>> handlePutRequest(
    String api,
    Map<String, dynamic> data, {
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
          _extractMessage(e),
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
          _extractMessage(e),
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
          _extractMessage(e),
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

      if (kDebugMode) {
        debugPrint("============ GET HTTP DEBUG ${AppConfig.shared.baseUrl}/$api");
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
          _extractMessage(e),
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
        debugPrint(res.data);
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
          _extractMessage(e),
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
          debugPrint(
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
          _extractMessage(e),
        ),
      );
    }
  }
}

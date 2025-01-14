// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/core/datasources/auth_local_data_source.dart';
import 'api_constants.dart';
import 'api_exceptions.dart';

abstract class ApiClient {
  Future<dynamic> get(
    String path, {
    bool withParse = true,
    bool getRealApi = false,
    Map<String, dynamic>? params,
    Map<dynamic, dynamic>? filter,
  });
  Future<dynamic> post(
    String path, {
    required Map<String, dynamic> params,
    bool withToken = false,
    bool withParse = true,
  });
  Future<dynamic> patch(
    String path, {
    required Map<String, dynamic> params,
  });

  Future<dynamic> postPhoto({
    required File file,
  });

  Future<dynamic> download({
    required String fileUrl,
  });

  Future<dynamic> deleteWithBody(String path);
}

class ApiClientImpl extends ApiClient {
  final AuthLocalDataSource _authenticationLocalDataSource;
  final Dio clientDio;

  ApiClientImpl(
    this.clientDio,
    this._authenticationLocalDataSource,
  );
  @override
  Future<dynamic> download({required String fileUrl}) async {
    String sessionId = await _authenticationLocalDataSource.getToken() ?? "";

    final filePath = fileUrl;

    debugPrint("FilePath: $filePath");

    clientDio.interceptors
        .removeWhere((interceptor) => interceptor is DioCacheInterceptor);

    final header = {
      'Authorization': "Bearer $sessionId",
    };

    final Directory dir = await getApplicationDocumentsDirectory();

    debugPrint("Dir: ${dir.path}");
    try {
      final response = await clientDio.download(
        filePath,
        dir.path,
        options: Options(headers: header),
      );

      debugPrint("Response Status code ${response.statusCode}");
      debugPrint("Response data ${response.data}");
    } catch (e) {
      log("Error downloading file: $e");
    }
  }

  @override
  Future<dynamic> postPhoto({
    required File file,
  }) async {
    String? token = await _authenticationLocalDataSource.getToken();
    final userId = await _authenticationLocalDataSource.getUserId();

    var headers = {
      'Content-Type': 'multipart/form-data',
    };

    if (token != '') {
      headers.addAll({
        'Authorization': "Bearer $token",
      });
    }
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await clientDio.post(
      "${ApiConstants.baseApiUrl}${ApiConstants.uploadAvatar}$userId",
      data: formData,
      options: Options(headers: headers),
    );

    return _errorHandler(response);
  }

  @override
  Future<dynamic> get(
    String path, {
    bool withParse = true,
    bool getRealApi = false,
    Map<dynamic, dynamic>? filter,
    Map<String, dynamic>? params,
  }) async {
    String sessionId = await _authenticationLocalDataSource.getToken() ?? "";

    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        if (paramsString.isEmpty) {
          paramsString += '?$key=$value';
        } else {
          paramsString += '&$key=$value';
        }
      });
    }

    final pth = '${ApiConstants.baseApiUrl}$path$paramsString';

    final header = {
      'Authorization': "Bearer $sessionId",
    };

    debugPrint("Pth $pth");
    debugPrint("header $header");
    final response = await clientDio.get(
      pth, //?format=json
      options: Options(
        contentType: "application/json",
        headers: header,
        receiveDataWhenStatusError: true,
      ),
    );
    return _errorHandler(response,
        withParse: withParse, getRealApi: getRealApi);
  }

  @override
  Future patch(String path, {Map<dynamic, dynamic>? params}) async {
    String sessionId = await _authenticationLocalDataSource.getToken() ?? "";
    Map<String, String> header = {
      'Accept': 'application/json',
    };

    if (sessionId != '') {
      header.addAll({
        'Authorization': "Bearer $sessionId",
      });
    }

    final pth = getPath(path);
    debugPrint("Path $pth");
    final response = await clientDio.patch(
      pth,
      data: jsonEncode(params),
      options: Options(
        headers: header,
        receiveDataWhenStatusError: true,
      ),
    );
    if (kDebugMode) {
      debugPrint(response.data);
    }

    debugPrint("Response $path ${response.statusCode}");
    return _errorHandler(response);
  }

  @override
  Future<dynamic> deleteWithBody(String path) async {
    String sessionId = "";
    // (await _authenticationLocalDataSource.getSessionId()) ?? "";
    final header = {
      'Authorization': "Bearer $sessionId",
    };

    final response = await clientDio.delete(
      getPath(path),
      options: Options(headers: header),
    );

    debugPrint("API delete response code: ${response.statusCode} ");
    return _errorHandler(response);
  }

  @override
  Future post(String path,
      {required Map<String, dynamic> params,
      bool withToken = false,
      bool withParse = true}) async {
    String sessionId = await _authenticationLocalDataSource.getToken() ?? "";
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "*/*"
    };
    if (kDebugMode) {
      debugPrintThrottled("Request params: $params ");
    }
    if (sessionId != '') {
      header.addAll({
        'Authorization': "Bearer $sessionId",
      });
    }

    final uri = Uri.parse(ApiConstants.baseApiUrl + path);

    final body = jsonEncode(params);
    debugPrint("Post uri = $uri");
    debugPrint("Post header = $header");
    debugPrint("Post body = $body");

    final response = await clientDio.post(
      getPath(path),
      data: body,
      options: Options(
        receiveDataWhenStatusError: true,
        headers: header,
      ),
    );
    debugPrint("API post response: ${response.statusCode} ");
    debugPrint(response.data.toString());

    return _errorHandler(response, withParse: withParse);
  }

  _errorHandler(
    Response response, {
    bool withParse = true,
    bool getRealApi = false,
  }) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (getRealApi) {
        return response.realUri;
      }
      return withParse
          ? Map<String, dynamic>.from(response.data)
          : response.data;
    } else if (response.statusCode == 400 ||
        response.statusCode == 403 ||
        response.statusCode == 401 ||
        response.statusCode == 405 ||
        response.statusCode == 500 ||
        response.statusCode == 409) {
      String msg = "unknown_error";
      var resp = Map<String, dynamic>.from(response.data);
      debugPrint(resp.toString());

      if (resp.containsKey("error")) {
        msg = resp["error"];
      } else if (resp.containsKey("message")) {
        var rsp = resp["message"];
        if (rsp.runtimeType == String) msg = resp["message"];
        if (rsp.runtimeType == List) msg = rsp[0];
      } else {
        msg = utf8
            .decode(response.data)
            .replaceAll("[", '')
            .replaceAll("]", '')
            .replaceAll("}", '')
            .replaceAll("{", '')
            .replaceAll("\\", '');
      }

      print("Exception print message $msg");
      throw ExceptionWithMessage(msg);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  String getPath(String path, {Map<dynamic, dynamic>? params}) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    return '${ApiConstants.baseApiUrl}$path$paramsString';
  }
}

import 'package:dio/dio.dart';

// ignore: library_prefixes
import 'package:dio/dio.dart' as dioFormdata;
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';

Dio dio = Dio();

class DioService {
  Future<dynamic> getMethod(String url) async {
    var token = GetStorage().read(StorageVariables.token);
    if (token != null) {
      dio.options.headers['authorization'] = '$token';
    }
    return await dio
        .get(url,
            options: Options(
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                method: 'GET'))
        .then((response) {
      return response;
    });
  }

  Future<dynamic> postMethod(String url, Map<String, dynamic> map) async {
    dio.options.headers['content-Type'] = 'application/json';
    var token = GetStorage().read(StorageVariables.token);
    if (token != null) {
      dio.options.headers['authorization'] = '$token';
    }
    return await dio
        .post(url,
            data: dioFormdata.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'POST'))
        .then((value) {
      debugPrint(value.headers.toString());
      debugPrint(value.data.toString());
      debugPrint(value.statusCode.toString());
      return value;
    });
  }
}

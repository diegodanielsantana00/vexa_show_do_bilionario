import 'package:dio/dio.dart';

class MercadoPagoRequest {
  final _dio = Dio();
  final _url = "https://api.mercadopago.com/";

  Future<dynamic> post(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $acessToken";
      _dio.options.headers['content-Type'] = 'application/json';

      print(_url + path);

      final result = await _dio.post(_url + path, data: data);
      return result.data;
    } on DioError catch (e) {

      print(e.response!.data);
      throw e.message??"";
    }
  }

  Future<dynamic> put(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $acessToken";
      _dio.options.headers['content-Type'] = 'application/json';

      print(_url + path);

      final result = await _dio.put(_url + path, data: data);
      return result.data;
    } on DioError catch (e) {

      print(e.response!.data);
      throw e.message??"";
    }
  }

  Future<dynamic> get(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    _dio.options.headers["Authorization"] = "Bearer $acessToken";
    _dio.options.headers['content-Type'] = 'application/json';

    final result = await _dio.get(_url + path);
    return result.data;
  }

  Future<dynamic> delete(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    _dio.options.headers["Authorization"] = "Bearer $acessToken";
    _dio.options.headers['content-Type'] = 'application/json';

    final result = await _dio.delete(_url + path);
    return result.data;
  }
}

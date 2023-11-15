import 'package:dio/dio.dart';

import '../model/BuscaCepModel.dart';

class BuscaCepRepository {
  var _dio = Dio();

  BuscaCepRepository() {
    _dio = Dio();
    _dio.options.baseUrl = "https://viacep.com.br";
  }

  Future<BuscaCepModel> obeterCep(String cep) async {
    var result = await _dio.get("/ws/$cep/json/");
    return BuscaCepModel.fromJson(result.data);
  }
}

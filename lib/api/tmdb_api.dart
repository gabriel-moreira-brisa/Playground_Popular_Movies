
import 'package:dio/dio.dart';
import '../models/movie_model.dart';
import 'dio_client.dart'; // 1. Importe o nosso cliente central

class TmdbApi {
  // obtenha a instância configurada do DioClient
  final Dio _dio = DioClient.instance; 
  final String _apiKey = '477239b2bc14b2b0cba8976a65291c75';

  Future<List<Movie>> getPopularMovies() async {
    try {
      //selecionar a linguagem e a chave de acesso
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'pt-BR',
        },
      );
      final List results = response.data['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } on DioException catch (error) {
     
     // para eu ver os erros no meu console ^-^
      print("Erro ao buscar filmes: ${error.message}");
      return [];
    } catch (error) {
      print("Erro inesperado: $error");
      return [];
    }
  }
}
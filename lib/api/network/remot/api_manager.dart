import 'package:dio/dio.dart';
import 'package:untitled1/models/similar_response.dart';
import 'package:untitled1/models/top_rated_response.dart';
import '../../../constants/constants.dart';
import '../../../models/popular_response.dart';
import '../../../models/up_coming_response.dart';

class ApiManager {
  static Future<PopularResponse> getPopular() async {
    final dio = Dio();
    final response = await dio.get(
      "$baseUrl/$popularEndPoint",
      queryParameters: {'api_key': apikey},
    );
    PopularResponse popularResponse = PopularResponse.fromJson(response.data);
    return popularResponse;
  }

  static Future<UpComingResponse> getUpComingMovies() async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$upComingEndPoint',
      queryParameters: {'api_key': apikey},
    );
    UpComingResponse upComingMovies = UpComingResponse.fromJson(response.data);
    return upComingMovies;
  }

  static Future<TopRatedResponse> getTopRatedMovies() async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$topRatedEndPoint',
      queryParameters: {'api_key': apikey},
    );
    TopRatedResponse topRatedMovies = TopRatedResponse.fromJson(response.data);
    return topRatedMovies;
  }
  static Future<SimilarResponse> getSimilarMovies(String movieId) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/3/movie/$movieId/similar',
      queryParameters: {'api_key': apikey},
    );
    SimilarResponse similarResponse = SimilarResponse.fromJson(response.data);
    return similarResponse;
  }
}

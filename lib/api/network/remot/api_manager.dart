import 'package:dio/dio.dart';
import 'package:untitled1/models/categories_response.dart';
import '../../../constants/constants.dart';
import '../../../models/category_screen_response.dart';
import '../../../models/movie_details_response.dart';
import '../../../models/movie_response.dart';

class ApiManager {

  static Future<MovieResponse> getPopular() async {
    final dio = Dio();
    final response = await dio.get(
      "$baseUrl/$popularEndPoint",
      queryParameters: {'api_key': apikey},
    );
    MovieResponse popularResponse = MovieResponse.fromJson(response.data);
    return popularResponse;
  }

  static Future<MovieResponse> getUpComingMovies() async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$upComingEndPoint',
      queryParameters: {'api_key': apikey},
    );
    MovieResponse upComingMovies = MovieResponse.fromJson(response.data);
    return upComingMovies;
  }

  static Future<MovieResponse> getTopRatedMovies() async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$topRatedEndPoint',
      queryParameters: {'api_key': apikey},
    );
    MovieResponse topRatedMovies = MovieResponse.fromJson(response.data);
    return topRatedMovies;
  }

  static Future<MovieDetailsResponse> getMovieDetails(String movieId) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/3/movie/$movieId',
      queryParameters: {'api_key': apikey},
    );
    MovieDetailsResponse detailsResponse = MovieDetailsResponse.fromJson(response.data);
    return detailsResponse;
  }

  static Future<MovieResponse> getSimilarMovies(String movieId) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/3/movie/$movieId/similar',
      queryParameters: {'api_key': apikey},
    );
    MovieResponse similarResponse = MovieResponse.fromJson(response.data);
    return similarResponse;
  }

  static Future<MovieResponse> searchOnMovies(String movieName) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$searchEndPoint',
      queryParameters: {'api_key': apikey,"query": movieName},
    );
    MovieResponse searchResponse = MovieResponse.fromJson(response.data);
    return searchResponse;
  }

  static Future<CategoriesResponse> getCategoriesOfMovies() async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$categoriesEndPoint',
      queryParameters: {'api_key': apikey},
    );
    CategoriesResponse categoriesResponse = CategoriesResponse.fromJson(response.data);
    return categoriesResponse;
  }

  static Future<CategoryScreenResponse> getCategoryScreenMovies({required num genreId}) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/$categoryScreenEndPoint',
      queryParameters: {'api_key': apikey,'with_genres': genreId},
    );
    CategoryScreenResponse categoryScreenResponse = CategoryScreenResponse.fromJson(response.data);
    return categoryScreenResponse;
  }
}

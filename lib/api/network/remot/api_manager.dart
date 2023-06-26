import 'package:dio/dio.dart';
import 'package:untitled1/models/top_rated.dart';
import '../../../constants/constants.dart';
import '../../../models/latest_model.dart';
import '../../../models/popular_response.dart';

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

// static Future<Results> getPopular() async {
//  Dio dio = Dio();
//   var response = await dio.get("$BaseUrl/$popularEndPoint",queryParameters: {'api_key': apikey},);
//  Results popularResponse = Results.fromJson(response.data);
//   return popularResponse;
// }

  static Future<LatestModel> getLatestMovies() async {
    Dio dio = Dio();
    var response = await dio.get(
      "$baseUrl/$latestEndPoint",
      queryParameters: {'api_key': apikey},
    );
    LatestModel latestModel = LatestModel.fromJson(response.data);
    print("responseData: $latestModel");
    return latestModel;
  }

  static Future<List<TopRated>> getTopRatedMovies() async {
    Dio dio = Dio();
    try {
      var response = await dio.get(
        '$baseUrl/$topRatedEndPoint',
        queryParameters: {'api_key': apikey},
      );
      List<dynamic> responseData = response.data['results'];
      List<TopRated> topRatedMovies =
          responseData.map((json) => TopRated.fromJson(json)).toList();
      return topRatedMovies;
    } catch (error) {
      return [];
    }
  }
}

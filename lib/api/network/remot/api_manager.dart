import 'package:dio/dio.dart';
import 'package:untitled1/models/top_rated.dart';
import '../../../constants/constants.dart';
import '../../../models/latest_model.dart';

class ApiManager{
static Future<Results> getPopular() async {
 Dio dio = Dio();
  var response = await dio.get("$BaseUrl/$popularEndPoint?api_key=$apikey",queryParameters: {'api_key': apikey},);
 Results popularResponse = Results.fromJson(response.data);
  return popularResponse;
}


static Future<List<LatestModel>> getLatestMovies() async {
 Dio dio = Dio();
 var response = await dio.get("$BaseUrl/$latestEndPoint?api_key=$apikey");
 List<dynamic> responseData = response.data["results"];
 print("responseData: $responseData");
 List<LatestModel> latestMovies = responseData
     .map((json) => LatestModel.fromJson(json))
     .toList();
 return latestMovies;
}


static Future<List<TopRated>> getTopRatedMovies() async {
 Dio dio = Dio();
 try {
  var response = await dio.get(
   '$BaseUrl/$topRatedEndPoint',
   queryParameters: {'api_key': apikey},
  );
  List<dynamic> responseData = response.data['results'];
  List<TopRated> topRatedMovies = responseData
      .map((json) => TopRated.fromJson(json))
      .toList();
  return topRatedMovies;
 } catch (error) {
  return [];
 }
}
}
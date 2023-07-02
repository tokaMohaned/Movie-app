import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:untitled1/constant.dart';
import 'package:untitled1/network/end_point.dart';

import '../model/BrowsModel.dart';

class ApiManager
{
  // static Future<Brows_model> getBrows(int browsId) async
  // {
  //   // Uri URL=Uri.http(
  //   //   BASE_URL,
  //   //     endPointBrows,
  //   //   {"apiKey": ApiKey, "id": browsId}
  //   );
  //   Response response=await http.get(URL);
  //    var jsonResponse = jsonDecode(response.body);
  //   Brows_model browsModel = Brows_model.fromJson(jsonResponse);
  //    return browsModel;
//}

static Future<BrowsModel> getBrows() async
{
  Dio dio=Dio();
  final  response= await dio.get('$BASE_URL/$endPointBrows',
    queryParameters: {'api_key': ApiKey},);

  BrowsModel browsModel = BrowsModel.fromJson(response.data);
  return browsModel;

}
}//GET function



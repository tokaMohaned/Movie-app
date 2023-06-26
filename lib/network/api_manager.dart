import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:untitled1/constant.dart';
import 'package:untitled1/network/end_point.dart';

class ApiManager
{
  static void getSources() async
  {
    Uri URL=Uri.http(
      BASE_URL,
      endPoint,
      {"apiKey": ApiKey}
    );
    Response response=await http.get(URL);
    // var jsonResponse = jsonDecode(response.body);
    // SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonResponse);
    // return sourcesResponse;
  }

}//GET function



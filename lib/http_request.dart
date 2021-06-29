import 'dart:convert';

import 'data_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String postURL =
      'https://hpb.health.gov.lk/api/get-current-statistical';

  Future<Data> getData() async {
    Response res = await get(Uri.parse(postURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);

      Data data = Data.fromJson(body);
      return data;
    } else {
      throw "Unable to retrieve data.";
    }
  }
}

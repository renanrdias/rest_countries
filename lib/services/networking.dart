import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkingHelper {
  final String url;

  NetworkingHelper({required this.url});

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      // int responseStatusCode = int.tryParse(response.statusCode as String)!;
      // return responseStatusCode;
      print(response.statusCode);
    }
  }
}

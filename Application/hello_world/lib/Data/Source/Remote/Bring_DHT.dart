//API file

import 'package:http/http.dart' as http;


// ignore: camel_case_types
class BringDHT {
  final http.Client _client;

  static const baseUrl = 'http://10.0.2.2';
  BringDHT({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getAllList() async {
    final response = await _client.get(Uri.parse('$baseUrl/query.php'));
    return response;
  }

}
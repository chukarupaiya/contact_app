import 'dart:convert';
import './user_class.dart';
import 'package:http/http.dart';

class UserRepository {
  Future<List<user>> getUsers(endpoint) async {
    Response response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map((e) {
        // print(e);
        return user.fromJson(e);
      }).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<user> getUsersById(endpoint) async {
    Response response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return user.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

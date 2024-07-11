import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profile_remote_control/models/user.dart';
import 'package:profile_remote_control/models/users.dart';

class Services {
  //
  static List<Users> users = [];
  static const String url = 'https://jsonplaceholder.typicode.com/posts';
 
  static Future<Users> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        Users albums = parseUsers(response.body);
        return albums;
      } else {
        Users users = Users();
        users.users = [];
        return users; // we are returning empty album list
        // Handle these as you want...
      }
    } catch (e) {
      Users users = Users();
      users.users = [];
      return users;
    }
  }
 
  static Users parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Users> users =
        parsed.map<Users>((json) => User.fromJson(json)).toList();
    Users u = Users();
    u.users = users.cast<User>();
    return u;
  }
}
import "dart:convert";
import "package:http/http.dart" as http;
import "../../models/user.dart";
import "../../models/users.dart";

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<Users> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parseUsers(response.body);
        
      } else {
        return Users();
      }

    } catch (e) {
      print("Error ${e.toString()}");
      return Users();
    }
  
  
  
  }
    static Users parseUsers(String responseBody) {
      final parsed  = json.decode(responseBody).cast<Map<String,dynamic>>();
      List<User> users = parsed.map<User>((json) => User.fromJson(json)).toList();
      Users u = Users();
      u.users = users;
      return u;
    }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:profile_remote_control/user.dart';
import 'package:http/http.dart' as http;


class MyJSONPage extends StatefulWidget {
  const MyJSONPage({super.key});

  @override
  State<MyJSONPage> createState() => _MyJSONPageState();
}

class _MyJSONPageState extends State<MyJSONPage> {
  bool userTappedme = true;
  List<bool>strikeList = List.generate(100, (index) => false);


  Future<List<User>> usersFuture = getUsers();
  static Future<List<User>> getUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: FutureBuilder<List<User>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('😞 ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return buildUser(users, strikeList);
          } else {
            return const Text('No user data.');
          }
        },
      ),
    );
  }

  Widget buildUser(List<User> users, List<bool> strikeList) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];

          return Card(
            child: ListTile(
              
              leading: Text(user.id.toString()),
              title: Text( strikeList[index] ? user.ubody : user.utitle),
              onTap: () {
                strikeList[index] = !strikeList[index];
                setState(() {

                });
                
              },
              
            ),
          );
        },
      );
}

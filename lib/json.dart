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
  List<bool> strikeList = List.generate(100, (index) => false);

  Future<List<User>> usersFuture = getUsers();
  static Future<List<User>> getUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        ),
        Padding(
          padding: const EdgeInsets.only( left: 200, bottom: 50, ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlue,
                ),
                child: const Text('➕ Add Data To LocalStorage'),
                onPressed: () {},
              ),
              TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlue,
                ),
                child: const Text('💾 Read Data from LocalStorage'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUser(List<User> users, List<bool> strikeList) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];

          return ListTile(
            
            leading: Text(user.id.toString()),
            title: Text(strikeList[index] ? user.ubody : user.utitle),
            onTap: () {
              strikeList[index] = !strikeList[index];
              setState(() {});
            },
          );
        },
      );
}

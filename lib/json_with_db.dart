import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:profile_remote_control/local_db.dart';
import 'package:profile_remote_control/user.dart';
import 'package:http/http.dart' as http;

class MyJSONwithDB extends StatefulWidget {
  const MyJSONwithDB({super.key});

  @override
  State<MyJSONwithDB> createState() => _MyJSONwithDBState();
}

class _MyJSONwithDBState extends State<MyJSONwithDB> {
  List<bool> strikeList = List.generate(100, (index) => false);
  Future<String> usersString =  getUsers();

  // Future<List<User>> usersFuture = getUsers();
  Future<String> usersFuture = getUsers();
  // static Future<List<User>> getUsers() async {
  static Future<String> getUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));
    // print(response.body);// this prints Raw like JSON
    final body = json.decode(response.body);
    print(body);
    return body;
    // return body.map<User>(User.fromJson).toList();
    // return body.map<User>(User.fromJson).toString();
    // String myJSON = response.body;
    // return response.body;
  }

  // Future<String> read = readDataButton();

  //   Future<List<User>> readDataButton() async {
  //    String jsonfromDB = LocalDatabase().readAllData().toString();
  //   final body = json.decode(jsonfromDB);
  //   return  body.map<User>(User.fromJson).toList();
  //   // buildUser(listbody, strikeList);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: FutureBuilder<List<User>>(
        //     future: usersFuture,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Text('😞 ${snapshot.error}');
        //       } else if (snapshot.hasData) {
        //         final users = snapshot.data!;
        //         return buildUser(users, strikeList);
        //       } else {
        //         return const Text('No user data.');
        //       }
        //     },
        //   ),
        // ),
        //--------------------------------------------------------------------------

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: FutureBuilder<List<User>>(
        //     future: readDataButton(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Text('😞 ${snapshot.error}');
        //       } else if (snapshot.hasData) {
        //         final users = snapshot.data!;
        //                         return buildUser(users, strikeList);

        //         // return const Text('WE GOT user data!');
        //       } else {
        //         return const Text('No user data.');
        //       }
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<String>(
            future: usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('😞 ${snapshot.error}');
              } else if (snapshot.hasData) {
                // final users = snapshot.data!;
                return const Text('WE GOT user data!');
              } else {
                return const Text('No user data.');
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 200,
            bottom: 50,
          ),
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
                onPressed: () async {
                  print(usersString);
                  await LocalDatabase().addDataLocally(wholedata: usersString);
                  setState(() {});
                },
              ),
              TextButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('💾 Read Data from LocalStorage'),
                  onPressed: () async {
                    // String jsonfromDB =
                    //     LocalDatabase().readAllData().toString();
                    // final body = json.decode(jsonfromDB);
                    // var listbody = body.map<User>(User.fromJson).toList();
                    // buildUser(listbody, strikeList);
                    LocalDatabase().readAllData();
                    var listbody = jsonDecode(wholeDataList.toString()).map<User>(User.fromJson).toList();
                    buildUser(listbody, strikeList);
                    setState(() {});
                  }),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: wholeDataList.length,
                  //   controller: ScrollController(),
                  //   itemBuilder: (context, index) {
                  //     var decodedResponse = jsonDecode(wholeDataList[index]['DummyData']);
                  //     return Text(decodedResponse[0]['title']);
                  //   },
                  // )
            ],
          ),
        ),
      ],
    );
  }

  // void readDataButton() {
  //   String jsonfromDB = LocalDatabase().readAllData().toString();
  //   final body = json.decode(jsonfromDB);
  //   var listbody = body.map<User>(User.fromJson).toList();
  //   buildUser(listbody, strikeList);
  // }

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

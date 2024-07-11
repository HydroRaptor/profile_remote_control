import 'package:flutter/material.dart';
import 'package:profile_remote_control/others/AutoGenJSON/services.dart';
import 'models/users.dart';
import 'models/user.dart';

// import '../../models/user.dart';
// import '../../models/users.dart';

class UserListDemo extends StatefulWidget {
  const UserListDemo({super.key});

  final String title = "Filter List Demo";

  @override
  State<UserListDemo> createState() => _UserListDemoState();
}

class _UserListDemoState extends State<UserListDemo> {
  late Users users;
  late String title;

  @override
  void initState() {
    super.initState();
    title = "Loading users...";
    users = Users();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        title = widget.title;
      });
    });
  }

  Widget list() {
    return Expanded(
        child: ListView.builder(
      itemCount: users.users == null ? 0 : users.users?.length,
      itemBuilder: (BuildContext context, int index) {
        return row(index);
      },
    ));
  }

  Widget row(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              users.users![index].title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              users.users![index].body.toLowerCase(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ), // AppBar
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            list(),
          ],
        ), // Container
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
}

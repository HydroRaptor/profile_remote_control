import 'package:flutter/material.dart';
import 'package:profile_remote_control/MP/NewServices.dart';
import 'package:profile_remote_control/models/user.dart';
import 'package:profile_remote_control/models/users.dart';
import 'DB_Helper.dart';
import 'db_gridcell.dart';
 
class GridViewDemo extends StatefulWidget {
  const GridViewDemo({super.key});
 
  final String title = "Users";
 
  @override
  GridViewDemoState createState() => GridViewDemoState();
}

 
class GridViewDemoState extends State<GridViewDemo> {
  //
  int counter = 0;
  static User? users;
  DBHelper? dbHelper;
  bool usersLoaded = false;
  String? title; // Title for the AppBar where we will show the progress...
  double? percent;
  GlobalKey<ScaffoldState>? scaffoldKey;
 
  @override
  void initState() {
    super.initState();
    counter = 0;
    percent = 0.0;
    title = widget.title;
    usersLoaded = false;
    scaffoldKey = GlobalKey();
    dbHelper = DBHelper();
  }
 
  getUsers() {
    setState(() {
      counter = 0;
      usersLoaded = false;
    });
    Services.getUsers().then((allUsers) {
      users != allUsers;
      // Now we got all the albums from the Service...
      // We will insert each album one by one into the Database...
      // On Each load, we will truncate the table
      dbHelper!.truncateTable().then((val) {
        // Write a recursive function to insert all the albums
        insert(users?.users[0]);
      });
    });
  }
 
  insert(User user) {
    dbHelper!.save(user).then((val) {
      counter = counter + 1;
      // we are calculating the percent here on insert of each record
      percent = ((counter / users!.users.length) * 100) /
          100; // percent from 0 to 1...
      // terminate condition for this recursive function
      if (counter >= users!.users.length) {
        // when inserting is done
        setState(() {
          usersLoaded = true;
          percent = 0.0;
          title = '${widget.title} [$counter]';
        });
        return;
      }
      setState(() {
        title = 'Inserting...$counter';
      });
      User a = users!.users[counter];
      insert(a);
    });
  }
 
  gridview(AsyncSnapshot<Users> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: snapshot.data!.users!.map((user) {
          return GridTile(
            child: UserCell(user, update, delete),
          );
        }).toList(),
      ),
    );
  }
 
  // Update Function
  update(User user) {
    // We are updating the user title on each update
    dbHelper!.update(user).then((updtVal) {
      // showSnackBar('Updated ${user.id}');
      print('Updated ${user.id}');
      refresh();
    });
  }
 
  // Delete Function
  delete(int id) {
    dbHelper!.delete(id).then((delVal) {
      // showSnackBar('Deleted $id');
      print('Deleted $id');
      refresh();
    });
  }
 
  // Method to refresh the List after the DB Operations
  refresh() {
    dbHelper!.getUsers().then((allUsers) {
      setState(() {
        users != allUsers;
        counter = users!.users.length;
        title = '${widget.title} [$counter]'; // updating the title
      });
    });
  }
 
  // Show a Snackbar
  // showSnackBar(String message) {
  //   scaffoldKey!.currentState!.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
     
  //                                   //  SnackBar(
  //                                   //   content:
  //                                   //       Text(message),
  //                                   // );
                                 

  // }
 
  // We will create a GridView to show the Data...
  // Before that we will create the class from each Cell in the GridView
  // Add a Gridview to the UI
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title!),
        // Add action buttons in the AppBar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () {
              getUsers();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          usersLoaded
              ? Flexible(
                  child: FutureBuilder<Users>(
                    future: dbHelper!.getUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      if (snapshot.hasData) {
                        return gridview(snapshot);
                      }
                      // if still loading return an empty container
                      return Container();
                    },
                  ),
                )
              : LinearProgressIndicator(
                  value: percent,
                ),
        ],
      ),
    );
  }
}
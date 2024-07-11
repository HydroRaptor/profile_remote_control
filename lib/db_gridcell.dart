import 'package:flutter/material.dart';
import '../../models/user.dart';

class UserCell extends StatelessWidget {
//   // Pass the Update and Delete Function as Constructor Parameter
  const UserCell(this.user, this.updateFunction, this.deleteFunction, {super.key});

  @required
  final User user;
  final Function updateFunction;
  final Function deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: NetworkImage(user.url),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  user.title,
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '${user.id}', // show the Album id
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Add two more buttons for Update and Delete
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    // color: Colors.green,
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        backgroundColor: Colors.green
                      ),
                    ),
                    onPressed: () {
                      user.title = '${user.id} Updated';
                      updateFunction(user);
                    },
                  ),
                  TextButton(
                    // color: Colors.red,
                    child: const Text(
                      'DELETE',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        backgroundColor: Colors.red
                      ),
                    ),
                    onPressed: () {
                      deleteFunction(user.id);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
        );
  }
}

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_remote_control/drawer.dart';
// import 'package:profile_remote_control/RealRemoteCtrl.dart';
import 'package:profile_remote_control/remoteCtrl.dart';
// import 'package:profile_remote_control/remoteCtrl.dart';
// import 'package:flutter/widgets.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({super.key});

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    var cleaningHrs = 18;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            
            const Image(
              image: AssetImage('images/Grad_bg.png'),
              fit: BoxFit.fill,
            ),
                              

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////
            SafeArea(
              child: Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Home'),
                      ),
                       TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyDrawer(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Profile',
                        style: TextStyle(fontSize: 32),),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RemoteCtrlApp(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Remote'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 75),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('images/man-profile-account.jpg'),
                        // backgroundColor: Colors.brown.shade800,
                        // child: const Text('AH'),
                        radius: 75,
                      ),
                    ),
                  ),
                  GradientText(
                    'Lebron James',
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                    colors: const [
                      Colors.blue,
                      Color.fromARGB(255, 255, 94, 185),
                      Color.fromARGB(255, 255, 200, 141),
                    ],
                  ),
                  Text(
                    'Cleaning Hours: $cleaningHrs',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(
                    height: 30,
                  ),
                  // the tab bar with two items
                  // extendBodyBehindAppBar: true,
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      bottom: PreferredSize(
                        preferredSize:
                            Size.fromHeight(AppBar().preferredSize.height),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          child: TabBar(
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.lightBlue,
                            // unselectedLabelStyle: butt,///////////////////////////////

                            indicatorSize: TabBarIndicatorSize.tab,
                            // automaticIndicatorColorAdjustment: true,
                            indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(20), // Creates border
                              color: Colors.white,
                            ), //Change background color from here
                            tabs: const [
                              Tab(
                                // icon: Icon(Icons.directions_bike),
                                child: Text('Points'),
                              ),
                              Tab(
                                child: Text('Badges'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // create widgets for each tab bar here
                  Expanded(
                    child: TabBarView(
                      children: [
                        // first tab bar view widget
                        ListView(
                          children: const <Widget>[
                            ListTile(
                              leading: Icon(Icons.add),
                              title: Text(
                                'Successful Operation',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              subtitle: Text(
                                '+10 Points, Successfully operated the robots withouts any issues.',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.add),
                              title: Text(
                                'Cleaning Spree',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              subtitle: Text(
                                '+50 Points for using the robots daily!',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.add),
                              title: Text(
                                'Welcome Reward',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              subtitle: Text(
                                '+20 Points to kickstart your journey with us.',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),

                        // second tab bar view widget
                        ListView(
                          children: const <Widget>[
                            ListTile(
                              leading: Icon(Icons.map),
                              title: Text('Map'),
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_album),
                              title: Text('Album'),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('Phone'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const MyDrawer(),
          ],
        ),
      ),
    );
  }
}

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});

//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   int _selectedIndex = 0;
//   // static const TextStyle optionStyle =
//   //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   // static const List<Widget> _widgetOptions = <Widget>[
//   //   Text(
//   //     'Index 0: Home',
//   //     style: optionStyle,
//   //   ),
//   //   Text(
//   //     'Index 1: Business',
//   //     style: optionStyle,
//   //   ),
//   //   Text(
//   //     'Index 2: School',
//   //     style: optionStyle,
//   //   ),
//   // ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       // Add a ListView to the drawer. This ensures the user can scroll
//       // through the options in the drawer if there isn't enough vertical
//       // space to fit everything.
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text('Drawer Header'),
//           ),
//           ListTile(
//             title: const Text('Home'),
//             selected: _selectedIndex == 0,
//             onTap: () {
//               // Update the state of the app
//               _onItemTapped(0);
//               // Then close the drawer
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text('Business'),
//             selected: _selectedIndex == 1,
//             onTap: () {
//               // Update the state of the app
//               _onItemTapped(1);
//               // Then close the drawer
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text('School'),
//             selected: _selectedIndex == 2,
//             onTap: () {
//               // Update the state of the app
//               _onItemTapped(2);
//               // Then close the drawer
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

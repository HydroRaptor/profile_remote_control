import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:profile_remote_control/Grid.dart';
import 'package:profile_remote_control/main.dart';
// import 'package:flutter/widgets.dart';
import 'package:profile_remote_control/remoteCtrl.dart';
import 'package:profile_remote_control/table.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var cleaningHrs = 18;
  bool water = true;
  bool brush = false;
  bool buttonColor = true;
  bool buttonRemote = true;
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    ProfileContent(),
    // Text(
    //   'Index 1: Business',
    //   style: optionStyle,
    // ),
    TableExample(),
    // Text(
    //   'Index 2: School',
    //   style: optionStyle,
    // ),
    GridViewExampleApp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          forceMaterialTransparency: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RemoteCtrlApp()));
              },
              child: const Text(
                'Remote',
                style: TextStyle(color: Colors.white),
              ),
            )
            // IconButton(
            //   icon: const Icon(
            //     Icons.arrow_right,
            //     color: Colors.white,
            //   ),
            //   tooltip: 'Real Remote Control',
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const RemoteCtrlApp()));
            //   },
            // ),
          ],
        ),
        body: Stack(
          children: [
            const Image(
              image: AssetImage('images/Grad_bg.png'),
              fit: BoxFit.contain,
            ),
            SafeArea(
              child: _widgetOptions[_selectedIndex],
            ),
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff1f005c),
                      Color(0xff5b0060),
                      // Color(0xff870160),
                      Color(0xffac255e),
                      // Color(0xffca485c),
                      Color(0xffe16b5c),
                      // Color(0xfff39060),
                      Color(0xffffb56b),
                    ], // Gradient from https://learnui.design/tools/gradient-generator.html
                    // tileMode: TileMode.mirror,
                  ),
                ),
                child: Text(
                  'Navigate To..',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_chart),
                title: const Text('Table'),
                selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const TableExampleApp()),
                  // );
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_view),
                title: const Text('Grid'),
                selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                // selected: _selectedIndex == 3,
                onTap: () {
                  // Update the state of the app
                  // _onItemTapped(3);
                  // Then close the drawer
                  // Navigator.pop(context);
                  // Navigator.of(context).popUntil((route) => route.isFirst);
                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LogIn()),
                              );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cleaningHrs = 18;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const CircleAvatar(
              backgroundImage: AssetImage('images/man-profile-account.jpg'),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(
          height: 30,
        ),
        // the tab bar with two items
        // extendBodyBehindAppBar: true,
        const MyAppBar(),

        // create widgets for each tab bar here
        const Mytab(),

        ///////////////////////////////////////////////
      ],
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
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
                borderRadius: BorderRadius.circular(20), // Creates border
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
    );
  }
}

class Mytab extends StatelessWidget {
  const Mytab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
    );
  }
}

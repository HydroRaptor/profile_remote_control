import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
// import 'package:profile_remote_control/realremotectrl.dart';

const ballSize = 20.0;
const step = 10.0;

class RemoteCtrlApp extends StatefulWidget {
  const RemoteCtrlApp({super.key});

  @override
  State<RemoteCtrlApp> createState() => _RemoteCtrlAppState();
}

class _RemoteCtrlAppState extends State<RemoteCtrlApp> {
  bool water = true;
  bool brush = false;
  bool buttonColor = true;
  bool buttonRemote = true;
  double _sheetPosition = 0.18;
  double _sliderValue = 10.0;
  final double _dragSensitivity = 600;
  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back,
                color: Colors.white,
                size: 40,),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        forceMaterialTransparency: true,
        title: const Text(
          'Remote Control',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.arrow_right,
        //       color: Colors.white,
        //     ),
        //     tooltip: 'Real Remote Control',
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const RealRemoteCtrl()));
        //     },
        //   ),
        // ],
      ),
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: Image(
              image: AssetImage('images/Grad_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 128, left: 8, right: 8 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.water_drop_outlined,
                        color: Colors.white,
                      ),
                      const Text(
                        'WATER',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                      Switch(
                        value: water,
                        activeColor: Colors.lightBlue,
                        trackOutlineColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.orange.withOpacity(.48);
                            }
                            return Colors.white; // Use the default color.
                          },
                        ),
                        inactiveTrackColor: Colors.transparent,
                        thumbColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.white;
                        }),
                        onChanged: (bool value) {
                          setState(
                            () {
                              water = value;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 40,
                        // alignment: Alignment.center,
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      const Icon(Icons.brush_outlined, color: Colors.white),
                      const Text(
                        'BRUSH',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                      Switch(
                        value: brush,
                        activeColor: Colors.lightBlue,
                        inactiveTrackColor: Colors.transparent,
                        trackOutlineColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.orange.withOpacity(.48);
                            }
                            return Colors.white; // Use the default color.
                          },
                        ),
                        thumbColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          // if (states.contains(MaterialState.disabled)) {
                          //   return Colors.orange.withOpacity(.48);
                          // }
                          return Colors.white;
                        }),
                        onChanged: (bool value) {
                          setState(
                            () {
                              brush = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const JoystickExample(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: buttonColor ? Colors.lightBlue : Colors.red[600],
                        gradient: LinearGradient(
                          colors: buttonColor
                              ? <Color>[
                                  const Color(0xff03A9F4), // Colors.lightBlue,
                                  const Color(0xff1565C0),
                                ]
                              : <Color>[
                                  const Color.fromARGB(255, 255, 40, 72),
                                  const Color.fromARGB(
                                      255, 255, 24, 24), // Colors.lightBlue,
                                ],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          buttonColor = !buttonColor;
                          buttonRemote = !buttonRemote;
                        });
                      },
                      child: buttonRemote
                          ? const Text(
                              'START',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 34),
                            )
                          : const Text(
                              'STOP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 34),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: _sheetPosition,
            maxChildSize: .8,
            minChildSize: .18,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color(0xff03A9F4), // Colors.lightBlue,
                        Color(0xff1565C0),
                        // Colors.blue,
                        // Color(0xff1f005c),
                        // Color(0xff5b0060),
                        // Color(0xff870160),
                        // Color(0xffac255e),
                        // Color(0xffca485c),
                        // Color(0xffe16b5c),
                        // Color(0xfff39060),
                        // Color(0xffffb56b),
                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
                      // tileMode: TileMode.mirror,
                    ),
                  ),
                  // Colors.white,
                  child: Column(
                    children: <Widget>[
                      Grabber(
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          setState(() {
                            _sheetPosition -=
                                details.delta.dy / _dragSensitivity;
                            if (_sheetPosition < 0.18) {
                              _sheetPosition = 0.18;
                            }
                            if (_sheetPosition > .8) {
                              _sheetPosition = .8;
                            }
                          });
                        },
                        isOnDesktopAndWeb: _isOnDesktopAndWeb,
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          controller:
                              _isOnDesktopAndWeb ? null : scrollController,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  color: Colors.white,
                                  height: 2,
                                  width: 80,
                                ),
                              ),
                              const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              const Text(
                                'Settings',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Speed: ${_sliderValue.toString()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                value: _sliderValue,
                                min: 10,
                                max: 50,
                                divisions: 4,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                              Slider(
                                value: _sliderValue,
                                min: 10,
                                max: 50,
                                divisions: 4,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                              Slider(
                                value: _sliderValue,
                                min: 10,
                                max: 50,
                                divisions: 4,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                              Slider(
                                value: _sliderValue,
                                min: 10,
                                max: 50,
                                divisions: 4,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
    required this.isOnDesktopAndWeb,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: double.infinity,
        color: colorScheme.onSurface,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 32.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}

// RaisedButton(
//           shape: new RoundedRectangleBorder(
//               borderRadius: new BorderRadius.circular(18.0),
//               side: BorderSide(color: Colors.red)),
//           color: pressGeoON ? Colors.blue : Colors.red,
//           textColor: Colors.white,
//           child: cmbscritta ? Text("GeoOn") : Text("GeoOFF"),
//           //    style: TextStyle(fontSize: 14)
//             onPressed: () {
//               setState(() {
//                 pressGeoON = !pressGeoON;
//                 cmbscritta = !cmbscritta;
//               });
//             }
//         ),

class JoystickExample extends StatefulWidget {
  const JoystickExample({super.key});

  @override
  State<JoystickExample> createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickExample> {
  double _x = 100;
  double _y = 100;
  final JoystickMode _joystickMode = JoystickMode.all;

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Ball(_x, _y),
          Align(
            alignment: const Alignment(0, -0.4),
            child: Joystick(
              mode: _joystickMode,
              listener: (details) {
                setState(() {
                  _x = _x + step * details.x;
                  _y = _y + step * details.y;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class JoystickModeDropdown extends StatelessWidget {
  final JoystickMode mode;
  final ValueChanged<JoystickMode> onChanged;

  const JoystickModeDropdown(
      {super.key, required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: FittedBox(
          child: DropdownButton(
            value: mode,
            onChanged: (v) {
              onChanged(v as JoystickMode);
            },
            items: const [
              DropdownMenuItem(
                  value: JoystickMode.all, child: Text('All Directions')),
              DropdownMenuItem(
                  value: JoystickMode.horizontalAndVertical,
                  child: Text('Vertical And Horizontal')),
              DropdownMenuItem(
                  value: JoystickMode.horizontal, child: Text('Horizontal')),
              DropdownMenuItem(
                  value: JoystickMode.vertical, child: Text('Vertical')),
            ],
          ),
        ),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  final double x;
  final double y;

  const Ball(this.x, this.y, {super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
    );
  }
}

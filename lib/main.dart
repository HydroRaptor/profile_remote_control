import 'package:flutter/material.dart';
import 'package:profile_remote_control/myprofile_w_drawer.dart';
void main() {
  runApp(const LogIn());
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile-RemoteCtrl_App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const InputForm(),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // elevation: 0,

        forceMaterialTransparency: true,
        title: const Text(
          'Log in',
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            //
            child: Image(
              image: AssetImage('images/Grad_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child:
                ////////////////////////////////////////
                Column(
              children: [
                const Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Form(
                    key: _formKey,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // ...[
                            TextFormField(
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                filled: true, 
                                contentPadding: EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Email',
                                // labelText: 'Email',
                              ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              // onChanged: (value) {
                              //   formData.email = value;
                              // },
                            ),
                            const SizedBox(
                              height: 20,
                              width: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                // labelText: 'Password',
                                hintText: 'Password',
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                suffix: TextButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        _passwordVisible = !_passwordVisible;
                                      },
                                    );
                                  },
                                  child: Text(
                                    _passwordVisible ? "Hide" : "Show",
                                  ),
                                ),
                                // suffixIcon: IconButton(
                                //   icon: Icon(
                                //     _passwordVisible
                                //         ? Icons.visibility
                                //         : Icons.visibility_off,
                                //     color: Colors.lightBlue,
                                //   ),
                                //   onPressed: () {
                                //     setState(
                                //       () {
                                //         _passwordVisible = !_passwordVisible;
                                //       },
                                //     );
                                //   },
                                // ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              obscureText: !_passwordVisible,

                              // onChanged: (value) {
                              //   formData.password = value;
                              // },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(content: Text('Processing Data')),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyProfile(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Log in'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: TextButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Redirecting to Register Page'),
                                    ),
                                  );
                                },
                                child: const Text(
                                    'Didn\'t have an account? Sign up Here'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

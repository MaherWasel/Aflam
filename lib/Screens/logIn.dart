import 'package:aflam/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

final _firebase = FirebaseAuth.instance;

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
  );

  TextStyle labelStyle(double fontSize) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isUploading = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';

  void _submit() async {
    final isVaild = _formKey.currentState!.validate();
    if (!isVaild) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isUploading = true;
      });
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        setState(() {
          _isUploading = false;
        });
      } else {
        await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        setState(() {
          _isUploading = false;
        });
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const HomeScreen(),
            type: PageTransitionType.topToBottom,
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication Flaied")));
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final titleTheme = GoogleFonts.quicksand(
      textStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // I will to this tommorow...

                    // Container(
                    //   child: Image.asset("assets/images/user.png"),
                    // ),
                    Text(
                      _isLogin ? "Welcome Aflam!" : "SignUp!",
                      style: titleTheme,
                    ),
                    SizedBox(height: deviceSize.height * 0.1),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //username textField if not in login mode
                          if (!_isLogin)
                            SizedBox(
                              width: deviceSize.width / 1.3,
                              child: TextFormField(
                                style: labelStyle(14),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  labelText: "Username",
                                  labelStyle: labelStyle(14),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.trim().length < 4) {
                                    return "please enter a vaild username";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                onSaved: (newValue) {
                                  _enteredUsername = newValue!;
                                },
                              ),
                            ),
                          SizedBox(height: deviceSize.height * 0.02),
                          //email textField
                          SizedBox(
                            width: deviceSize.width / 1.3,
                            child: TextFormField(
                              style: labelStyle(14),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                labelText: "Email Address",
                                labelStyle: labelStyle(14),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains("@")) {
                                  return "Please Enter a vaild emil adderss.";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              onSaved: (newValue) {
                                _enteredEmail = newValue!;
                              },
                            ),
                          ),
                          SizedBox(height: deviceSize.height * 0.02),

                          //password textField
                          SizedBox(
                            width: deviceSize.width / 1.3,
                            child: TextFormField(
                              obscureText: true,
                              style: labelStyle(14),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                labelText: "Password",
                                labelStyle: labelStyle(14),

                                // labelStyle: TextStyle(),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return "Please enter a valid password";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                _enteredPassword = newValue!;
                              },
                            ),
                          ),
                          SizedBox(
                            width: deviceSize.width / 1.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isLogin
                                      ? "I don't have an account"
                                      : "I already have an account",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(
                                    _isLogin ? "SignUp!" : "Login",
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: deviceSize.height * 0.02),
                          _isUploading
                              ? const CircularProgressIndicator(
                                  color: Colors.deepPurple,
                                )
                              : SizedBox(
                                  height: deviceSize.height * 0.07,
                                  width: deviceSize.width * 0.45,
                                  child: ElevatedButton(
                                    style: buttonStyle,
                                    onPressed: _submit,
                                    child: Text(
                                      _isLogin ? "LogIn" : "SignUp",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

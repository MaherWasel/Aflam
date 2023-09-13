import 'package:aflam/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // I will to this tommorow...

            // Container(
            //   child: Image.asset("assets/images/user.png"),
            // ),
            Text(
              "Welcome Aflam!",
              style: titleTheme,
            ),
            SizedBox(height: deviceSize.height * 0.1),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: deviceSize.width / 1.3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "Email Address",
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Container(
                    width: deviceSize.width / 1.3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "Password",
                        // labelStyle: TextStyle(),
                      ),
                    ),
                  ),
                  Container(
                    width: deviceSize.width / 1.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "I don't have an account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "SignUp!",
                            style: TextStyle(
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
                  Container(
                    height: deviceSize.height * 0.07,
                    width: deviceSize.width * 0.45,
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {},
                      child: const Text(
                        "LogIn",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

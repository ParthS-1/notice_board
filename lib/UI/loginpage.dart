import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[200]);

    FlutterStatusbarcolor.setNavigationBarColor(Colors.blue[200]);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.school_outlined, color: Colors.amber[200]),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          "Login Dashboard",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[300]),
        ),
        actions: [
          Icon(FontAwesomeIcons.child, color: Colors.amber[200]),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Container(
              height: MediaQuery.of(context).size.height,
             decoration: BoxDecoration(
               gradient: LinearGradient(colors: [
                 Colors.yellow[400],
             Colors.pink[300]]))),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.6,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  borderOnForeground: true,
                  elevation: 10,
                  child: SingleChildScrollView(
                                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          },
                          child: Text("Sign in to your account"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthenticationService>().signUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          },
                          child: Text("Register as New user"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UI/draft_notice.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'UI/adminpage.dart';
import 'UI/loginpage.dart';
import 'UI/services/auth_service.dart';
import 'UI/studentpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notice Board',
          // theme: ThemeData.dark(),
          routes: {
            "/adminpage": (context) => HomePage(),
            "/studentpage": (context) => StudentPage(),
            "draft_notice": (context) => DraftNotice(),
          },
          // home: AuthenticationWrapper(),
          home: SplashSc()),
    );
  }
}

class SplashSc extends StatefulWidget {
  SplashSc({Key key}) : super(key: key);

  @override
  _SplashScState createState() => _SplashScState();
}

class _SplashScState extends State<SplashSc> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 8,
        navigateAfterSeconds: new AuthenticationWrapper(),
        title: new Text(
          "Welcome to PSIT's Digital Bulletin Board",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        image: new Image.network(
            'https://www.edufever.com/wp-content/uploads/2019/04/Pranveer-Singh-Institute-of-Technology-Kanpur.jpg'),
        backgroundColor: Colors.blue[100],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: MediaQuery.of(context).size.height/3.6,
        onClick: () => print("Virtual App"),
        loaderColor: Colors.red[200]
        );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    // if (firebaseUser == null) {
    //   return CircularProgressIndicator();
    // }
    if (firebaseUser != null) {
      if (firebaseUser.email != "admin@gmail.com") {
        return StudentPage();
      }
      return HomePage();
    }
    return SignInPage();
  }
}

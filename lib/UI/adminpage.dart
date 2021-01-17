import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("College Board");

  @override
  void initState() {
    super.initState();
    CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.red[200]);

    FlutterStatusbarcolor.setNavigationBarColor(Colors.red[300]);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.admin_panel_settings_sharp),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                return CircularProgressIndicator();
              })
        ],
      ),
      body: Container(
        color: Colors.amber,
        child: StaggeredGridView.count(
          crossAxisCount: 2, // no of columns you want
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: <Widget>[
            Material
            (elevation: 12, child: Image.network("https://bit.ly/2Kr7LAq")),
            Material(
              // color: Colors.white70,
              elevation: 18,
              shadowColor: Colors.blueGrey,
              borderRadius: BorderRadius.circular(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Draft New Notice",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Material(
                              shadowColor: Colors.black38,
                              elevation: 8,
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(12),
                              child: IconButton(
                                iconSize: 28,
                                icon: Icon(Icons.notification_important),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, "draft_notice");
                                },
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            myItems(Icons.bookmark_border, "Older Notices", Colors.blue),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 350),
            // extent(no of columns ,  height)
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
          ],
        ),
      ),
    );
  }
}

Material myItems(IconData icon, String label, Color color) {
  return Material(
    // color: Colors.white70,
    elevation: 18,
    shadowColor: Colors.blueGrey,
    borderRadius: BorderRadius.circular(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 50,
                child: Material(
                    shadowColor: Colors.black38,
                    elevation: 8,
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

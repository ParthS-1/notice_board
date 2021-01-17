import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  Query _ref;
  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child("College Board")
        .orderByChild("Heading");
    setState(() {
      now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    });
  }

  Widget _buildItem({Map notice}) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Material(
        color: Colors.limeAccent,
        elevation: 8,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: MediaQuery.of(context).size.height / 2.4,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage("https://bit.ly/2Kr7LAq"),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.5),
                  Icon(
                    Icons.announcement_sharp,
                    color: Colors.deepOrange,
                    size: 35,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(notice["Heading"],
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Text(notice["Announcement"],
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.brown[900],
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(notice["Date&Time"],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(notice["Authority's Name"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        Text(notice["Designation"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[500]);

    FlutterStatusbarcolor.setNavigationBarColor(Colors.blue[500]);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.school_rounded),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Student Dashboard"),
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
        color: Colors.yellow[100],
        child: StaggeredGridView.count(
          crossAxisCount: 2, // no of columns you want
          crossAxisSpacing: 16,
          mainAxisSpacing: 22,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          children: <Widget>[
            Material(
              // color: Colors.black,
              elevation: 4,
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.notification_important,
                      color: Colors.yellow[900],
                      size: MediaQuery.of(context).size.height / 28 ,
                    ),
                    Text(
                      "Latest Announcement Updates",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  color: Colors.deepPurple[100],
                  elevation: 12,
                  child: FirebaseAnimatedList(
                      query: _ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        if (snapshot.value == null) {
                          return CircularProgressIndicator();
                        }
                        Map notice = snapshot.value;
                        return _buildItem(notice: notice);
                      })),
            ),
            Material(
              // color: Colors.white70,
              elevation: 18,
              shadowColor: Colors.blueGrey,
              borderRadius: BorderRadius.circular(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Text(
                      "Contact Your Faculties",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
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
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            myItems(Icons.book, "Study Materials", Colors.blue),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 50),
            StaggeredTile.extent(2, 500),
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

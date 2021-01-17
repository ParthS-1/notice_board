import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class DraftNotice extends StatefulWidget {
  DraftNotice({Key key}) : super(key: key);

  @override
  _DraftNoticeState createState() => _DraftNoticeState();
}

class _DraftNoticeState extends State<DraftNotice> {
  // ignore: non_constant_identifier_names
  final DatabaseReference databaseReference_announcement =
      FirebaseDatabase.instance.reference().child("College Board");
  // ignore: non_constant_identifier_names
  final DatabaseReference database_draft =
      FirebaseDatabase.instance.reference().child("College Board draft");
  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
  var msgController1 = TextEditingController();
  var msgController2 = TextEditingController();
  var msgController3 = TextEditingController();
  var msgController4 = TextEditingController();
  clearText() {
    msgController1.clear();
    msgController2.clear();
    msgController3.clear();
    msgController4.clear();
  }

  var heading;
  // ignore: non_constant_identifier_names
  var announcement_text;
  // ignore: non_constant_identifier_names
  var auth_name;
  var designation;

  @override
  void initState() {
    super.initState();

    setState(() {
      now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    });
    print(now);
  }

  sendData() {
    databaseReference_announcement.push().set({
      "Heading": "$heading",
      "Announcement": "$announcement_text",
      "Authority's Name": "$auth_name",
      "Designation": "$designation",
      "Date&Time": "$now"
    });
  }

  sendDraft() {
    database_draft.push().set({
      "Heading": "$heading",
      "Announcement": "$announcement_text",
      "Authority's Name": "$auth_name",
      "Designation": "$designation",
      "Date&Time": "$now"
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[300]);

    FlutterStatusbarcolor.setNavigationBarColor(Colors.lightBlue[600]);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text("Draft Your Notice"),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {})
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Colors.deepOrange,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(34),
                          elevation: 12,
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.height / 8,
                            // maxRadius: 50,
                            child: Image.network("https://bit.ly/2Kr7LAq")
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 16,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 36,
                              ),
                              Container(
                                // elevation: 10,
                                child: Text(
                                  "Enter The Heading of your Notice",
                                  style: TextStyle(
                                      // color: Colors.,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: msgController1,
                                onChanged: (value) async {
                                  heading = value;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 36,
                              ),
                              Container(
                                // elevation: 10,
                                child: Text(
                                  "Enter the Announcement here",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: msgController2,
                                onChanged: (value) async {
                                  announcement_text = value;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 36,
                              ),
                              Container(
                                // elevation: 10,
                                child: Text(
                                  " Authority's Name ",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: msgController3,
                                onChanged: (value) async {
                                  auth_name = value;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 36,
                              ),
                              Container(
                                // elevation: 10,
                                child: Text(
                                  " Designation ",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: msgController4,
                                onChanged: (value) async {
                                  designation = value;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 36,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        sendDraft();
                                        clearText();
                                        showtoast("Saved As Drafts");
                                      },
                                      child: Icon(Icons.drafts)),
                                  ElevatedButton(
                                      onPressed: () {
                                        sendData();

                                        clearText();
                                        showtoast("Published New Notice");
                                      },
                                      child: Icon(Icons.send)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

showtoast(text) {
  Fluttertoast.showToast(
      msg: "$text ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

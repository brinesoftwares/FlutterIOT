import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter IoT'),
      ),
      body: Center(
          child: StreamBuilder(
              stream: databaseReference.child("light").onValue,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Light status : " +
                          snapshot.data.snapshot.value.toString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: snapshot.data.snapshot.value
                              ? Colors.green
                              : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Text(
                            'Turn ON',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            databaseReference.update({"light": true});
                          },
                        ),
                        RaisedButton(
                          color: snapshot.data.snapshot.value
                              ? Colors.grey[400]
                              : Colors.brown[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Text('Turn OFF',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            databaseReference.update({"light": false});
                          },
                        ),
                      ],
                    )
                  ],
                );
              })),
    );
  }
}

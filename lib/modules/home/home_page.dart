import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getTransactions() async {
    try {
      // REALTIME
      FirebaseFirestore.instance
          .collection("/transactions")
          .snapshots()
          .listen((event) {
        print("Received event: ${event.docs.map((e) => e.data())}");
      });

      // CREATE
      FirebaseFirestore.instance
          .collection("/transactions")
          .add({"type": "expense"});

      // UPDATE
      FirebaseFirestore.instance
          .collection("/transactions")
          .doc("i1IGSJiy3VcEHbi5Ce1f")
          .set({"value": 400}, SetOptions(merge: true));

      // DELETE
      FirebaseFirestore.instance
          .collection("/transactions")
          .doc("0LdxuzNjQRqdYiuICJtz")
          .delete();

      // READ
      final response =
          await FirebaseFirestore.instance.collection("/transactions").get();
      print(response.docs.map((e) => e.data()).toList());
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You have pushed the button this many times:"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getTransactions,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

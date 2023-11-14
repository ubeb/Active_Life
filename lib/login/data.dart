import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coba/tabs/tabs.dart';
import 'package:numberpicker/numberpicker.dart';

class DataPage extends StatefulWidget {
  final String name;
  final String email;
  final String uid;

  DataPage({
    Key? key,
    required this.name,
    required this.email,
    required this.uid,
  }) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final ageController = TextEditingController();
  String? gender;
  int height = 160;
  int weight = 60;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: 'Umur',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Pilih Gender: ${gender ?? ""}',
              style: TextStyle(fontSize: 15),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'Laki-laki',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Laki-laki'),
                Radio(
                  value: 'Perempuan',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Perempuan'),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Pilih Tinggi Badan: $height',
                      style: TextStyle(fontSize: 15),
                    ),
                    NumberPicker(
                      value: height,
                      minValue: 100,
                      maxValue: 220,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    Text(
                      'Pilih Berat Badan: $weight',
                      style: TextStyle(fontSize: 15),
                    ),
                    NumberPicker(
                      value: weight,
                      minValue: 30,
                      maxValue: 150,
                      onChanged: (value) {
                        setState(() {
                          weight = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                int age = int.tryParse(ageController.text) ?? 0;
                await usersCollection.doc().set({
                  'name': widget.name,
                  'email': widget.email,
                  'age': age,
                  'gender': gender,
                  'height': height,
                  'weight': weight,
                  'uid': widget.uid,
                });
                // You can navigate to the next screen or perform any other action
                // For now, I'm popping the screen to demonstrate returning to the previous screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tabs(
                      userData: {},
                    ),
                  ),
                );
              },
              child: Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }
}

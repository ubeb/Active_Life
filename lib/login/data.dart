import 'package:coba/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Date Picker for Age
            SizedBox(
              height: 64,
            ),
            Text(
              "Active Life",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 92,
            ),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value != null && value != selectedDate) {
                    setState(() {
                      selectedDate = value;
                      ageController.text =
                          "${value.day}/${value.month}/${value.year}";
                    });
                  }
                });
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Umur',
                    prefixIcon: Icon(Icons.calendar_today), // Calendar icon
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Dropdown for Gender
            DropdownButtonFormField<String>(
              value: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
              items: ['Laki-laki', 'Perempuan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Pilih Gender',
                prefixIcon: Icon(Icons.people), // People icon
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // TextFormField for Height
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Pilih Tinggi Badan',
                      prefixIcon: Icon(Icons.height), // Height icon
                    ),
                    onChanged: (value) {
                      setState(() {
                        height = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                Container(
                  color: Colors.blue,
                  width: 45,
                  height: 45,
                  child: Text(
                    'Cm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // TextFormField for Weight
            Row(
              children: [
                // TextFormField for Weight
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Pilih Berat Badan',
                      prefixIcon:
                          Icon(Icons.fitness_center), // Fitness center icon
                    ),
                    onChanged: (value) {
                      setState(() {
                        weight = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                Text('Kg'),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                int age = int.tryParse(ageController.text.split('/')[2]) ?? 0;
                await usersCollection.doc().set({
                  'name': widget.name,
                  'email': widget.email,
                  'age': age,
                  'gender': gender,
                  'height': height,
                  'weight': weight,
                  'uid': widget.uid,
                });
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

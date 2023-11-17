import 'package:coba/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        // Format the selected date as 'dd/MM/yyyy'
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        ageController.text = formattedDate;

        // Calculate age based on the selected birthdate
        int age = DateTime.now().year - pickedDate.year;
        ageController.text = age.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                  _selectDate(context);
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
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    width: 45,
                    height: 45,
                    child: Center(
                      // Center the text within the container
                      child: Text(
                        'Cm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    width: 45,
                    height: 45,
                    child: Center(
                      // Center the text within the container
                      child: Text(
                        'Kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await usersCollection.doc().set({
                    'name': widget.name,
                    'email': widget.email,
                    'age': ageController.text,
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
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }
}

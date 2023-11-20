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
      body: Container(
        color: Color.fromARGB(255, 28, 28, 30),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 64,
                  ),
                  Text(
                    "Active Life",
                    style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        208,
                        253,
                        62,
                      ),
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
                        style: TextStyle(
                            color: Colors.white), // Set text color to white
                        decoration: InputDecoration(
                          labelText: 'Umur',
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.white, // Set icon color to white
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          floatingLabelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Colors.white, // Set underline color to white
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Dropdown for Gender
                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color.fromARGB(255, 59, 59, 61),
                    ),
                    child: DropdownButtonFormField<String>(
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
                          child: Text(value,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Pilih Gender',
                        prefixIcon: Icon(Icons.people, color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Set text color
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Pilih Tinggi Badan',
                            prefixIcon: Icon(Icons.height,
                                color: Colors.white), // Set icon color to white
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white, // Set underline color to white
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              height = int.tryParse(value) ?? 0;
                            });
                          },
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 208, 253, 62),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 45,
                        height: 45,
                        child: Center(
                          child: Text(
                            'Cm',
                            style: TextStyle(
                              color: Color.fromARGB(255, 28, 28, 30),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // TextFormField for Weight
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Pilih Berat Badan',
                            prefixIcon: Icon(
                              Icons.fitness_center,
                              color: Colors.white, // Set icon color to white
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white, // Set underline color to white
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              weight = int.tryParse(value) ?? 0;
                            });
                          },
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 208, 253, 62),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 45,
                        height: 45,
                        child: Center(
                          child: Text(
                            'Kg',
                            style: TextStyle(
                              color: Color.fromARGB(255, 28, 28, 30),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        255,
                        208,
                        253,
                        62,
                      ),
                    ),
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
                    child: Text(
                      'Lanjutkan',
                      style: TextStyle(color: Color.fromARGB(255, 28, 28, 30)),
                    ),
                  ),
                  SizedBox(height: 177), // Add space after the button
                ],
              ),
            ),
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

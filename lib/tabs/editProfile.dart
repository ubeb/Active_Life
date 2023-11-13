import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final String name;
  final String age;
  final String weight;
  final String height;

  ProfileEditPage({
    Key? key,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
  }) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    ageController.text = widget.age;
    weightController.text = widget.weight;
    heightController.text = widget.height;
  }

  void saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Get the updated values
      final updatedName = nameController.text;
      final updatedAge = ageController.text;
      final updatedWeight = weightController.text;
      final updatedHeight = heightController.text;

      // Print or save the updated values (you can replace this with your logic)
      print('Updated Name: $updatedName');
      print('Updated Age: $updatedAge');
      print('Updated Weight: $updatedWeight');
      print('Updated Height: $updatedHeight');

      // Close the edit profile page
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight (Kg)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Height (Cm)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:coba/login/passwordField.dart';
import 'package:coba/models/register_model.dart';
import 'package:flutter/material.dart';

class lanjutan extends StatefulWidget {
  lanjutan(registerData registerData);

  @override
  _lanjutanState createState() => _lanjutanState();
}

class _lanjutanState extends State<lanjutan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "First Name",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        PasswordField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: 100,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_mysqldatabase/signinpage.dart';
import 'package:http/http.dart' as http;

class CreateAcount extends StatefulWidget {
  @override
  _CreateAcountState createState() => _CreateAcountState();
}

class _CreateAcountState extends State<CreateAcount> {
  GlobalKey<FormState> key1 = GlobalKey<FormState>();
  bool vx1 = true;
  bool vx2 = true;
  TextEditingController textform1 = TextEditingController();
  TextEditingController textform2 = TextEditingController();
  TextEditingController textform3 = TextEditingController();
  TextEditingController textform4 = TextEditingController();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  valedate(String val) {
    if (val.trim().isEmpty) {
      return 'empty';
    }
  }

  signup() async {
    var xx = key1.currentState;
    if (xx.validate()) {
      var data = {
        "username": textform1.text,
        "email": textform2.text,
        "password": textform3.text,
      };
      var url = "http://10.0.2.2/flutterloginmysql/signup.php";
      var respons = await http.post(url, body: data);
      var responsbody = jsonDecode(respons.body);

      if (responsbody['status'] == "success") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Homepage()));
      } else {
        print("field signup");
      }
    } else {
      print("error in create or not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Create Account",
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.orange[900],
                Colors.orange[800],
                Colors.orange[400]
              ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60))),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: key1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadiusDirectional.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white30,
                                    blurRadius: 0,
                                    offset: Offset(3, 7))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextFormField(
                                  validator: (String val) {
                                    if (val.trim().isEmpty) {
                                      return "not possible username empty"; //the trim function work delet the space or dont calculate the space is latter
                                    }
                                    if (val.trim().length < 2) {
                                      return "not possible username < 2 letter";
                                    }
                                    if (val.trim().length < 2) {
                                      return "not possible username > 20 letter";
                                    }
                                  },
                                  controller: textform1,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextFormField(
                                  validator: (String val) {
                                    if (val.trim().isEmpty) {
                                      return "not possible Email empty"; //the trim function work delet the space or dont calculate the space is latter
                                    }
                                    if (val.trim().length < 2) {
                                      return "not possible Email < 2 letter";
                                    }
                                    if (val.trim().length < 2) {
                                      return "not possible Email > 20 letter";
                                    }
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(val)) {
                                      return "email not true";
                                    }
                                  },
                                  controller: textform2,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextFormField(
                                  validator: (String val) {
                                    if (val.trim().isEmpty) {
                                      return "not possible Password empty";
                                    }
                                    if (val.trim().length < 2) {
                                      return "not possible Password < 4 letter";
                                    }
                                    if (val.trim().length < 2) {
                                      return "not possible Password > 20 letter";
                                    }
                                  },
                                  controller: textform3,
                                  obscureText: vx1,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: vx1
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            vx1 = !vx1;
                                          });
                                        }),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextFormField(
                                  validator: (String val) {
                                    if (val != textform3.text) {
                                      return "not match password";
                                    }
                                  },
                                  controller: textform4,
                                  obscureText: vx2,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: vx2
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            vx2 = !vx2;
                                          });
                                        }),
                                    hintText: "confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      // print(textform4.text);
                      signup();
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(50),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Homepage()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ))
      ],
    ));
  }
}

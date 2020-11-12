import 'package:assignment_bluestacks/home_screen/home.dart';
import 'package:assignment_bluestacks/model/user_details.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isButtonDisabled;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
            child: Image.asset(
              "images/game_tv_logo.png",
              color: Colors.black,
              height: 80,
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.person,
                    size: 30, color: Colors.black.withOpacity(0.5)),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    //key: _key1,

                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                    validator: _credValidator,
                    controller: usernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.lock,
                    size: 30, color: Colors.black.withOpacity(0.5)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      controller: passwordController,
                      validator: _credValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(25),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: RaisedButton(
                  color: Colors.black,
                  disabledColor: Colors.grey,
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text("Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  onPressed: _disableFeature()
                      ? null
                      : () {
                          if (_authenticated()[0]) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView(
                                        itemIndex: _authenticated()[1])));
                          } else {
                            _showAlertDialog(context);
                          }
                        }),
            ),
          )
        ],
      ),
    );
  }

  bool _disableFeature() {
    if (usernameController.text.length < 3 ||
        usernameController.text.length > 10 ||
        passwordController.text.length < 3 ||
        passwordController.text.length > 10) {
      print("button disabled");
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      print("button enabled");
      _isButtonDisabled = false;
    }
    return _isButtonDisabled;
  }

  String _credValidator(String value) {
    if (value.length < 3) {
      return "Text should be more than 3 characters.";
    } else if (value.length > 10) {
      return "Text should be less than 10 characters.";
    } else {
      return null;
    }
  }

  List<dynamic> _authenticated() {
    bool verification = false;
    int itemIndex = 0;
    List<dynamic> verificationList = new List<dynamic>();
    for (int i = 0; i < UserDetails.getUserDetails().length; i++) {
      if (usernameController.text == UserDetails.getUserDetails()[i].username &&
          passwordController.text == UserDetails.getUserDetails()[i].password) {
        verification = true;
        itemIndex = i;
      }
    }
    verificationList.add(verification);
    verificationList.add(itemIndex);
    return verificationList;
  }

  _showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
            child: Text("Alert!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      ),
      content: Center(
          child: Text("Invalid Credentials.", style: TextStyle(fontSize: 20))),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

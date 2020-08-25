import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleLogin extends StatefulWidget {
  SimpleLogin({Key key}) : super(key: key);

  @override
  _SimpleLoginState createState() => _SimpleLoginState();
}

class _SimpleLoginState extends State<SimpleLogin> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  User user = new User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KK"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top:20),
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      
                      hintText: 'Enter your name',
                      labelText: 'Name'),
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.name = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                      
                      hintText: 'Enter your phone number',
                      labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    new WhitelistingTextInputFormatter(new RegExp(r'^[0-9]*$')),
                    new LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (value) {
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.phoneNo = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Enter email",
                    hintText: "Enter email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.email = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: _passwordFieldKey,
                  obscureText: true,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    hintText: "Enter Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                    labelText: "Conform Password",
                    hintText: "Please re-enter password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value != _passwordFieldKey.currentState.value) {
                      return 'Password do not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print('Name: ${user.name}');
                      print('Email: ${user.email}');
                      print('Phone No: ${user.phoneNo}');
                      print('Password: ${user.password}');
                    }
                  },
                  child: Center(
                    child: Text("Login"),
                  ),
                )
            ],
          ),
        ),
      )
    );
  }

  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
}

class User {
  String name;
  String email;
  String phoneNo;
  String password;
}

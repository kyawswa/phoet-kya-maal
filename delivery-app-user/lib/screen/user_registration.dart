import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_bloc/constants.dart';
import 'package:flutter_app_bloc/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _userRegistrationformKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _selectDivision = "";
  String _selectTownship = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _userRegistrationformKey,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                  labelText: "UserName",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _phoneNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                  labelText: "Phone Number",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Your Phone Number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                  labelText: "Address",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Your Address';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DropDownFormField(
                titleText: 'Division',
                hintText: 'Select Division',
                value: _selectDivision,
                onSaved: (value) {
                  setState(() {
                    _selectDivision = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectDivision = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Select Division';
                  }
                  return null;
                },
                dataSource: [
                  {'value': 'Yangon', 'display': 'Yangon'},
                  {'value': 'Mandalay', 'display': 'Mandalay'}
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DropDownFormField(
                titleText: 'Township',
                hintText: 'Select Township',
                value: _selectTownship,
                onSaved: (value) {
                  setState(() {
                    _selectTownship = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectTownship = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Select Township';
                  }
                  return null;
                },
                dataSource: [
                  {'value': 'Yangon', 'display': 'Yangon'},
                  {'value': 'Mandalay', 'display': 'Mandalay'}
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonTheme(
                minWidth: 50,
                height: 50,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (_userRegistrationformKey.currentState.validate()) {
                      var user = User(
                          username: _userNameController.text,
                          phoneNumber: _phoneNoController.text,
                          address: _addressController.text,
                          division: _selectDivision,
                          township: _selectTownship);
                      // prefs.setString(Constants.USER_REGISTER_DATA,
                      //     user.toJson().toString());
                    }
                  },
                  child: Text('Register'),
                ),
              ),
            )
          ]),
        ),
      )),
    );
  }
}

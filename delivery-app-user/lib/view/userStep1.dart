import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'package:intl/intl.dart';

class UserStep1 extends StatefulWidget {
  @override
  _UserStep1State createState() => _UserStep1State();
}

class _UserStep1State extends State<UserStep1> {
  TextEditingController _controller = TextEditingController();
  bool isAdd = false;
  DateTime date = DateTime.now();
  var time = TimeOfDay.now();
  DateFormat dateFormat = DateFormat.jms();
  String name;
  String address;
  User user = User();
  String showData;
  String showAmount;

  final String amountA = "Package A (အမျိုးအစား A) - ၁၆၀၀၀ ကျပ်";
  final String amountB = "Package B (အမျိုးအစား B) - ၁၂၀၀၀ ကျပ်";
  final String amountC = "Package C (အမျိုးအစား C) - ၁၀၀၀၀ ကျပ်";
  final String a = '''၁။ ဆန်(ဧည့်မထ အသွယ်)                             (၆) ပြည်၊
၂။ နေကြာဆီ                                                (၅၀သား) ၁ဘူး၊
၃။ ကြက်သွန်နီ                                              ၁ပိသာ၊
၄။ ကြက်ဥ                                                    (၁၀)လုံး၊ 
၅။ ငါးသေတ္တာ                                               (၅)ဘူး၊ 
၆။ ငရုတ်သီး မှုန့်(သို့မဟုတ်)အလားတူပစ္စည်း     တစ်မျိုး၊
၇။ ကော်ဖီ + ကွေကာ                                     (၅)ထုပ်တွဲစီ၊ 
၈။ ခေါက်ဆွဲခြောက်                                       ၅ထုပ်။''';
  final String b =
      '''၁။ ဆန်(ဧည့်မထ အသွယ်)                              (၆)ပြည်၊ 
၂။ နေကြာဆီ                                                 (၅၀သား) ၁ဘူး၊ 
၃။ ကြက်သွန်နီ                                               ၁ပိသာ၊
၄။ ကြက်ဥ                                                     (၁၀)လုံး၊ 
၅။ ငရုတ်သီး မှုန့်(သို့မဟုတ်)အလားတူ ပစ္စည်း     တစ်မျိုး၊
၆။ ကော်ဖီ + ကွေကာ ''';
  final String c = '''၁။ ဆန်(ဧည့်မထ အသွယ်)                            (၆) ပြည်၊
၂။ နေကြာဆီ                                               (၅၀သား) ၁ဘူး၊
၃။ ကြက်သွန်                                               ၁ပိသာ၊ 
၄။ ငရုတ်သီး မှုန့်(သို့မဟုတ်)အလားတူပစ္စည်း    တစ်မျိုး။''';

  @override
  void initState() {
    super.initState();
    // sample();
    loadSharedPrefs();
  }

//     sample()async{
//       Map<String,dynamic> myMap = {
//    "name":"Ko Nay Ko Toe",
//    "address":"No(424),SagawarStreet",
//    "phone":"09401667577",
//    "division":"Magway",
//    "township":"Magway"
// };
//         final prefs = await SharedPreferences.getInstance();
//         prefs.setString("key",jsonEncode(myMap));
//     }

  loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var dataString = prefs.getString("key");
      if (dataString != null) {
        Map<String, dynamic> map = await jsonDecode(dataString);
        user = User.fromJson(map);
      }
    } catch (e) {
      print("Some Error");
    }
    
  }

  _dateTime() async {
    DateTime pickdate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 100));
    if (pickdate != null) {
      setState(() {
        date = pickdate;
      });
      TimeOfDay timeOfDay =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (timeOfDay != null) {
        setState(() {
          time = timeOfDay;
        });
      }
    }
  }

  selectBool(bool value, String values) {
    setState(() {
      isAdd = value;
      switch (values) {
        case "a":
          showData = a;
          showAmount = amountA;
          break;
        case "b":
          showData = b;
          showAmount = amountB;
          break;
        case "c":
          showData = c;
          showAmount = amountC;
          break;
        default:
          {
            showData = "";
            showAmount = "";
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Step1"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      user.name ?? "",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      user.address ?? "",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        // textAlign: TextAlign.center,
                        // maxLength: 11,
                        decoration: InputDecoration(
                            labelText: "Please Enter Your Phone",
                            border: OutlineInputBorder()),
                        controller: _controller,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white70,
                          border: Border.all(color: Colors.blueAccent)),
                      child: ListTile(
                        title: Text(
                            "${DateFormat.yMMMMd("en_US").format(date)}    ${time.format(context)}"),
                        trailing: IconButton(
                          icon: Icon(Icons.calendar_today,
                              color: Colors.blueAccent),
                          onPressed: _dateTime,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text("Add Order Items"),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              isAdd = !isAdd;
                            });
                          }),
                    ),
                  ),
                  Container(
                      child: Text(showAmount ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Pyidaungsu"))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(showData ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "Pyidaungsu")),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Verify Order",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
            ),
          ),
          isAdd ? Center(child: AddItem(selectBool: selectBool)) : Container(),
        ],
      ),
    );
  }
}

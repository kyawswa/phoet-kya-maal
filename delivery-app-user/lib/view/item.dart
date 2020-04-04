import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  final Function(bool, String) selectBool;
  const AddItem({Key key, this.selectBool}) : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String itemvalue = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Radio(
              groupValue: itemvalue,
              onChanged: (value) {
                setState(() {
                  itemvalue = value;
                });
              },
              value: "a",
            ),
            title: const Text("Package A"),
          ),
          ListTile(
            leading: Radio(
              groupValue: itemvalue,
              onChanged: (value) {
                setState(() {
                  itemvalue = value;
                });
              },
              value: "b",
            ),
            title: const Text("Package B"),
          ),
          ListTile(
            leading: Radio(
              groupValue: itemvalue,
              onChanged: (value) {
                setState(() {
                  itemvalue = value;
                });
              },
              value: "c",
            ),
            title: const Text("Package C"),
          ),
          RaisedButton(
            onPressed: () {
              widget.selectBool(false, itemvalue);
            },
            child: Text("Add Item", style: TextStyle(color: Colors.white)),
            color: Colors.blueAccent,
          )
        ],
      ),
    );
  }
}

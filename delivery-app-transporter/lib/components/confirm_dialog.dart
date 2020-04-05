import 'package:flutter/material.dart';

AlertDialog confirmDialog(BuildContext context, String content, Function onConfirmed){
  return AlertDialog(
    title: Text("Are You Sure ?"),
    content: Text(content),
    actions: <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          OutlineButton.icon(
              onPressed: () {
                onConfirmed();
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.check),
              label: Text("Yes")),
          OutlineButton.icon(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(Icons.cancel),
            label: Text("No"),
            textColor: Colors.redAccent,
          ),
        ],
      )
    ],
  );
}
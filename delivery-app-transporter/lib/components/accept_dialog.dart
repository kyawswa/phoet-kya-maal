import 'package:flutter/material.dart';
class AcceptDialog extends StatefulWidget {
  final Function(int estMinute) onAccept;

  const AcceptDialog({Key key,@required this.onAccept}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AcceptDialogState();
  }
}

class AcceptDialogState extends State<AcceptDialog> {
  final _textController = TextEditingController();
  bool _textValid = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text("Estimated Delivery Duration"),
      content: TextField(
        controller: _textController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: ("In Minutes"), errorText: _textValid ? null: "Duration Must Not Be Empty"),
      ),
      actions: <Widget>[
        ButtonBar(alignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
          OutlineButton.icon(onPressed: (){
            if(_textController.text.isNotEmpty) {
              widget.onAccept(int.parse(_textController.text));
              Navigator.pop(context);
            }else {
              setState(() {
                _textValid = false;
              });
              Future.delayed(Duration(seconds: 3), (){
                setState(() {
                  _textValid = true;
                });
              });
            }
          }, icon: Icon(Icons.directions_bike), label: Text("Accept")),
          OutlineButton.icon(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.cancel), label: Text("Cancel"), textColor: Colors.redAccent,),
        ],)
      ],
    );
  }
}

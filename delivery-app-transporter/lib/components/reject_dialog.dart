import 'package:flutter/material.dart';

class RejectDialog extends StatefulWidget {
  final Function(String reason) onReject;

  const RejectDialog({Key key, @required this.onReject}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RejectDialogState();
  }
}

class RejectDialogState extends State<RejectDialog> {
  final _textController = TextEditingController();
  bool _textValid = true;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Please State Your Reason."),
      content: TextField(
        controller: _textController,
        maxLines: 3,
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Your Reason", errorText: _textValid ? null: "Reason Must Not Be Empty"),
      ),
      actions: <Widget>[
        ButtonBar(alignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
          OutlineButton.icon(onPressed: (){
            if(_textController.text.isNotEmpty) {
              widget.onReject(_textController.text);
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
          }, icon: Icon(Icons.remove_circle_outline), label: Text("Reject"), textColor: Colors.redAccent,),
          OutlineButton.icon(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.cancel), label: Text("Cancel")),
        ],)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/order/order.dart';
import 'package:flutter_app_bloc/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptDialog extends StatefulWidget {
  final Order order;

  const AcceptDialog({Key key, @required this.order}) : super(key: key);

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
    Order order = widget.order;
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
              order.estimatedTime = int.parse(_textController.text);
              BlocProvider.of<OrderBloc>(context).add(OrderAccepted(order));
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

import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/accept_dialog.dart';
import 'package:flutter_app_bloc/bloc/order/order.dart';
import 'package:flutter_app_bloc/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({Key key, @required this.order}) : super(key: key);

  void confirmDialog(BuildContext context, String content ,Function onConfirmed){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text("Are You Sure ?"), content: Text(content), actions: <Widget>[
        ButtonBar(alignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
          OutlineButton.icon(onPressed: (){
            onConfirmed();
            Navigator.pop(context);
          }, icon: Icon(Icons.check), label: Text("Yes")),
          OutlineButton.icon(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.cancel), label: Text("No"), color: Colors.red,),
        ],)
      ],);
    });
  }

  void acceptDialog(BuildContext context, Order order){
    showDialog(context: context, builder: (context){
      return AcceptDialog(order: order,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderViewState>(
      builder: (BuildContext context, OrderViewState state) {
        bool isLoading = state is OrderViewLoading;
        Order stateOrder;
        if (state is OrderViewSuccess)
          stateOrder = state.order;
        else if (state is OrderViewFailure)
          stateOrder = state.order;
        else
          stateOrder = order;
        var orderList = <TableRow>[];
        if(stateOrder.orderItems != null)stateOrder.orderItems.forEach((element) {
          orderList.add(TableRow(children: <Widget>[
            TableCell(child: Text(element["category"]),),
            TableCell(child: Text(element["quantity"]),)
          ]));
        });
        Widget button;
        if(stateOrder.status == OrderState.PENDING.toString())button = ButtonBar(alignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          OutlineButton.icon(onPressed: (){}, icon: Icon(Icons.check), label: Text("Accept"),),
          OutlineButton.icon(onPressed: (){}, icon: Icon(Icons.cancel), label: Text("Reject"), color: Colors.red,)
        ],);
        else if(stateOrder.status == OrderState.ACCEPT.toString())button = OutlineButton.icon(onPressed: (){}, icon: Icon(Icons.directions_bike), label: Text("Finish Delivery"));
        return Scaffold(
          appBar: AppBar(
            title: Text("Order Detail"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  //To IMPLEMENT LOGOUT
                },
              )
            ],
          ),
          body: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: SingleChildScrollView(child: Column(children: <Widget>[
                      TextFormField(enabled: false, initialValue: stateOrder.user.name, decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Name"),),
                      SizedBox(height: 5,),
                      TextFormField(enabled: false, initialValue: stateOrder.user.address, decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Address"),),
                      SizedBox(height: 5,),

                      InkWell(onTap: ()=>launch("tel:${stateOrder.user.phoneNo}") ,child: RichText(text: TextSpan(children: <TextSpan>[
                        TextSpan(text: "Phone : "), TextSpan(text: stateOrder.user.phoneNo, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
                      ]))),
                      SizedBox(height: 5,),
                      TextFormField(enabled: false, initialValue: stateOrder.orderTimeStamp.toDate().toString(), decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Ordered At"),),
                      SizedBox(height: 5,),
                      Table(children: orderList,),
                      button
                    ],),
                  ),
          ),)
        );
      },
    );
  }
}

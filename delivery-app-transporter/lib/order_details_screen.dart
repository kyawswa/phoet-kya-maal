import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/accept_dialog.dart';
import 'package:flutter_app_bloc/bloc/order/order.dart';
import 'package:flutter_app_bloc/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({Key key, @required this.order}) : super(key: key);

  Future<void> confirmDialog(
      BuildContext context, String content, Function onConfirmed) async{
    await showDialog(
        context: context,
        builder: (context) {
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
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.check),
                      label: Text("Yes")),
                  OutlineButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel),
                    label: Text("No"),
                    textColor: Colors.redAccent,
                  ),
                ],
              )
            ],
          );
        });
  }

  void acceptDialog(BuildContext context, Order order) {
    showDialog(
        context: context,
        builder: (context)=>AcceptDialog(
            order: order,
          ));
  }

  void showFinishDelivery(BuildContext context){
    showDialog(context: context, builder: (context)=>AlertDialog(title: Text("Thank You"), content: Text("Thank You For Your Work. You have helped 2 people"),
    actions: <Widget>[OutlineButton(onPressed: ()=>Navigator.pop(context), child: Text("Close"),)],));
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
        print(stateOrder.status);
        print(stateOrder.estimatedTime != null ? stateOrder.estimatedTime : 0);
        var orderList = <TableRow>[];
        if (stateOrder.orderItems != null)
          orderList.add(TableRow(children: <Widget>[
            Center(
              child: Text("Category"),
            ),
            Center(
              child: Text("Quantity"),
            )
          ]));
          stateOrder.orderItems.forEach((element) {
            orderList.add(TableRow(children: <Widget>[
              Center(
                child: Text(element["category"]),
              ),
              Center(
                child: Text(element["quantity"].toString()),
              )
            ]));
          });
        Widget button = SizedBox();
        if (stateOrder.status == OrderState.PENDING.toString())
          button = ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlineButton.icon(
                onPressed: () {
                  acceptDialog(context, stateOrder);
                },
                icon: Icon(Icons.check),
                label: Text("Accept"),
              ),
              OutlineButton.icon(
                onPressed: (){
                  confirmDialog(context, "Are You Sure You Want To Reject?", ()=>BlocProvider.of<OrderBloc>(context).add(OrderRejected(stateOrder)));
                },
                icon: Icon(Icons.cancel),
                label: Text("Reject"),
                textColor: Colors.redAccent,
              )
            ],
          );
        else if (stateOrder.status == OrderState.ACCEPT.toString())
          button = Center(child: OutlineButton.icon(
              onPressed: () async{
                await confirmDialog(context, "Are You Sure Order Is Delivered To Customer?", ()=>BlocProvider.of<OrderBloc>(context).add(OrderDelivered(stateOrder)));
                showFinishDelivery(context);
              },
              icon: Icon(Icons.directions_bike),
              label: Text("Finish Delivery")));
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
            body: isLoading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              enabled: false,
                              initialValue: stateOrder.user.name,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Name"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              enabled: false,
                              initialValue: stateOrder.user.address,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Address"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () =>
                                    launch("tel:${stateOrder.user.phoneNo}"),
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(text: "Phone : ", style: TextStyle(color: Colors.black, fontSize: 20)),
                                  TextSpan(
                                      text: stateOrder.user.phoneNo,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          decoration: TextDecoration.underline))
                                ]))),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              enabled: false,
                              initialValue:
                                  stateOrder.orderTimeStamp.toDate().toString(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Ordered At"),
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Ordered Items", style: TextStyle(fontSize: 20),),
                            SizedBox(height: 5,),
                            Table(
                              border: TableBorder.all(color: Colors.grey),
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: orderList,
                            ),
                            button
                          ],
                        ),
                      ),
                    ),
            );
      },
    );
  }
}

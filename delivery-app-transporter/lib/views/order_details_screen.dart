import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/order_bloc/order.dart';
import 'package:flutter_app_bloc/components/accept_dialog.dart';
import 'package:flutter_app_bloc/components/confirm_dialog.dart';
import 'package:flutter_app_bloc/components/delivered_dialog.dart';
import 'package:flutter_app_bloc/components/labelled_text.dart';
import 'package:flutter_app_bloc/components/reject_dialog.dart';
import 'package:flutter_app_bloc/models/models.dart';
import 'package:flutter_app_bloc/views/account_info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const SCREEN_ROUTE_NAME = "ORDER DETAIL";
  final User userAccount;
  final _valueStyle = TextStyle(fontSize: 20);
  final double _spaceHeight = 10;

  OrderDetailsScreen({Key key, this.userAccount}) : super(key: key);

  Future<bool> showConfirmDialog(
      BuildContext context, String content, Function onConfirmed) async {
    return await showDialog(
        context: context,
        builder: (context) => confirmDialog(context, content, onConfirmed));
  }

  void showAcceptDialog(BuildContext myctx, Order order) {
    showDialog(
        context: myctx,
        builder: (context) => AcceptDialog(onAccept: (est) {
              order.estimatedTime = est;
              BlocProvider.of<OrderBloc>(myctx).add(OrderAccepted(order));
            }));
  }

  void showRejectDialog(BuildContext myctx, Order order) {
    showDialog(
        context: myctx,
        builder: (context) => RejectDialog(
              onReject: (reason) {
                order.rejectReason = reason;
                BlocProvider.of<OrderBloc>(myctx).add(OrderRejected(order));
              },
            ));
  }

  void showDeliveredDialog(BuildContext context) {
    showDialog(
        context: context, builder: (context) => deliveredDialog(context));
  }

  void showFinishDelivery(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Thank You"),
              content: Text(
                  "Items Are Successfully Delivered. Thank You For Your Work"),
              actions: <Widget>[
                OutlineButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                )
              ],
            ));
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
          stateOrder = Order.empty();
        print(stateOrder.status);
        print(stateOrder.estimatedTime != null ? stateOrder.estimatedTime : 0);
        print(stateOrder.rejectReason != null ? stateOrder.rejectReason : "");
        var orderList = <DataRow>[];
        if (stateOrder.orderItems != null)
          stateOrder.orderItems.forEach((element) {
            orderList.add(DataRow(cells: [
              DataCell(
                Text(element["category"]),
              ),
              DataCell(
                Text(element["quantity"].toString()),
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
                  showAcceptDialog(context, stateOrder);
                },
                icon: Icon(Icons.check),
                label: Text("Accept"),
              ),
              OutlineButton.icon(
                onPressed: () => showRejectDialog(context, stateOrder),
                icon: Icon(Icons.remove_circle_outline),
                label: Text("Reject"),
                textColor: Colors.redAccent,
              )
            ],
          );
        else if (stateOrder.status == OrderState.ACCEPT.toString())
          button = Center(
              child: OutlineButton.icon(
                  onPressed: () async {
                    if (await showConfirmDialog(
                        context,
                        "Are You Sure Order Is Delivered To Customer?",
                        () => BlocProvider.of<OrderBloc>(context)
                            .add(OrderDelivered(stateOrder))))
                      showFinishDelivery(context);
                  },
                  icon: Icon(Icons.directions_bike),
                  label: Text("Finish Delivery")));
        return Scaffold(
          appBar: AppBar(
            title: Text("Order Detail"),
            actions: <Widget>[
              PopupMenuButton(
                onSelected: (value) => value(),
                itemBuilder: (context) {
                  return <PopupMenuItem>[
                    PopupMenuItem(
                      value: () => Navigator.pushNamed(
                          context, AccountInfoScreen.SCREEN_ROUTE_NAME,
                          arguments: userAccount),
                      child: ListTile(
                        leading: Icon(Icons.verified_user),
                        title: Text("Account Info"),
                      ),
                    ),
                    PopupMenuItem(
                      value: () {},
                      child: ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Logout"),
                      ),
                    )
                  ];
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
                        LabelledText(
                          label: Text(
                            "Name : ",
                          ),
                          value: Text(stateOrder.user.name, style: _valueStyle,),
                        ),
                        SizedBox(
                          height: _spaceHeight,
                        ),
                        Divider(),
                        LabelledText(
                          label: Text(
                            "Address : ",
                          ),
                          value: Text(stateOrder.user.address, style: _valueStyle,),
                        ),
                        SizedBox(
                          height: _spaceHeight,
                        ),
                        Divider(),
                        LabelledText(
                          label: Text(
                            "Phone No : ",
                          ),
                          value: InkWell(onTap: () =>
                              launch("tel:${stateOrder.user.phoneNo}"),
                            child: Text(stateOrder.user.phoneNo,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                        SizedBox(
                          height: _spaceHeight,
                        ),
                        Divider(),
                        LabelledText(
                          label: Text(
                            "Ordered At : ",
                          ),
                          value: Text(stateOrder.orderTimeStamp.toDate().toString(), style: _valueStyle,),
                        ),
                        SizedBox(
                          height: _spaceHeight,
                        ),
                        Divider(),
                        Text(
                          "Ordered Items",
                          style: _valueStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text("Category")),
                              DataColumn(label: Text("Quantity"))
                            ],
                            rows: orderList,
                          ),
                        ),
                        button,
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

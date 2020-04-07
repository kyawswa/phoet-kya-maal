import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/order/order_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:flutter_app_bloc/model/order.dart';
import 'package:flutter_app_bloc/service/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firestore = RepositoryProvider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ပို့ကြမယ်'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              //TODO: navigate to User-Registeration screen
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => OrderBloc(
          firestore: firestore,
          userId: '', //TODO: put user id
        ),
        child: Column(
          children: <Widget>[
            OfflineAlertWidget(),
            Expanded(child: OrderList()),
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BottomAppBar(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonMinWidth: 400,
                buttonTextTheme: ButtonTextTheme.primary,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      //TODO: navigate to User-Step 1 screen or User-Registeration screen (if not registered)
                    },
                    child: Text('အော်ဒါ မှာမယ်'),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  const OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          if (state.orders.length < 1) {
            return Center(child: Text('မှာယူထားသော အော်ဒါမရှိပါ'));
          }
          return ListView.separated(
            itemCount: state.orders.length,
            itemBuilder: (context, index) => _buildOrderCard(
              context,
              orderNum: index + 1,
              order: state.orders[index],
            ),
            separatorBuilder: (_, __) => Divider(color: Colors.transparent),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    @required int orderNum,
    @required Order order,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                'ORDER: $orderNum',
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 18),
              ),
              trailing: _buildOrderState(order.status),
              isThreeLine: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(color: Colors.transparent, height: 10),
                  _buildDeliverDayWidget(order.deliverTime),
                  if (order.estimatedTime != null)
                    _buildDeliverTimeWidget(order.estimatedTime),
                  Divider(color: Colors.transparent, height: 10),
                ],
              ),
            ),
            Divider(height: 0),
            _buildItemTable(order.orderItems),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliverTimeWidget(Timestamp deliverTime) {
    return Row(
      children: <Widget>[
        Icon(Icons.access_time, color: Colors.black54, size: 18),
        VerticalDivider(width: 5),
        Text('ပစ္စည်းပို့မည့်အချိန်: '),
        Text(
          _getTimeString(DateTime.fromMillisecondsSinceEpoch(
            deliverTime.millisecondsSinceEpoch,
          )),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliverDayWidget(Timestamp deliverTime) {
    return Row(
      children: <Widget>[
        Icon(Icons.calendar_today, color: Colors.black54, size: 18),
        VerticalDivider(width: 5),
        Text('ပစ္စည်းပို့မည့်နေ့: '),
        Text(
          _getDateString(DateTime.fromMillisecondsSinceEpoch(
            deliverTime.millisecondsSinceEpoch,
          )),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildItemTable(List<Item> orderItems) {
    return IgnorePointer(
      ignoring: true, // prevent DataTable from firing pointer events
      child: DataTable(
        columns: [
          DataColumn(label: const Text('မှာထား‌သော ပစ္စည်းများ')),
          DataColumn(
            label: const Text('အရေအတွက်'),
            numeric: true,
          ),
        ],
        rows: [
          ...orderItems
              .map((item) => DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: <Widget>[
                            Icon(Icons.widgets),
                            VerticalDivider(color: Colors.transparent),
                            Text('${item.name}'),
                          ],
                        ),
                      ),
                      DataCell(Text('${item.total}')),
                    ],
                  ))
              .toList(),
          DataRow(
            cells: [
              DataCell(Text('ကျသင့်ငွေ :')),
              DataCell(Text('ကျပ် 15,000')), //TODO: put total price
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOrderState(String state) {
    Color textColor;
    switch (state) {
      case 'PENDING':
        textColor = Colors.amber;
        break;
      case 'CANCEL':
        textColor = Colors.grey;
        break;
      case 'REJECT':
        textColor = Colors.red;
        break;
      case 'DELIVERED':
        textColor = Colors.green;
        break;
      case 'ASSIGN':
        textColor = Colors.blue;
        break;
      case 'ACCEPT':
        textColor = Colors.teal;
        break;

      default:
    }

    return Chip(
      backgroundColor: textColor.withOpacity(0.2),
      label: Text(
        '$state',
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _getTimeString(DateTime dateTime) {
    var hour = dateTime.hour % 12;
    var minute = '${dateTime.minute ~/ 10}${dateTime.minute % 10}';
    var ampm = dateTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $ampm';
  }

  String _getDateString(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

class OfflineAlertWidget extends StatefulWidget {
  final Widget child;
  final double height;
  final Color backgroundColor;

  const OfflineAlertWidget({
    Key key,
    this.child =
        const Text('No Connection', style: TextStyle(color: Colors.white)),
    this.height = 25,
    this.backgroundColor = Colors.red,
  }) : super(key: key);

  @override
  _OfflineAlertWidgetState createState() => _OfflineAlertWidgetState();
}

class _OfflineAlertWidgetState extends State<OfflineAlertWidget> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((connectionState) {
      print(connectionState);
      setState(() {
        _isOffline = connectionState == ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isOffline
        ? Container(
            color: widget.backgroundColor,
            height: widget.height,
            child: Center(
              child: widget.child,
            ),
          )
        : Container();
  }
}

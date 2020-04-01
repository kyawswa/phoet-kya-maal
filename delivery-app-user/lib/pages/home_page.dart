import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/model/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Order> orders = List.generate(10, (index) => Order.mock(index));

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
        stream: Firestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.separated(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildOrderItem(snapshot.data.documents[index]),
            separatorBuilder: (_, __) => Divider(height: 0),
          );
        },
      ),
      // : Center(child: Text('မှာယူထားသော အော်ဒါမရှိပါ')),
      bottomNavigationBar: BottomAppBar(
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
    );
  }

  Widget _buildOrderItem(DocumentSnapshot order) {
    return ListTile(
      title: Text('Order ${order.documentID}'),
      trailing: _buildOrderState(order['state']),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today, color: Colors.black54, size: 18),
              VerticalDivider(width: 5),
              Text(
                _generateDateString(DateTime.fromMillisecondsSinceEpoch(
                  order['delivery_time'].millisecondsSinceEpoch,
                )),
              ),
            ],
          ),
          Divider(color: Colors.transparent, height: 2),
          Row(
            children: <Widget>[
              Icon(Icons.access_time, color: Colors.black54, size: 18),
              VerticalDivider(width: 5),
              Text(
                'EST: ' +
                    _generateTimeString(DateTime.fromMillisecondsSinceEpoch(
                      order['est'].millisecondsSinceEpoch,
                    )),
              ),
            ],
          ),
        ],
      ),
      // onTap: () {},
    );
  }

  Text _buildOrderState(String state) {
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

    return Text('$state', style: TextStyle(color: textColor));
  }

  String _generateTimeString(DateTime dateTime) =>
      '${dateTime.hour}:${dateTime.minute}';

  String _generateDateString(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

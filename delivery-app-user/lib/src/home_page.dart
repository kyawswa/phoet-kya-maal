import 'package:flutter/material.dart';

import 'model/order.dart';

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
      body: orders.isNotEmpty
          ? ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, index) => _buildOrderItem(orders[index]),
              separatorBuilder: (_, __) => Divider(height: 0),
            )
          : Center(child: Text('မှာယူထားသော အော်ဒါမရှိပါ')),
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

  Widget _buildOrderItem(Order order) {
    return ListTile(
      title: Text('Order ${order.id}'),
      trailing: Text('Accept', style: TextStyle(color: Colors.teal)),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today, color: Colors.black54, size: 18),
              VerticalDivider(width: 5),
              Text('${order.deliveryTime}'),
            ],
          ),
          Divider(color: Colors.transparent, height: 2),
          Row(
            children: <Widget>[
              Icon(Icons.access_time, color: Colors.black54, size: 18),
              VerticalDivider(width: 5),
              Text('EST: ${order.est}'),
            ],
          ),
        ],
      ),
      // onTap: () {},
    );
  }
}

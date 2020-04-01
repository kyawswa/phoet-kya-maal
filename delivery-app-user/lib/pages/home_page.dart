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
            itemBuilder: (context, index) => _buildOrderCard(
              context,
              index + 1,
              snapshot.data.documents[index],
            ),
            separatorBuilder: (_, __) => Divider(height: 0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

  Widget _buildOrderCard(
    BuildContext context,
    int orderNum,
    DocumentSnapshot order,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                ListTile(
                  title: Text(
                    'ORDER: $orderNum',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 18),
                  ),
                  trailing: _buildOrderState(order['state']),
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(color: Colors.transparent, height: 10),
                      Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today,
                              color: Colors.black54, size: 18),
                          VerticalDivider(width: 5),
                          Text(
                            'ပစ္စည်းပို့မည့်နေ့: ' +
                                _getDateString(
                                    DateTime.fromMillisecondsSinceEpoch(
                                  order['delivery_time'].millisecondsSinceEpoch,
                                )),
                          ),
                        ],
                      ),
                      Divider(color: Colors.transparent, height: 2),
                      Row(
                        children: <Widget>[
                          Icon(Icons.access_time,
                              color: Colors.black54, size: 18),
                          VerticalDivider(width: 5),
                          Text(
                            'ပစ္စည်းပို့မည့်အချိန်: ' +
                                _getTimeString(
                                    DateTime.fromMillisecondsSinceEpoch(
                                  order['est'].millisecondsSinceEpoch,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(indent: 100, endIndent: 100, height: 10),
                ListTile(
                  title: Text(
                    'မှာထား‌သော ပစ္စည်းများ',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  trailing: Text(
                    'အရေအတွက်',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ] +
              List.from(order['items'])
                  .map(
                    (item) => ListTile(
                      leading: Icon(Icons.widgets),
                      title: Text('${item['item_name']}'),
                      trailing: Text('${item['total']}'),
                    ),
                  )
                  .toList() +
              [
                // Divider(indent: 100, endIndent: 100, height: 10),
                // ListTile(
                //   title: Text(
                //     'ကျသင့်ငွေ : ',
                //     style: Theme.of(context).textTheme.subtitle.copyWith(
                //           color: Theme.of(context).textTheme.caption.color,
                //         ),
                //   ),
                //   trailing: Text('Kyat 10,000'),
                // ),
              ],
        ),
      ),
    );
  }

  Widget _buildOrderState(String state) {
    state = 'PENDING';
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

  String _getTimeString(DateTime dateTime) =>
      '${dateTime.hour}:${dateTime.minute}';

  String _getDateString(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

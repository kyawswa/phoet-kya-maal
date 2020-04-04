import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_app_bloc/bloc/dashboard/dashboard.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:flutter_app_bloc/service/order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (BuildContext context, DashboardState state) {
      List<Order> orders;
      if (state is DashboardLoaded) {
        orders = (state as DashboardLoaded).orders;
      }

      return Scaffold(
          appBar: AppBar(
            title: Text('ပို့ကြမယ်'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  //TODO: navigate to Cheers screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CheerUp()),
                  );
                },
              ),
            ],
          ),
          body: state is DashboardLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: orders?.length?? 0,
                  itemBuilder: (context, index) {
                    Order order = orders[index];

                    return Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(order.user.name),
                                  Text('(${order.user.phoneNo})'),
                                ],
                              ),
                              trailing: Text(
                                  '${DateTime.parse(order.orderTimeStamp
                                      .toDate().toString())}'
                              ),
                            ),
                            Divider(indent: 100, endIndent: 100, height: 10),
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[Text(order.user.address)],
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              buttonMinWidth: 200,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text("DELIVERED"),
                                  onPressed: () {
                                    BlocProvider.of<DashboardBloc>(context).add(
                                        UpdateStatusToDelivered(order.id,
                                            (state as DashboardLoaded).orders));

                                    // TODO:: to status
                                  },
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                    color: Colors.transparent,
                  ),
                ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    //TODO: navigate to User-Step 1 screen or User-Registeration screen (if not registered)
                  },
                  child: Text('Pending'),
                  color: Colors.white,
                ),
                RaisedButton(
                  onPressed: () {
                    //TODO: navigate to User-Step 1 screen or User-Registeration screen (if not registered)
                  },
                  child: Text('Accept'),
                  color: Colors.white,
                ),
              ],
            ),
          ));
    });
  }
}

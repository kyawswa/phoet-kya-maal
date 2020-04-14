import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/dashboard/dashboard.dart';
import 'package:flutter_app_bloc/bloc/filter/filter_bloc.dart';
import 'package:flutter_app_bloc/bloc/filter/filter_state.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilteredOrders extends StatelessWidget {
  final VisibilityFilter visibilityFilter;

  FilteredOrders(this.visibilityFilter);

  String dateFormat = 'dd/MM/yyyy – kk:mm';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        List<Order> orders;

        List<Order> _filteredOrders(
            List<Order> orders, VisibilityFilter filter) {
          return orders.where((order) {
            if (filter == VisibilityFilter.PENDING) {
              return order.status == OrderState.PENDING.toShortString();
            }
            return order.status == OrderState.ACCEPT.toShortString() ||
                order.status == OrderState.ASSIGN.toShortString();
          }).toList();
        }

        if (state is FilteredLoaded) {
          orders = _filteredOrders(state.filteredOrders, visibilityFilter);
        }

        return ListView.separated(
          itemCount: orders?.length ?? 0,
          itemBuilder: (context, index) {
            Order order = orders[index];
            return Card(
              color: order.status == OrderState.REJECT.toShortString()
                  ? Colors.red
                  : Colors.white,
              elevation: 4,
              child: InkWell(
                onTap: order.status == OrderState.REJECT.toShortString()
                    ? null
                    : () {
                        print("Go To Order Info");
                      },
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
                            '${DateFormat(dateFormat).format(order.orderTimeStamp.toDate())}'),
                      ),
                      Divider(indent: 100, endIndent: 100, height: 10),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text(order.user.address)],
                        ),
                      ),
                      visibilityFilter == VisibilityFilter.ASSIGN
                          ? Container()
                          : ButtonBar(
                              alignment: MainAxisAlignment.center,
                              buttonMinWidth: 200,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text("DELIVER"),
                                  onPressed: () {
                                    BlocProvider.of<DashboardBloc>(context).add(
                                        UpdateStatusToDelivered(
                                            order.id,
                                            (state as FilteredLoaded)
                                                .filteredOrders));

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
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(
            color: Colors.transparent,
          ),
        );
      },
    );
  }
}

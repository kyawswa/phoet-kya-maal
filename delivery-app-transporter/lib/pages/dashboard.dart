import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_app_bloc/bloc/dashboard/dashboard.dart';
import 'package:flutter_app_bloc/bloc/filter/fliter.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:flutter_app_bloc/service/order_service.dart';
import 'package:flutter_app_bloc/widgets/filtered_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var orderService = OrderService();

  @override
  Widget build(BuildContext context) {

      return BlocBuilder<FilterBloc, FilterState>(
          builder: (BuildContext context, FilterState state) {
            Color getColor(VisibilityFilter input) {
              if(BlocProvider.of<FilterBloc>(context).state is FilteredLoaded) {
                VisibilityFilter filter = (BlocProvider.of<FilterBloc>(context).state as FilteredLoaded).activeFilter;

                return filter == input ? Colors.lightBlue : Colors.white;
              }
              return Colors.white;
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
                    },
                  ),
                ],
              ),
              body: state is DashboardLoading
                  ? Center(child: CircularProgressIndicator())
                  : FilteredOrders(),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        BlocProvider.of<FilterBloc>(context).add(UpdateFilter(VisibilityFilter.ASSIGN));
                      },
                      child: Text('Assign'),
                      color: getColor(VisibilityFilter.ASSIGN)
                    ),
                    RaisedButton(
                      onPressed: () {
                        BlocProvider.of<FilterBloc>(context).add(UpdateFilter(VisibilityFilter.PENDING));
                      },
                      child: Text('Pending'),
                      color: getColor(VisibilityFilter.PENDING)
                    ),
                  ],
                ),
              ));
        }
      );
  }
}

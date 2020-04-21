import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/transporter/transporter.dart';
import 'package:flutter_app_bloc/model/transporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderAssignment extends StatefulWidget {
  @override
  _OrderAssignmentState createState() => _OrderAssignmentState();
}

class _OrderAssignmentState extends State<OrderAssignment> {
  var group = -1;
  String orderId = '3lKiPEoOR2sAHOpbX1X9'; // to get from previous
  var deliveryId = '';

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
                //TODO: navigate to Cheers screen
              },
            ),
          ],
        ),
        body: BlocBuilder<TransporterBloc, TransporterState>(
            builder: (context, state) {
              if(state is InitialTransporterState) {
                BlocProvider.of<TransporterBloc>(context).add(LoadTransporters('Yangon'));
              }

              if(state is TransporterLoaded) {
                var transporters = (state as TransporterLoaded).transporters;
                return ListView.separated(
                    itemCount: transporters?.length ?? 0,
                    itemBuilder: (context, index) {
                      Transporter transporter = transporters[index];

                      return Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                group = index;
                                deliveryId = transporter.id;
                              });
                            },
                            child: ListTile(
                              title: Text(transporter.name),
                              subtitle: Text(transporter.phoneNumber),
                              trailing: Radio(
                                value: index,
                                groupValue: group,
                                onChanged: (value) {
                                  setState(() {
                                    group = value;
                                    deliveryId = transporter.id;
                                  });
                                },
                              ),
                            ),
                          )
                      );
                    },
                  separatorBuilder: (_, __) => Divider(
                    color: Colors.transparent,
                  ),
                );
              }
              return Container();
            }
        ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: FloatingActionButton.extended(
          elevation: 4.0,
          label: const Text('Confirm'),
          onPressed: () {
            BlocProvider.of<TransporterBloc>(context).add(ConfirmTransporter(orderId, deliveryId));
          },
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 40.0,)
          ],
        ),
      ),

    );
  }
}

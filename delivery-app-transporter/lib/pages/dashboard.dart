import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var item = [1, 2, 3, 4, 5, 6];
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
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, position) {
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
                        Text('U Ba'),
                        Text('(092435888)'),
                      ],
                    ),
                    trailing: Text('4/02/2020 13:00'),
                  ),
                  Divider(indent: 100, endIndent: 100, height: 10),
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('No 22,'),
                        Text('Aung Chan Thar Qt'),
                        Text('Thanlyin'),
                      ],
                    ),
                  ),

                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonMinWidth: 200,
                    children: <Widget>[
                      RaisedButton(child: Text("DELIVERED"),
                        onPressed: () {},
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
        separatorBuilder: (_, __) => Divider(color: Colors.transparent,),
      ),

        bottomNavigationBar: BottomAppBar(
          child: Row(
//            alignment: MainAxisAlignment.center,
//            buttonMinWidth: 200,
//            buttonTextTheme: ButtonTextTheme.primary,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  //TODO: navigate to User-Step 1 screen or User-Registeration screen (if not registered)
                },
                child: Text('အော်ဒါ မှာမယ်'),
                color: Theme.of(context).primaryColor,
              ),
              RaisedButton(
                onPressed: () {
                  //TODO: navigate to User-Step 1 screen or User-Registeration screen (if not registered)
                },
                child: Text('အော်ဒါ မှာမယ်'),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        )
    );
  }
}

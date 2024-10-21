import 'package:flutter/material.dart';
import 'package:workshop5_flutter/util/dbuse.dart';

import 'models/scol_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Classes List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShList());
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  List<ScolList> scolList = [];
  dbuse helper = dbuse();
  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text(' Classes list'),
      ),
      body: ListView.builder(
          itemCount: (scolList != null) ? scolList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(scolList[index].nomClass),
                leading: CircleAvatar(
                  child: Text(scolList[index].codClass.toString()),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ));
          }),
    );
  }

  Future showData() async {
    await helper.openDb();
    scolList = await helper.getClasses();
    setState(() {
      scolList = scolList;
    });
  }
}

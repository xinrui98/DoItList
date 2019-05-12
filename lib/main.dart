import 'package:flutter/material.dart';
import 'package:to_do_list/ui/toDoList.dart';

void main(){
  runApp(
    new MaterialApp(
      title: "Do It List",
      home: new ToDoList(),
    )
  );
}


//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}

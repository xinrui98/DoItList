import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  var _taskEntered;
  var _taskDescriptionEntered;
  List<String> _listTasks = [];
  List<String> _listTasksDescription = [];

  @override
  Widget build(BuildContext context) {
    Future _goToNextScreen(BuildContext context) async {
      Map results = await Navigator.of(context)
          .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
        return new AddTask();
      }));
      if (results != null && results.containsKey('enter')) {
        print(results['enter'][0].toString());
        _taskEntered = results['enter'][0];
        _listTasks.add(_taskEntered);
        _taskDescriptionEntered = results['enter'][1];
        _listTasksDescription.add(_taskDescriptionEntered);
      } else {
        _taskEntered = null;
        _taskDescriptionEntered = null;
      }
    }

    return Scaffold(
        appBar: new AppBar(
          title: new Text("Do It List"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/main_screen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Column(
            children: <Widget>[
              //for testing purposes, listview Builder on the same page
//              new TextField(
//                controller: _inputTextController,
//                onSubmitted: (text) {
//                  _listTasks.add(text); // Append Text to the list
//                  _inputTextController.clear(); // Clear the Text area
//                  setState(() {}); // Redraw the Stateful Widget
//                },
//              ),
              new Expanded(
                child: new ListView.builder(
                    itemCount: _listTasks.length,
                    itemBuilder: (BuildContext ctxt, int index) =>
                        buildBody(ctxt, index)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(300.0, 0.0, 0.0, 30.0),
                child: new FloatingActionButton(
                  onPressed: () {
                    _goToNextScreen(context);
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border.all(width: 2,color: Colors.redAccent),
      ),
      child: ListTile(
        title: Text(
          _listTasks[index],
          style: TextStyle(
              fontSize: 28.9, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(_listTasksDescription[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )),
        leading: new FlatButton(
            onPressed: () => taskFinished(index),
            textColor: Colors.black,
            color: Colors.redAccent,
            child: Text("DO IT", style: TextStyle(fontSize: 20.0),)),
      ),
    );
  }

  void taskFinished(int index) {
    _listTasks.removeAt(index);
    _listTasksDescription.removeAt(index);
    setState(() {});
  }
}

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _listTasksTitleDescription = [];
    var _taskTitleController = new TextEditingController();
    var _taskDescriptionController = new TextEditingController();
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text('Add Task'),
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'assets/add_task.jpg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(hintText: 'Enter Task'),
                  controller: _taskTitleController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new TextField(
                  decoration:
                      new InputDecoration(hintText: 'Enter Task Description'),
                  controller: _taskDescriptionController =
                      new TextEditingController(),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                    onPressed: () {
                      _listTasksTitleDescription.add(_taskTitleController.text);
                      _listTasksTitleDescription
                          .add(_taskDescriptionController.text);
                      Navigator.pop(
                        context,
                        {'enter': _listTasksTitleDescription},
                      );
                    },
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    child: Text('Add Task')),
              )
            ],
          )
        ],
      ),
    );
  }
}

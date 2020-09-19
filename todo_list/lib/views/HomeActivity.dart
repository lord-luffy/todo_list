import 'package:flutter/material.dart';
import 'package:todo_list/models/Task.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  var _taskController = TextEditingController();
  var _editTaskController = TextEditingController();

  List<Task> _tasks = List<Task>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: Card(
              elevation: 8.0,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    MdiIcons.pencil
                  ),
                  onPressed: () {
                    _editTask(context, index);
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_tasks[index].name),
                    IconButton(
                      icon: Icon(
                        MdiIcons.delete, 
                        color: Colors.red,
                      ), 
                      onPressed: () {
                        setState(() {
                          _tasks.removeAt(index);
                        });
                      })                
                  ]
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
  
  _showFormDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton( 
            child: Text('Save'),
            color: Colors.blue,
            onPressed: () {
              setState(() {
                 if (_formKey.currentState.validate()) {
                    _tasks.add(new Task(_taskController.text));
                    _taskController.clear();
                    Navigator.pop(context);
                 }
              });
            },
          ),
          FlatButton( 
            child: Text('Cancel'),
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: Text('Task Form'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child:  TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Write a task',
                    labelText: 'Task'
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Task field it\'s required';
                    }
                    return null;
                  },
                ),
              )
            ],
          )
        ),
      );
    });
  }

  _editTask(BuildContext context, taskId) {
    setState(() {
      _editTaskController.text = _tasks[taskId].getName();
    });
    _editFormDialog(context, taskId);
  }

  _editFormDialog(BuildContext context, int index) {
    return showDialog(context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton( 
            child: Text('Update'),
            color: Colors.blue,
            onPressed: () {
              setState(() { 
                _tasks[index].setName(_editTaskController.text);
                _editTaskController.clear();
                Navigator.pop(context);
              });
            },
          ),
          FlatButton( 
            child: Text('Cancel'),
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: Text('Edit Task Form'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child:  TextFormField(
                  controller: _editTaskController,
                  decoration: InputDecoration(
                    hintText: 'Write a task',
                    labelText: 'Task'
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Task field it\'s required';
                    }
                    return null;
                  },
                ),
              )
            ],
          )
        ),
      );
    });
  }
}

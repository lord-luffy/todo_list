import 'dart:ffi';

class Task {
  String name;
  
  Task(this.name);

  setName(String name) {
    this.name = name;
  }

  String getName() {
    return this.name;
  }
}
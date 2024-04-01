import 'package:flutter/material.dart';
import 'package:todo/models/DataClass.dart';

class TaskProvider extends ChangeNotifier {
  late Task _task;

  Task get task => _task;

  TaskProvider(Task initialTask) {
    _task = initialTask;
  }

  void updateTask(Task newTask) {
    _task = newTask;
    notifyListeners(); // Notifie les auditeurs du changement d'état
  }

  //void updateIsOk(int isOkValue) {
  //  _task.isOk = isOkValue;
  //  notifyListeners();
  //}

  //void updateIsOk(bool bool) {}
}

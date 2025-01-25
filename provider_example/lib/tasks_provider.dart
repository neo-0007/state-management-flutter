import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_example/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  final List<Task> _archivedTasks = [];

  List<Task> get tasks => _tasks;
  List<Task> get archivedTasks => _archivedTasks;

  TasksProvider() {
    loadTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    final archieveStrings =
        _archivedTasks.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList('tasks', taskStrings);
    prefs.setStringList('archievedTasks', archieveStrings);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = prefs.getStringList('tasks') ?? [];
    final archieveStrings = prefs.getStringList('archievedTasks') ?? [];

    _tasks.addAll(taskStrings.map((taskString) {
      final taskMap = jsonDecode(taskString);
      return Task.fromJson(taskMap);
    }));

    _archivedTasks.addAll(archieveStrings.map((taskString) {
      final taskMap = jsonDecode(taskString);
      return Task.fromJson(taskMap);
    }));

    notifyListeners();
  }

  void addTask(String title) {
    final task = Task(
      id: DateTime.now().toString(),
      title: title,
      isCompleted: false,
    );
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = tasks.firstWhere((task) => id == task.id);
    task.isCompleted = !task.isCompleted;
    saveTasks();
    notifyListeners();
  }

  void restoreTask(String id) {
    final task = archivedTasks.firstWhere((task) => id == task.id);
    _archivedTasks.remove(task);
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }
}

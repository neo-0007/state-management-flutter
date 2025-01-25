import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/archieve_page.dart';
import 'tasks_provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Tasks',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.archive_rounded,
                color: Color(0xFF252525),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArchivePage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<TasksProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.tasks;

          // Show a message if there are no tasks
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet. Add a new task!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return Column(
            children: [
              if (tasks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: tasks.where((task) => task.isCompleted).length /
                        tasks.length,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            taskProvider.toggleTask(task.id);
                          },
                        ),
                        onLongPress: () {
                          taskProvider.removeTask(task.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask(BuildContext context) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Enter task title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = textController.text.trim();
                if (title.isNotEmpty) {
                  Provider.of<TasksProvider>(context, listen: false)
                      .addTask(title);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

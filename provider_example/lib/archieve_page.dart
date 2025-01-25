import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_provider.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Archive',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, taskProvider, child) {
          final archivedTasks = taskProvider.archivedTasks;
          if (archivedTasks.isEmpty) {
            return const Center(
              child: Text(
                'No archived tasks yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: archivedTasks.length,
            itemBuilder: (context, index) {
              final task = archivedTasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: ListTile(
                  title: Text(task.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.undo),
                    onPressed: () {
                      taskProvider.restoreTask(task.id); // Restore the task
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

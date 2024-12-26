import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;
  final TextEditingController _taskController = TextEditingController();

  TaskDetailScreen({required this.taskId});

  Future<void> _updateTask(BuildContext context) async {
    if (_taskController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
        'task': _taskController.text,
        'updatedAt': Timestamp.now(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modifier la tâche')),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('tasks').doc(taskId).get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          final task = snapshot.data!;
          _taskController.text = task['task'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(labelText: 'Tâche'),
                ),
                ElevatedButton(
                  onPressed: () => _updateTask(context),
                  child: Text('Mettre à jour'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

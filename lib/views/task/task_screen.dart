import 'package:final_project/models/workspace/workspace.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  final WorkspaceTaskModel task;
  const TaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Edit Task"),
        centerTitle: true,
      ),
    );
  }
}

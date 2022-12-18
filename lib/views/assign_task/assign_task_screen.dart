import 'package:final_project/models/workspace/workspace.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'components/assign_task_components.dart';

class AssignTaskScreen extends StatefulWidget {
  final WorkspaceTaskModel task;
  const AssignTaskScreen({super.key, required this.task});

  @override
  State<AssignTaskScreen> createState() => _AssignTaskScreenState();
}

class _AssignTaskScreenState extends State<AssignTaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TaskViewModel>(context, listen: false)
        .getTask(widget.task.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const AssignTaskHeader(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                ListAssignTeam(task: widget.task),
                SizedBox(height: 16.h),
                AddAssignTeamButton(task: widget.task),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

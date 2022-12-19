import 'package:final_project/constants/app_font.dart';
import 'package:final_project/models/workspace/workspace.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/views/task/components/status_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'components/task_components.dart';

class TaskScreen extends StatefulWidget {
  final WorkspaceTaskModel task;
  const TaskScreen({super.key, required this.task});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
        title: Text("Edit task", style: AppFont.headline6),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Consumer<TaskViewModel>(
          builder: (context, task, _) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                TeamContainer(task: widget.task),
                SizedBox(height: 8.h),
                const TitleContainer(),
                SizedBox(height: 8.h),
                const DescriptionContainer(),
                SizedBox(height: 8.h),
                const StatusContainer(),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

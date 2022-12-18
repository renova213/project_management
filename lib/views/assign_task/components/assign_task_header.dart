import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AssignTaskHeader extends StatelessWidget {
  const AssignTaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, task, _) {
        if (task.appstate == AppState.loaded) {
          return Row(
            children: [
              Text("Assign Member ", style: AppFont.headline6),
              Text("(${task.task.userTasks.length})", style: AppFont.subtitle),
            ],
          );
        }

        return SkeletonContainer(width: 150.w, height: 20.h, borderRadius: 0);
      },
    );
  }
}

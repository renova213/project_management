import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                const Icon(Icons.check, color: Colors.grey),
                SizedBox(width: 12.w),
                Text("Status          :", style: AppFont.bodyText1)
              ],
            ),
          ),
          Consumer<TaskViewModel>(
            builder: (context, task, _) => Consumer<WorkspaceViewModel>(
              builder: (context, workspace, _) => PopupMenuButton(
                onSelected: (value) async {
                  try {
                    if (value == 0) {
                      await task
                          .updateTask(
                              id: task.task.id,
                              title: task.task.title,
                              description: task.task.description,
                              progress: "open",
                              milestone: task.task.milestone,
                              workspaceId: task.task.workspaceId)
                          .then(
                            (_) => workspace
                                .getWorkspacesById(task.task.workspaceId),
                          );
                    }
                    if (value == 1) {
                      await task
                          .updateTask(
                              id: task.task.id,
                              title: task.task.title,
                              description: task.task.description,
                              progress: "pending",
                              milestone: task.task.milestone,
                              workspaceId: task.task.workspaceId)
                          .then(
                            (_) => workspace
                                .getWorkspacesById(task.task.workspaceId),
                          );
                    }
                    if (value == 2) {
                      await task
                          .updateTask(
                              id: task.task.id,
                              title: task.task.title,
                              description: task.task.description,
                              progress: "progress",
                              milestone: task.task.milestone,
                              workspaceId: task.task.workspaceId)
                          .then(
                            (_) => workspace
                                .getWorkspacesById(task.task.workspaceId),
                          );
                    }
                    if (value == 3) {
                      await task
                          .updateTask(
                              id: task.task.id,
                              title: task.task.title,
                              description: task.task.description,
                              progress: "done",
                              milestone: task.task.milestone,
                              workspaceId: task.task.workspaceId)
                          .then(
                            (_) => workspace
                                .getWorkspacesById(task.task.workspaceId),
                          );
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.blue, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text("Open", style: AppFont.bodyText2),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.yellow, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "Pending",
                          style: AppFont.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.red, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "In-Progress",
                          style: AppFont.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.green, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "Done",
                          style: AppFont.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  width: 120.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Consumer<TaskViewModel>(
                    builder: (context, task, _) => task.appstate ==
                            AppState.loaded
                        ? Text(
                            task.task.progress.toUpperCase(),
                            style:
                                AppFont.subtitle.copyWith(color: Colors.white),
                          )
                        : SkeletonContainer(
                            width: 70.w, height: 20.h, borderRadius: 0),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(flex: 3, child: SizedBox()),
        ],
      ),
    );
  }
}

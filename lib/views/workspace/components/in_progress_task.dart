import 'package:final_project/utils/app_state.dart';
import 'package:final_project/utils/navigator_helper.dart';
import 'package:final_project/views/task/task_screen.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:final_project/constants/app_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../view_models/task_view_model.dart';
import '../../../view_models/workspace_view_model.dart';

class InProgressTask extends StatelessWidget {
  const InProgressTask({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 48.w,
      decoration: BoxDecoration(
        color: Colors.red[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.w),
            Row(
              children: [
                Text("In Progress", style: AppFont.subtitle),
                SizedBox(width: 16.w),
                Container(
                  width: 40.w,
                  height: 30.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.6), width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Consumer<WorkspaceViewModel>(
                    builder: (context, workspace, _) => workspace.appState2 ==
                            AppState.loaded
                        ? Text(
                            workspace.progressTask.length.toString(),
                            style:
                                AppFont.bodyText1.copyWith(color: Colors.black),
                          )
                        : Text(
                            "0",
                            style:
                                AppFont.bodyText1.copyWith(color: Colors.black),
                          ),
                  ),
                )
              ],
            ),
            _listTask(),
            SizedBox(height: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _listTask() {
    return Consumer<WorkspaceViewModel>(
      builder: (context, workspace, _) {
        if (workspace.appState2 == AppState.loaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            shrinkWrap: true,
            itemCount: workspace.progressTask.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = workspace.progressTask[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.title, style: AppFont.subtitle),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Material(
                              color: Colors.transparent,
                              child: Consumer<WorkspaceViewModel>(
                                builder: (context, workspace, _) =>
                                    PopupMenuButton(
                                  onSelected: (value) async {
                                    if (value == 0) {
                                      Navigator.of(context).push(
                                        NavigatorHelper(
                                          child: TaskScreen(task: data),
                                        ),
                                      );
                                    }

                                    if (value == 1) {
                                      try {
                                        await workspace
                                            .deleteTask(
                                                taskId: data.id,
                                                workspaceId: workspace
                                                    .workspacesById
                                                    .workspaceDetail
                                                    .id)
                                            .then(
                                              (_) => Fluttertoast.showToast(
                                                  msg: "Task berhasil dihapus"),
                                            );
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.toString());
                                      }
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 0,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.edit, size: 18),
                                          SizedBox(width: 8.w),
                                          Text("Edit Task",
                                              style: AppFont.bodyText2),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.delete,
                                              size: 18, color: Colors.red),
                                          SizedBox(width: 8.w),
                                          Text(
                                            "Delete Task",
                                            style: AppFont.bodyText2
                                                .copyWith(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.black, width: 1.5),
                                    ),
                                    child: const Icon(Icons.more_horiz,
                                        color: Colors.black, size: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Due Date : ",
                              style: AppFont.bodyText2
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: data.milestone, style: AppFont.bodyText2),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 210.w,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Description : \n",
                                      style: AppFont.bodyText2.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: data.description,
                                        style: AppFont.bodyText2),
                                  ],
                                ),
                              )),
                          const Spacer(),
                          Consumer<TaskViewModel>(
                            builder: (context, task, _) => PopupMenuButton(
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
                                          (_) => workspace.getWorkspacesById(
                                              task.task.workspaceId),
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
                                          (_) => workspace.getWorkspacesById(
                                              task.task.workspaceId),
                                        );
                                  }
                                  if (value == 2) {
                                    await task
                                        .updateTask(
                                            id: task.task.id,
                                            title: task.task.title,
                                            description: task.task.description,
                                            progress: "done",
                                            milestone: task.task.milestone,
                                            workspaceId: task.task.workspaceId)
                                        .then(
                                          (_) => workspace.getWorkspacesById(
                                              task.task.workspaceId),
                                        );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.toString(),
                                      ),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag,
                                          color: Colors.blue, size: 18.sp),
                                      SizedBox(width: 8.w),
                                      Text("Open", style: AppFont.bodyText2),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag,
                                          color: Colors.yellow, size: 18.sp),
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
                                      Icon(Icons.flag,
                                          color: Colors.green, size: 18.sp),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Done",
                                        style: AppFont.bodyText2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              child: Icon(Icons.flag,
                                  color: Colors.red, size: 30.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => SkeletonContainer(
                width: double.maxFinite, height: 150.h, borderRadius: 10),
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemCount: 4);
      },
    );
  }
}

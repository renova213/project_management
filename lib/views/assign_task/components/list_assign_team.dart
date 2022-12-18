import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/workspace/workspace.dart';

class ListAssignTeam extends StatefulWidget {
  final WorkspaceTaskModel task;
  const ListAssignTeam({super.key, required this.task});

  @override
  State<ListAssignTeam> createState() => _ListAssignTeamState();
}

class _ListAssignTeamState extends State<ListAssignTeam> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, task, _) {
        if (task.appstate == AppState.loaded) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: task.task.userTasks.length,
            itemBuilder: (context, index) {
              final data = task.task.userTasks[index];
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNG04XVf3-VI_1_ultEv2SplAumxDdOTgKSQ&usqp=CAU"),
                        fit: BoxFit.cover),
                  ),
                ),
                title: Text(data.username, style: AppFont.subtitle),
                subtitle: Text(data.email, style: AppFont.bodyText2),
                trailing: IconButton(
                  onPressed: () async {
                    try {
                      await task
                          .deleteAssignMemberTask(
                              taskId: widget.task.id, userId: data.userId)
                          .then(
                            (_) => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Berhasil menghapus member",
                                ),
                              ),
                            ),
                          );
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
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemCount: 8,
          itemBuilder: (context, index) => const SkeletonContainer(
              width: double.maxFinite, height: 55, borderRadius: 10),
        );
      },
    );
  }
}

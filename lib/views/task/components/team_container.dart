import 'package:final_project/models/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'modal_assign_member.dart';

class TeamContainer extends StatefulWidget {
  final WorkspaceTaskModel task;
  const TeamContainer({super.key, required this.task});

  @override
  State<TeamContainer> createState() => _TeamContainerState();
}

class _TeamContainerState extends State<TeamContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Icon(Icons.people, color: Colors.grey),
                SizedBox(width: 12.w),
                Text("Team           : ", style: AppFont.bodyText1)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<TaskViewModel>(
              builder: (context, task, _) {
                if (task.appstate == AppState.loaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: task.task.userTasks.length <= 4
                        ? task.task.userTasks.length
                        : 4,
                    itemBuilder: (context, index) {
                      final data = task.task.userTasks[index];
                      if (index < 3) {
                        return Align(
                          widthFactor: 0.7,
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              width: 35.w,
                              height: 35.h,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blueAccent),
                              child: Consumer<TaskViewModel>(
                                builder: (context, task, _) => InkWell(
                                  onTap: () async {
                                    try {
                                      await task
                                          .deleteAssignMemberTask(
                                              taskId: widget.task.id,
                                              userId: data.userId)
                                          .then(
                                            (_) => ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Berhasil menghapus member",
                                                ),
                                              ),
                                            ),
                                          );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 15.w,
                                    height: 15.h,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(Icons.close,
                                        size: 10.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Align(
                        widthFactor: 0.7,
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            width: 35.w,
                            height: 35.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: task.task.userTasks.length > 6
                                        ? ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.dstATop)
                                        : null,
                                    image: const NetworkImage(
                                        'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blueAccent),
                            child: task.task.userTasks.length > 4
                                ? Text(
                                    "+${task.task.userTasks.length - 4}",
                                    style: AppFont.subtitle
                                        .copyWith(color: Colors.white),
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => const Align(
                    widthFactor: 0.7,
                    child: SkeletonContainer(
                        width: 45, height: 45, borderRadius: 100),
                  ),
                );
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _addAssignTeamModal(context);
                },
                child: Container(
                  width: 25.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  alignment: Alignment.center,
                  child: Icon(Icons.add, color: Colors.blue, size: 16.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addAssignTeamModal(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ModalAssignMember(task: widget.task),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}

import 'package:final_project/views/task/components/modal_edit_milestone.dart';
import 'package:flutter/material.dart';
import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MilestoneContainer extends StatefulWidget {
  const MilestoneContainer({super.key});

  @override
  State<MilestoneContainer> createState() => _MilestoneContainerState();
}

class _MilestoneContainerState extends State<MilestoneContainer> {
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
                const Icon(Icons.edit_calendar, color: Colors.grey),
                SizedBox(width: 12.w),
                Text("Due Date     :", style: AppFont.bodyText1)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<TaskViewModel>(
              builder: (context, task, _) {
                if (task.appstate == AppState.loaded) {
                  return Text(task.task.milestone,
                      style: AppFont.bodyText1,
                      overflow: TextOverflow.ellipsis);
                }
                return SkeletonContainer(
                    width: 150.w, height: 15, borderRadius: 0);
              },
            ),
          ),
          SizedBox(width: 4.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _modalEditTitle(context);
                },
                child: Container(
                  width: 25.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  alignment: Alignment.center,
                  child: Icon(Icons.edit, color: Colors.blue, size: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _modalEditTitle(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Consumer<TaskViewModel>(
            builder: (context, task, _) =>
                ModalEditMilestone(date: task.task.milestone),
          ),
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

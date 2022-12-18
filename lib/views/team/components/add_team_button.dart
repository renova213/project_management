import 'package:final_project/constants/app_font.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:final_project/views/team/components/modal_add_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddTeamButton extends StatelessWidget {
  const AddTeamButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 45.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Consumer<WorkspaceViewModel>(
          builder: (context, workspace, _) => ElevatedButton(
            onPressed: () {
              _addWorkspaceTeamModal(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent),
                  alignment: Alignment.center,
                  child: Icon(Icons.add, color: Colors.white, size: 14.sp),
                ),
                SizedBox(width: 16.w),
                Text(
                  "Add Team Member",
                  style: AppFont.subtitle.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addWorkspaceTeamModal(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return const Align(
          alignment: Alignment.bottomCenter,
          child: ModalAddTeam(),
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

import 'package:flutter/material.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/utils/navigator_helper.dart';
import 'package:final_project/views/widgets/botnavbar.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:final_project/views/workspace/components/workspace_components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_font.dart';
import '../../../models/workspace/workspace_model.dart';
import '../../../view_models/workspace_view_model.dart';

class HeaderWorkspace extends StatefulWidget {
  final WorkspaceModel workspace;
  const HeaderWorkspace({super.key, required this.workspace});

  @override
  State<HeaderWorkspace> createState() => _HeaderWorkspaceState();
}

class _HeaderWorkspaceState extends State<HeaderWorkspace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/project_background.jpg"),
            fit: BoxFit.fill),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 26.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Material(
                    color: Colors.transparent,
                    child: Consumer<WorkspaceViewModel>(
                      builder: (context, workspace, _) => PopupMenuButton(
                        onSelected: (value) async {
                          if (value == 0) {
                            _editWorkspaceModal(context);
                          }
                          if (value == 1) {
                            try {
                              await workspace
                                  .deleteWorkspace(widget.workspace.id)
                                  .then(
                                    (_) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Berhasil menghapus workspace"),
                                      ),
                                    ),
                                  )
                                  .then(
                                    (_) => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            NavigatorHelper(
                                                child: const BotNavBar()),
                                            (route) => false),
                                  );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
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
                                Text("Edit Workspace",
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
                                  "Delete Workspace",
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
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.more_horiz,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Consumer<WorkspaceViewModel>(
                    builder: (context, workspace, _) =>
                        workspace.appState2 == AppState.loaded
                            ? Text(
                                "R",
                                style: GoogleFonts.amita(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            : SkeletonContainer(
                                width: 15.w, height: 15.h, borderRadius: 0),
                  ),
                ),
                _listMemberTeam(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listMemberTeam() {
    return SizedBox(
      height: 45.h,
      child: Consumer<WorkspaceViewModel>(
        builder: (context, workspace, _) {
          if (workspace.appState2 == AppState.loaded) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: workspace.workspacesById.workspaceDetail
                          .userWorkspaceModel.length <=
                      8
                  ? workspace
                      .workspacesById.workspaceDetail.userWorkspaceModel.length
                  : 8,
              itemBuilder: (context, index) {
                if (index <= 8 &&
                    workspace.workspacesById.workspaceDetail.userWorkspaceModel
                            .length <=
                        8) {
                  return Align(
                    widthFactor: 0.5,
                    child: Container(
                      width: 45.w,
                      height: 45.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blueAccent),
                      ),
                    ),
                  );
                }
                return Align(
                  widthFactor: 0.5,
                  child: Container(
                    width: 45.w,
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.dstATop),
                              image: const NetworkImage(
                                  'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blueAccent),
                      child: Text(
                          "+${workspace.workspacesById.workspaceDetail.userWorkspaceModel.length - 4}",
                          style:
                              AppFont.subtitle.copyWith(color: Colors.white)),
                    ),
                  ),
                );
              },
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) => const Align(
              widthFactor: 0.5,
              child:
                  SkeletonContainer(width: 45, height: 45, borderRadius: 100),
            ),
          );
        },
      ),
    );
  }

  void _editWorkspaceModal(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ModalEditWorkspace(workspaceModel: widget.workspace),
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

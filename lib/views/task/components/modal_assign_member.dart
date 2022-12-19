import 'package:final_project/constants/app_font.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../models/workspace/workspace.dart';
import '../../../utils/app_state.dart';
import '../../widgets/widgets.dart';

class ModalAssignMember extends StatefulWidget {
  final WorkspaceTaskModel task;
  const ModalAssignMember({super.key, required this.task});

  @override
  State<ModalAssignMember> createState() => _ModalAssignMemberState();
}

class _ModalAssignMemberState extends State<ModalAssignMember> {
  @override
  Widget build(BuildContext context) {
    final focusField = FocusNode();

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          focusField.unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _closeButton(context),
              _listTeam(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
                child: Text("Choose Team Member", style: AppFont.subtitle)),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 25, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTeam() {
    return Consumer<WorkspaceViewModel>(
      builder: (context, workspace, _) {
        if (workspace.appState2 == AppState.loaded) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: workspace
                .workspacesById.workspaceDetail.userWorkspaceModel.length,
            itemBuilder: (context, index) {
              final data = workspace
                  .workspacesById.workspaceDetail.userWorkspaceModel[index];
              return Material(
                color: Colors.transparent,
                child: Consumer<TaskViewModel>(
                  builder: (context, task, _) => InkWell(
                    onTap: () async {
                      try {
                        await task
                            .assignMemberTask(
                                userId: data.userId, taskId: widget.task.id)
                            .then(
                              (_) => Fluttertoast.showToast(
                                  msg: "Berhasil assign member"),
                            )
                            .then(
                              (_) => Navigator.pop(context),
                            );
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    child: ListTile(
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
                    ),
                  ),
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

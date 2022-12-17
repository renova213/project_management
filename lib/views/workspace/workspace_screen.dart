import 'package:final_project/constants/app_font.dart';
import 'package:final_project/models/workspace/workspace_model.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:final_project/views/widgets/widgets.dart';
import 'package:final_project/views/workspace/components/header_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WorkspaceScreen extends StatefulWidget {
  final WorkspaceModel workspace;
  const WorkspaceScreen({super.key, required this.workspace});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WorkspaceViewModel>(context, listen: false)
            .getWorkspacesById(widget.workspace.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWorkspace(workspace: widget.workspace),
            _detailWorkspace(),
          ],
        ),
      ),
    );
  }

  Widget _detailWorkspace() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Consumer<WorkspaceViewModel>(
        builder: (context, workspace, _) {
          if (workspace.appState2 == AppState.loaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(workspace.workspacesById.workspaceDetail.name,
                    style: AppFont.headline6),
                SizedBox(height: 16.h),
                Text(
                  workspace.workspacesById.workspaceDetail.description,
                  style: AppFont.bodyText1.copyWith(color: Colors.grey[800]),
                ),
                SizedBox(height: 16.h),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const SkeletonContainer(width: 200, height: 20, borderRadius: 0),
              SizedBox(height: 16.h),
              const SkeletonContainer(width: 200, height: 15, borderRadius: 0),
              SizedBox(height: 16.h),
            ],
          );
        },
      ),
    );
  }
}

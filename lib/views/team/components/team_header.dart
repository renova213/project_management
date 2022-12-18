import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/workspace_view_model.dart';

class TeamHeader extends StatelessWidget {
  const TeamHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkspaceViewModel>(
      builder: (context, workspace, _) {
        if (workspace.appState2 == AppState.loaded) {
          return Row(
            children: [
              Text("Team Member ", style: AppFont.headline6),
              Text(
                  "(${workspace.workspacesById.workspaceDetail.userWorkspaceModel.length})",
                  style: AppFont.subtitle),
            ],
          );
        }

        return SkeletonContainer(width: 150.w, height: 20.h, borderRadius: 0);
      },
    );
  }
}

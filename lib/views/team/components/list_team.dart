import 'package:final_project/constants/app_font.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:final_project/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ListTeam extends StatelessWidget {
  const ListTeam({super.key});

  @override
  Widget build(BuildContext context) {
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
                    if (data.role == "owner") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Tidak dapat menghapus owner",
                          ),
                        ),
                      );
                    } else {
                      try {
                        await workspace
                            .removeorkspaceTeam(
                                email: data.email,
                                workspaceId:
                                    workspace.workspacesById.workspaceDetail.id)
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

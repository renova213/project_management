import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkspaceScreen extends StatefulWidget {
  final String workspaceId;
  const WorkspaceScreen({super.key, required this.workspaceId});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WorkspaceViewModel>(context, listen: false)
            .getWorkspacesById(widget.workspaceId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

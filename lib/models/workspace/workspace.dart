import 'package:equatable/equatable.dart';

class Workspace extends Equatable {
  final WorkspaceDetailModel workspaceDetail;
  final List<WorkspaceTaskModel> workspaceTask;

  const Workspace({required this.workspaceDetail, required this.workspaceTask});

  factory Workspace.fromJson(Map<String, dynamic> json) => Workspace(
      workspaceDetail: WorkspaceDetailModel.fromJson(json['workspace']),
      workspaceTask: (json['tasks'] as List)
          .map((e) => WorkspaceTaskModel.fromJson(e))
          .toList());

  @override
  List<Object> get props => [workspaceDetail, workspaceTask];
}

class WorkspaceDetailModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final int ownerId;
  final String visibility;
  final List<UserWorkspaceDetailModel> userWorkspaceModel;

  const WorkspaceDetailModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.ownerId,
      required this.visibility,
      required this.userWorkspaceModel});

  factory WorkspaceDetailModel.fromJson(Map<String, dynamic> json) =>
      WorkspaceDetailModel(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          ownerId: json['owner_id'],
          visibility: json['visibility'],
          userWorkspaceModel: (json['user_workspace'] as List)
              .map((e) => UserWorkspaceDetailModel.fromJson(e))
              .toList());

  @override
  List<Object> get props =>
      [id, name, description, ownerId, visibility, userWorkspaceModel];
}

class UserWorkspaceDetailModel extends Equatable {
  final int id;
  final String workspaceId;
  final int userId;
  final String role;

  const UserWorkspaceDetailModel(
      {required this.id,
      required this.workspaceId,
      required this.userId,
      required this.role});

  factory UserWorkspaceDetailModel.fromJson(Map<String, dynamic> json) =>
      UserWorkspaceDetailModel(
          id: json['id'],
          workspaceId: json['workspace_id'],
          userId: json['user_id'],
          role: json['role']);

  @override
  List<Object> get props => [id, workspaceId, userId, role];
}

class WorkspaceTaskModel extends Equatable {
  final int id;
  final int userId;
  final String workspaceId;
  final String title;
  final String description;
  final String progress;
  final String label;
  final String milestone;

  const WorkspaceTaskModel(
      {required this.id,
      required this.workspaceId,
      required this.userId,
      required this.title,
      required this.description,
      required this.label,
      required this.milestone,
      required this.progress});

  factory WorkspaceTaskModel.fromJson(Map<String, dynamic> json) =>
      WorkspaceTaskModel(
          id: json['id'],
          workspaceId: json['workspace_id'],
          userId: json['user_id'],
          title: json['title'],
          description: json['description'],
          label: json['label'],
          milestone: json['milestone'],
          progress: json['progress']);

  @override
  List<Object> get props =>
      [id, workspaceId, userId, title, description, label, milestone, progress];
}

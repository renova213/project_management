import 'package:equatable/equatable.dart';

class WorkspaceModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final int ownerId;
  final String visibility;
  final List<UserWorkspaceModel> userWorkspaceModel;

  const WorkspaceModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.ownerId,
      required this.visibility,
      required this.userWorkspaceModel});

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) => WorkspaceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      ownerId: json['owner_id'],
      visibility: json['visibility'],
      userWorkspaceModel: (json['user_workspace'] as List)
          .map((e) => UserWorkspaceModel.fromJson(e))
          .toList());

  @override
  List<Object> get props =>
      [id, name, description, ownerId, visibility, userWorkspaceModel];
}

class UserWorkspaceModel extends Equatable {
  final int id;
  final String workspaceId;
  final int userId;
  final String role;

  const UserWorkspaceModel(
      {required this.id,
      required this.workspaceId,
      required this.userId,
      required this.role});

  factory UserWorkspaceModel.fromJson(Map<String, dynamic> json) =>
      UserWorkspaceModel(
          id: json['id'],
          workspaceId: json['workspace_id'],
          userId: json['user_id'],
          role: json['role']);

  @override
  List<Object> get props => [id, workspaceId, userId, role];
}

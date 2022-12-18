import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final int userId;
  final String workspaceId;
  final String title;
  final String description;
  final String progress;
  final String label;
  final String milestone;
  final List<UserTaskModel> userTasks;

  const TaskModel(
      {required this.id,
      required this.workspaceId,
      required this.userId,
      required this.title,
      required this.description,
      required this.label,
      required this.milestone,
      required this.progress,
      required this.userTasks});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'],
      workspaceId: json['workspace_id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      label: json['label'] ?? "",
      milestone: json['milestone'] ?? "",
      progress: json['progress'],
      userTasks: (json['user_task'] as List)
          .map((e) => UserTaskModel.fromJson(e))
          .toList());
  @override
  List<Object> get props => [
        id,
        userId,
        workspaceId,
        title,
        description,
        progress,
        label,
        milestone,
        userTasks
      ];
}

class UserTaskModel extends Equatable {
  final int id;
  final int userId;
  final int taskId;
  final String email;
  final String username;

  const UserTaskModel(
      {required this.id,
      required this.userId,
      required this.taskId,
      required this.email,
      required this.username});
  @override
  List<Object> get props => [id, userId, taskId, email, username];

  factory UserTaskModel.fromJson(Map<String, dynamic> json) => UserTaskModel(
      id: json['id'],
      userId: json['user_id'],
      taskId: json['task_id'],
      email: json['email'],
      username: json['username']);
}

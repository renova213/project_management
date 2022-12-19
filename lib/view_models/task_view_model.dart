import 'package:final_project/models/task/api/task_api.dart';
import 'package:final_project/models/task/task_model.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_state.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskApi taskApi = TaskApi();

  late TaskModel _task;
  AppState _appState = AppState.loading;

  TaskModel get task => _task;
  AppState get appstate => _appState;

  Future<void> getTask(int taskId) async {
    try {
      changeAppState(AppState.loading);

      _task = await taskApi.getTaskById(taskId);

      changeAppState(AppState.loaded);
    } catch (_) {
      changeAppState(AppState.failure);
    }
  }

  Future<void> updateTask(
      {required int id,
      required String title,
      required String description,
      required String progress,
      required String milestone,
      required String workspaceId}) async {
    try {
      await taskApi.putTask(
          id: id,
          title: title,
          description: description,
          progress: progress,
          milestone: milestone);
      getTask(id);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> assignMemberTask(
      {required int userId, required int taskId}) async {
    try {
      await taskApi.assignMemberTask(userId: userId, taskId: taskId);
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      getTask(taskId);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteAssignMemberTask(
      {required int userId, required int taskId}) async {
    try {
      await taskApi.deleteAssignMemberTask(userId: userId, taskId: taskId);
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      getTask(taskId);
    } catch (_) {
      rethrow;
    }
  }

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }
}

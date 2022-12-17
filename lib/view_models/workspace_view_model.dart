import 'package:final_project/models/task/api/task_api.dart';
import 'package:final_project/models/workspace/api/workspace_api.dart';
import 'package:final_project/models/workspace/workspace_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/workspace/workspace.dart';
import '../utils/app_state.dart';

class WorkspaceViewModel extends ChangeNotifier {
  WorkspaceApi workspaceApi = WorkspaceApi();
  TaskApi taskApi = TaskApi();

  AppState _appState = AppState.loading;
  AppState _appState2 = AppState.loading;

  List<WorkspaceModel> _workspaces = [];
  late Workspace _workspacesById;

  List<WorkspaceModel> get workspaces => _workspaces;
  Workspace get workspacesById => _workspacesById;
  AppState get appState => _appState;
  AppState get appState2 => _appState2;

  Future<void> getWorkspaces() async {
    try {
      changeAppState(AppState.loading);

      _workspaces = await workspaceApi.getRequestWorkSpace();

      if (_workspaces.isEmpty) {
        changeAppState(AppState.noData);
      }

      changeAppState(AppState.loaded);
    } catch (_) {
      changeAppState(AppState.failure);
    }
  }

  Future<void> getWorkspacesById(String workspaceId) async {
    try {
      changeAppState2(AppState.loading);

      _workspacesById = await workspaceApi.getWorkspaceById(workspaceId);
      if (_workspaces.isEmpty) {
        changeAppState2(AppState.noData);
      }
      changeAppState2(AppState.loaded);
    } catch (_) {
      changeAppState2(AppState.failure);
    }
  }

  Future<void> postWorkspaces(
      {required String workspaceName,
      required String workspaceDescription}) async {
    try {
      await workspaceApi.postWorkspace(
          workspaceName: workspaceName,
          workspaceDescription: workspaceDescription);
      getWorkspaces();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateWorkspaces(
      {required String workspaceName,
      required String workspaceDescription,
      required String workspaceId}) async {
    try {
      await workspaceApi.updateWorkspace(
          workspaceName: workspaceName,
          workspaceDescription: workspaceDescription,
          workspaceId: workspaceId);
      await getWorkspaces();
      await getWorkspacesById(workspaceId);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteWorkspace(String workspaceId) async {
    try {
      await workspaceApi.deleteWorkspace(workspaceId);
      getWorkspaces();
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> postTask(
      {required String workspaceId,
      required String title,
      required String description}) async {
    try {
      await taskApi.postTask(
          workspaceId: workspaceId, title: title, description: description);
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateTask(
      {required int id,
      required String title,
      required String description,
      required String progress,
      required String workspaceId}) async {
    try {
      await taskApi.putTask(
          id: id, title: title, description: description, progress: progress);
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  void changeAppState2(AppState appState) {
    _appState2 = appState;
    notifyListeners();
  }
}

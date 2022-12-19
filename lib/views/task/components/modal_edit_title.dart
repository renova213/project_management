import 'package:final_project/constants/app_font.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalEditTitle extends StatefulWidget {
  final String title;
  const ModalEditTitle({super.key, required this.title});

  @override
  State<ModalEditTitle> createState() => _ModalAddWorkspaceState();
}

class _ModalAddWorkspaceState extends State<ModalEditTitle> {
  final TextEditingController _titleContainer = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleContainer.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleContainer.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    final focusField = FocusNode();

    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () {
          focusField.unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Container(
          width: double.maxFinite,
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
              const SizedBox(height: 8),
              _closeButton(context),
              const SizedBox(height: 8),
              _formEditTitle(),
              const SizedBox(height: 8),
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
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

  Widget _formEditTitle() {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title Task :",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleContainer,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Title task',
                labelStyle: GoogleFonts.urbanist(
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 45,
              width: double.maxFinite,
              child: Consumer<TaskViewModel>(
                builder: (context, task, _) => Consumer<WorkspaceViewModel>(
                  builder: (context, workspace, _) => ElevatedButton(
                    onPressed: () async {
                      if (_titleContainer.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Form tidak boleh kosong");
                      } else {
                        try {
                          await task
                              .updateTask(
                                  id: task.task.id,
                                  title: _titleContainer.text,
                                  description: task.task.description,
                                  progress: task.task.progress,
                                  milestone: task.task.milestone,
                                  workspaceId: task.task.workspaceId)
                              .then(
                                (_) => workspace
                                    .getWorkspacesById(task.task.workspaceId),
                              )
                              .then(
                                (_) => Navigator.pop(context),
                              );
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      "Confirm",
                      style: AppFont.subtitle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

import 'package:final_project/constants/app_font.dart';
import 'package:final_project/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../view_models/workspace_view_model.dart';

class ModalEditMilestone extends StatefulWidget {
  final String date;
  const ModalEditMilestone({super.key, required this.date});

  @override
  State<ModalEditMilestone> createState() => _ModalAddWorkspaceState();
}

class _ModalAddWorkspaceState extends State<ModalEditMilestone> {
  final TextEditingController dateCtl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    dateCtl.dispose();
  }

  @override
  void initState() {
    super.initState();
    dateCtl.text = widget.date;
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
              "Description Task :",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            selectDate(),
            const SizedBox(height: 16),
            SizedBox(
              height: 45,
              width: double.maxFinite,
              child: Consumer<TaskViewModel>(
                builder: (context, task, _) => Consumer<WorkspaceViewModel>(
                  builder: (context, workspace, _) => ElevatedButton(
                    onPressed: () async {
                      if (dateCtl.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Form tidak boleh kosong");
                      } else {
                        try {
                          await task
                              .updateTask(
                                  id: task.task.id,
                                  milestone: dateCtl.text,
                                  title: task.task.title,
                                  progress: task.task.progress,
                                  description: task.task.description,
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

  Widget selectDate() {
    DateTime date = DateTime.now();
    DateTime initialDate = DateTime(
      date.year,
      date.month,
      date.day,
    );
    DateTime firstDate = DateTime(
      date.year,
      date.month,
      date.day,
    );
    DateTime lastDate = DateTime(
      date.year + 10,
      date.month,
      date.day,
    );
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate);

        if (pickedDate != null) {
          setState(
            () {
              dateCtl.text = DateFormat('dd MMMM yyyy').format(pickedDate);
            },
          );
        }
      },
      child: TextField(
        style: AppFont.bodyText1.copyWith(color: Colors.grey.shade700),
        controller: dateCtl,
        enabled: false,
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          suffixIconConstraints:
              const BoxConstraints(minHeight: 24, minWidth: 24),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: const Icon(
              Icons.edit_calendar,
              color: Colors.grey,
            ),
          ),
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
          hintText: 'Pilih tanggal',
          hintStyle: AppFont.bodyText1.copyWith(color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}

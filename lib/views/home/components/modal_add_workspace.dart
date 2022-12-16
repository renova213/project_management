import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalAddWorkspace extends StatefulWidget {
  const ModalAddWorkspace({super.key});

  @override
  State<ModalAddWorkspace> createState() => _ModalAddWorkspaceState();
}

class _ModalAddWorkspaceState extends State<ModalAddWorkspace> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
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
              _formAddWorkspace(),
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

  Widget _formAddWorkspace() {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Workspace Name :",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Workspace Name',
                labelStyle: GoogleFonts.urbanist(
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Workspace Description :",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Workspace Description',
                labelStyle: GoogleFonts.urbanist(
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 45,
              width: double.maxFinite,
              child: Consumer<WorkspaceViewModel>(
                builder: (context, workspace, _) => ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty ||
                        _descriptionController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Form tidak boleh kosong");
                    } else {
                      try {
                        await workspace
                            .postWorkspaces(
                                workspaceName: _nameController.text,
                                workspaceDescription:
                                    _descriptionController.text)
                            .then((_) => Fluttertoast.showToast(
                                msg: "Workspace berhasil ditambahkan"))
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
                  child: const Text("Create Workspace"),
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

import 'package:final_project/constants/app_font.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalAddTeam extends StatefulWidget {
  const ModalAddTeam({super.key});

  @override
  State<ModalAddTeam> createState() => _ModalAddWorkspaceState();
}

class _ModalAddWorkspaceState extends State<ModalAddTeam> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
              "Email User :",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email User',
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
                    if (_emailController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Form tidak boleh kosong");
                    } else {
                      try {
                        await workspace
                            .addWorkspaceTeam(
                                email: _emailController.text,
                                workspaceId:
                                    workspace.workspacesById.workspaceDetail.id)
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
                  child: Text(
                    "Confirm",
                    style: AppFont.subtitle.copyWith(color: Colors.white),
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

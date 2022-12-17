import 'package:final_project/models/workspace/workspace_model.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:final_project/utils/navigator_helper.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:final_project/views/widgets/skeleton_container.dart';
import 'package:final_project/views/workspace/workspace_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/app_font.dart';
import 'components/home_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WorkspaceViewModel>(context, listen: false).getWorkspaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addWorkspaceModal(context);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 32.h),
                _header(),
                SizedBox(height: 32.h),
                _listProject(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent),
              child: Text(
                "D",
                style: GoogleFonts.amita(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 16.w),
            Text("My Project", style: AppFont.headline6),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.search, size: 24.sp),
        ),
      ],
    );
  }

  Widget _listProject() {
    return Consumer<WorkspaceViewModel>(
      builder: (context, workspace, _) {
        if (workspace.appState == AppState.loaded) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = workspace.workspaces[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      NavigatorHelper(
                        child: WorkspaceScreen(workspace: data),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 100.h,
                            width: double.maxFinite,
                            alignment: Alignment.bottomLeft,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/project_background.jpg'),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 24.w, right: 24.w, bottom: 12.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Text(
                                      data.name[0],
                                      style: GoogleFonts.amita(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  _listMemberTeam(data: data, index: index),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 16.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.name, style: AppFont.subtitle),
                                  SizedBox(height: 8.h),
                                  Text(data.description,
                                      style: AppFont.bodyText2),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: workspace.workspaces.length);
        }

        if (workspace.appState == AppState.noData) {
          return Center(
            child: Text(
              "Project is empty",
              style: AppFont.headline6,
            ),
          );
        }
        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const SkeletonContainer(
                width: double.maxFinite, height: 180, borderRadius: 15),
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemCount: 8);
      },
    );
  }

  Widget _listMemberTeam({required int index, required WorkspaceModel data}) {
    return SizedBox(
      height: 45.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.userWorkspaceModel.length <= 4
            ? data.userWorkspaceModel.length
            : 4,
        itemBuilder: (context, index) {
          if (index <= 4 && data.userWorkspaceModel.length <= 4) {
            return Align(
              widthFactor: 0.5,
              child: Container(
                width: 45.w,
                height: 45.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blueAccent),
                ),
              ),
            );
          }
          return Align(
            widthFactor: 0.5,
            child: Container(
              width: 45.w,
              height: 45.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        image: const NetworkImage(
                            'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blueAccent),
                child: Text("+${data.userWorkspaceModel.length - 4}",
                    style: AppFont.subtitle.copyWith(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addWorkspaceModal(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return const Align(
          alignment: Alignment.bottomCenter,
          child: ModalAddWorkspace(),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}

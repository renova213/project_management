import 'package:flutter/material.dart';
import 'package:final_project/constants/app_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/workspace_view_model.dart';

class OpenTask extends StatelessWidget {
  const OpenTask({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 48.w,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.w),
            Row(
              children: [
                Text("Open", style: AppFont.subtitle),
                SizedBox(width: 16.w),
                Container(
                  width: 40.w,
                  height: 30.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.6), width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "6",
                    style: AppFont.bodyText1.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
            _listTask(),
            SizedBox(height: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _listTask() {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      shrinkWrap: true,
      itemCount: 8,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Build Wireframe", style: AppFont.subtitle),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Material(
                        color: Colors.transparent,
                        child: Consumer<WorkspaceViewModel>(
                          builder: (context, workspace, _) => PopupMenuButton(
                            onSelected: (value) async {
                              if (value == 0) {}
                              if (value == 1) {}
                              if (value == 2) {}
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 0,
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit, size: 18),
                                    SizedBox(width: 8.w),
                                    Text("Edit Task", style: AppFont.bodyText2),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    const Icon(Icons.people, size: 18),
                                    SizedBox(width: 8.w),
                                    Text("Assign Team",
                                        style: AppFont.bodyText2),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete,
                                        size: 18, color: Colors.red),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Delete Task",
                                      style: AppFont.bodyText2
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            child: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.transparent,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: const Icon(Icons.more_horiz,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text("Due date: 22 December 2022", style: AppFont.bodyText2),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _listAssignMember(),
                    const Spacer(),
                    PopupMenuButton(
                      onSelected: (value) async {
                        if (value == 0) {}
                        if (value == 1) {}
                        if (value == 2) {}
                        if (value == 3) {}
                        if (value == 4) {}
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.flag,
                                  color: Colors.blue[100], size: 18.sp),
                              SizedBox(width: 8.w),
                              Text("Open", style: AppFont.bodyText2),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.flag,
                                  color: Colors.yellow, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text("Pending", style: AppFont.bodyText2),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(Icons.flag, color: Colors.blue, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "To-Do",
                                style: AppFont.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Row(
                            children: [
                              Icon(Icons.flag, color: Colors.red, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "In-Progress",
                                style: AppFont.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 4,
                          child: Row(
                            children: [
                              Icon(Icons.flag,
                                  color: Colors.green, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "Done",
                                style: AppFont.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ],
                      child:
                          Icon(Icons.flag, color: Colors.yellow, size: 30.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listAssignMember() {
    const int item = 5;
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: item <= 4 ? item : 4,
        itemBuilder: (context, index) {
          if (index < 3) {
            return Align(
              widthFactor: 0.5,
              child: Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  width: 35.w,
                  height: 35.h,
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
              width: 40.w,
              height: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                width: 35.w,
                height: 35.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: item > 4
                            ? ColorFilter.mode(Colors.black.withOpacity(0.5),
                                BlendMode.dstATop)
                            : null,
                        image: const NetworkImage(
                            'https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blueAccent),
                child: item > 4
                    ? Text("+${item - 4}",
                        style: AppFont.subtitle.copyWith(color: Colors.white))
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:final_project/constants/app_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/workspace_view_model.dart';

class InProgressTask extends StatelessWidget {
  const InProgressTask({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 48.w,
      decoration: BoxDecoration(
        color: Colors.red[100],
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
                Text("In-Progress", style: AppFont.subtitle),
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
            SizedBox(height: 16.h),
            Container(
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
                              builder: (context, workspace, _) =>
                                  PopupMenuButton(
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
                                        Text("Edit Task",
                                            style: AppFont.bodyText2),
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
                                    border: Border.all(
                                        color: Colors.black, width: 1.5),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.w),
          ],
        ),
      ),
    );
  }
}

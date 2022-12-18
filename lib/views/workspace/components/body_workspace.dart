import 'package:final_project/views/workspace/components/open_task.dart';
import 'package:final_project/views/workspace/components/pending_task.dart';
import 'package:final_project/views/workspace/components/workspace_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyWorkspace extends StatelessWidget {
  const BodyWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OpenTask(),
            SizedBox(width: 24.w),
            const PendingTask(),
            SizedBox(width: 24.w),
            const InProgressTask(),
            SizedBox(width: 24.w),
            const DoneTask(),
          ],
        ),
      ),
    );
  }
}

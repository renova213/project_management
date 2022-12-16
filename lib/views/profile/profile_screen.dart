import 'package:final_project/utils/app_state.dart';
import 'package:final_project/utils/navigator_helper.dart';
import 'package:final_project/view_models/auth_view_model.dart';
import 'package:final_project/view_models/profil_view_model.dart';
import 'package:final_project/views/auth/login_page.dart';
import 'package:final_project/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/app_font.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ProfilViewModel>(context, listen: false).getProfil(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),
                _header(),
                SizedBox(height: 32.h),
                _imageAndName(),
                SizedBox(height: 16.h),
                Divider(color: Colors.grey.shade300),
                _customMenu(
                    icon: Icons.work,
                    title: "Workspace",
                    onpressed: () {},
                    index: 0),
                _customMenu(
                    icon: Icons.person,
                    title: "Edit Profile",
                    onpressed: () {},
                    index: 0),
                _customMenu(
                    icon: Icons.notifications,
                    title: "Notification",
                    onpressed: () {},
                    index: 0),
                _customMenu(
                    icon: Icons.help,
                    title: "Help",
                    onpressed: () {},
                    index: 0),
                Consumer<AuthViewModel>(
                  builder: (context, auth, _) => _customMenu(
                      icon: Icons.logout,
                      title: "Logout",
                      onpressed: () async {
                        await auth
                            .logoutRequest()
                            .then(
                              (_) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Berhasil logout",
                                    style: AppFont.subtitle
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                            .then(
                              (_) => Navigator.of(context).pushAndRemoveUntil(
                                  NavigatorHelper(child: const LoginPage()),
                                  (route) => false),
                            );
                      },
                      index: 1),
                ),
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
        Text("My Profile", style: AppFont.headline6),
      ],
    );
  }

  Widget _imageAndName() {
    return Consumer<ProfilViewModel>(
      builder: (context, profil, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 115.w,
            child: Stack(
              children: [
                Container(
                  width: 110.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://cf.shopee.co.id/file/182adc5f2a32e0101f6390c6c9e990b8"),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 85.h,
                  left: 90.w,
                  child: Container(
                    width: 25.w,
                    height: 25.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue),
                    child: Icon(Icons.edit, color: Colors.white, size: 15.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          profil.appState == AppState.loaded
              ? Text(profil.profil.username, style: AppFont.subtitle)
              : const SkeletonContainer(
                  width: 130, height: 15, borderRadius: 0),
          SizedBox(height: 8.h),
          profil.appState == AppState.loaded
              ? Text(
                  profil.profil.email,
                  style:
                      AppFont.bodyText2.copyWith(fontWeight: FontWeight.bold),
                )
              : const SkeletonContainer(
                  width: 130, height: 15, borderRadius: 0),
        ],
      ),
    );
  }

  Widget _customMenu(
      {required IconData icon,
      required String title,
      required Function onpressed,
      required int index}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onpressed();
        },
        child: SizedBox(
          width: double.maxFinite,
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon,
                  size: 24.sp,
                  color: index == 0 ? Colors.blueGrey : Colors.red),
              SizedBox(width: 16.w),
              Text(
                title,
                style: AppFont.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: index == 0 ? Colors.black : Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}

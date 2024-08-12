import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:sizer/sizer.dart';

class ViewMembersScreen extends StatelessWidget {
  const ViewMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildMemberCard(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu_rounded),
      ),
      title: const Text("Member Details"),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [StyleResources.greyBlack, StyleResources.black],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_rounded),
        ),
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(PageResources.addMemberScreen),
          icon: const Icon(Icons.add_circle_outlined),
          color: StyleResources.primaryColor,
        ),
      ],
    );
  }

  Widget _buildMemberCard() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: StyleResources.accentColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileImage(),
              SizedBox(width: 5.w),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sriya",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "+1234567890",
                      style: TextStyle(
                        color: StyleResources.greyBlack,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn("Plan Type", "Cardio"),
                        _buildInfoColumn("Register Number", "110"),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn("Address", "Pattambi"),
                        _buildInfoColumn("Gender", "Female"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          const Divider(),
          SizedBox(height: 2.h),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUserActionButton(
                        icon: FontAwesomeIcons.phone, label: "Call"),
                    _buildUserActionButton(
                        icon: FontAwesomeIcons.whatsapp, label: "WhatsApp"),
                    _buildUserActionButton(
                        icon: FontAwesomeIcons.commentSms, label: "SMS"),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUserActionButton(
                        icon: FontAwesomeIcons.personCircleCheck,
                        label: "Attendance"),
                    _buildUserActionButton(
                        icon: FontAwesomeIcons.dumbbell, label: "Renew"),
                    _buildUserActionButton(
                        icon: FontAwesomeIcons.circleXmark, label: "Delete"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red,
        // Uncomment and use the below code if you have the profile image URL
        // image: DecorationImage(
        //   image: CachedNetworkImageProvider('profileImageUrl'),
        //   fit: BoxFit.contain,
        //   alignment: Alignment.topCenter,
        // ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: StyleResources.greyBlack,
            fontSize: 8.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: StyleResources.black,
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildUserActionButton(
      {required IconData icon, required String label, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}

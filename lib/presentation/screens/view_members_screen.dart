import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/presentation/bloc/activate_user/activate_user_bloc.dart';
import 'package:gym/presentation/bloc/block_user/block_user_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/service/model/members_model.dart';

class ViewMembersScreen extends StatelessWidget {
  final MembersModel membersModel;
  const ViewMembersScreen({
    super.key,
    required this.membersModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildMemberCard(context),
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

  Widget _buildMemberCard(BuildContext context) {
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
                      membersModel.name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      membersModel.mobileNumber.toString(),
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
                        _buildInfoColumn(
                            "Plan Type", membersModel.packageModel.name),
                        _buildInfoColumn("Register Number",
                            membersModel.registerNumber.toString()),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn(
                            "Address", membersModel.mobileNumber.toString()),
                        _buildInfoColumn("Gender", "Male"),
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildUserActionButton(
                          icon: FontAwesomeIcons.phone, label: "Call"),
                    ),
                    Expanded(
                      child: _buildUserActionButton(
                          icon: FontAwesomeIcons.whatsapp, label: "WhatsApp"),
                    ),
                    Expanded(
                      child: _buildUserActionButton(
                          icon: FontAwesomeIcons.commentSms, label: "SMS"),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildUserActionButton(
                          icon: FontAwesomeIcons.personCircleCheck,
                          label: "Attendance"),
                    ),
                    Expanded(
                      child: BlocListener<ActivateUserBloc, ActivateUserState>(
                        listener: (context, state) {
                          state.whenOrNull(
                              loaded: () => getSnackBar(
                                    context,
                                    title: 'Successfully completed',
                                  ),
                              failed: (error) => getSnackBar(context,
                                  title: error,
                                  bgcolor: StyleResources.errorColor));
                        },
                        child: _buildUserActionButton(
                            icon: FontAwesomeIcons.dumbbell,
                            label: "InActivate"),
                      ),
                    ),
                    Expanded(
                      child: BlocListener<BlockUserBloc, BlockUserState>(
                        listener: (context, state) {
                          state.whenOrNull(
                              loaded: () => getSnackBar(
                                    context,
                                    title: 'Successfully blocked User',
                                  ),
                              failed: (error) => getSnackBar(context,
                                  title: error,
                                  bgcolor: StyleResources.errorColor));
                        },
                        child: _buildUserActionButton(
                            icon: FontAwesomeIcons.circleXmark,
                            label: "Block",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Block ${membersModel.name}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                      "Are you sure to Block this user?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel")),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    StyleResources.black)),
                                        child: const Text("Confirm")),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
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
        image: membersModel.propicUrl != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(membersModel.propicUrl!),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                scale: .5)
            : null,
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

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/presentation/bloc/activate_user/activate_user_bloc.dart';
import 'package:gym/presentation/bloc/block_user/block_user_bloc.dart';
import 'package:gym/presentation/widgets/profile_status_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/service/model/members_model.dart';

class ViewMembersScreen extends StatefulWidget {
  final MembersModel membersModel;
  const ViewMembersScreen({
    super.key,
    required this.membersModel,
  });

  @override
  State<ViewMembersScreen> createState() => _ViewMembersScreenState();
}

class _ViewMembersScreenState extends State<ViewMembersScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildMemberCard(context),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last Transaction",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                      PageResources.individualMemberTransaction,
                      arguments: widget.membersModel.uid),
                  child: Text(
                    "All Transactions",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: StyleResources.scaffoldBackgroundColor),
              child: Column(
                children: [
                  buildTransactionDetailsRow(
                    label: "Date of transaction",
                    content: widget.membersModel.lastFeesPaid != null
                        ? dateFormate(date: widget.membersModel.lastFeesPaid!)
                        : "Not Available",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTransactionDetailsRow(
                    label: "Package Type",
                    content: widget.membersModel.packageModel.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTransactionDetailsRow(
                    label: "Package Duration",
                    content: "${widget.membersModel.packageDuration} days",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTransactionDetailsRow(
                    label: "Package Status",
                    content: widget.membersModel.packageEndDate
                                ?.isAfter(DateTime.now()) ==
                            true
                        ? "Expired"
                        : "Active",
                    textColor: widget.membersModel.packageEndDate
                                ?.isAfter(DateTime.now()) ==
                            true
                        ? StyleResources.errorColor
                        : Colors.green,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.membersModel.lastFeesPaid != null)
                    buildTransactionDetailsRow(
                        label: "No of days after package Expired",
                        content: calculateDaysAfterExpiration(
                            widget.membersModel.lastFeesPaid!),
                        textColor: StyleResources.errorColor),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.membersModel.packageEndDate
                          ?.isBefore(DateTime.now()) ==
                      true)
                    buildTransactionDetailsRow(
                        label: "Pending Days",
                        content: calculatePackageDays(
                            widget.membersModel.lastFeesPaid!),
                        textColor: StyleResources.errorColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.membersModel.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PackageStatusWidget(
                          packageEndDate: DateTime.now().add(Duration(
                              days: widget.membersModel.packageDuration ?? 0)),
                        )
                      ],
                    ),
                    Text(
                      widget.membersModel.mobileNumber.toString(),
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
                            "Plan Type", widget.membersModel.packageModel.name),
                        _buildInfoColumn("Register Number",
                            widget.membersModel.registerNumber.toString()),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn("Address",
                            widget.membersModel.mobileNumber.toString()),
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
                          icon: FontAwesomeIcons.phone,
                          label: "Call",
                          iconColor: StyleResources.secondaryColor,
                          onTap: () async {
                            final url = Uri.parse(
                                "tel:${widget.membersModel.mobileNumber}");
                            await lauchMembersConnectivity(url: url);
                          }),
                    ),
                    Expanded(
                      child: _buildUserActionButton(
                          icon: FontAwesomeIcons.whatsapp,
                          label: "WhatsApp",
                          iconColor: StyleResources.secondaryColor,
                          onTap: () async {
                            final url = Uri.parse(
                                "https://wa.me/+91${widget.membersModel.mobileNumber}");
                            await lauchMembersConnectivity(url: url);
                          }),
                    ),
                    Expanded(
                      child: _buildUserActionButton(
                          icon: FontAwesomeIcons.commentSms,
                          label: "SMS",
                          iconColor: StyleResources.secondaryColor,
                          onTap: () async {
                            final url = Uri.parse(
                                "sms:${widget.membersModel.mobileNumber}");
                            await lauchMembersConnectivity(url: url);
                          }),
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
                        label: "Attendance",
                        iconColor: StyleResources.secondaryColor,
                      ),
                    ),
                    Expanded(
                      child: BlocListener<ActivateUserBloc, ActivateUserState>(
                        listener: (context, state) {
                          state.whenOrNull(
                              loaded: () {
                                getSnackBar(
                                  context,
                                  title: 'Successfully InActivated the user.',
                                );
                                Navigator.pop(context);
                              },
                              failed: (error) => getSnackBar(context,
                                  title: error,
                                  bgcolor: StyleResources.errorColor));
                        },
                        child: _buildUserActionButton(
                            icon: FontAwesomeIcons.dumbbell,
                            label: "InActivate",
                            iconColor: widget.membersModel.isActive == true
                                ? Colors.green
                                : Colors.red,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "InActivate ${widget.membersModel.name}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                      "Are you sure to InActivate this user?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () => context
                                            .read<ActivateUserBloc>()
                                            .add(
                                              ActivateUserEvent.activateUser(
                                                  uuid: widget.membersModel.uid,
                                                  status: widget.membersModel
                                                              .isActive !=
                                                          null
                                                      ? !(widget.membersModel
                                                          .isActive!)
                                                      : true),
                                            ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    StyleResources.errorColor)),
                                        child: const Text("InActivate")),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      child: BlocListener<BlockUserBloc, BlockUserState>(
                        listener: (context, state) {
                          log("state of BlocUser bloc $state");
                          state.whenOrNull(
                              loaded: () {
                                getSnackBar(
                                  context,
                                  title: 'Successfully blocked User',
                                );
                                Navigator.pop(context);
                                // setState(() {});
                              },
                              failed: (error) => getSnackBar(context,
                                  title: error,
                                  bgcolor: StyleResources.errorColor));
                        },
                        child: _buildUserActionButton(
                            icon: FontAwesomeIcons.circleXmark,
                            label: "Block",
                            iconColor: widget.membersModel.isBlocked == true
                                ? StyleResources.errorColor
                                : null,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Block ${widget.membersModel.name}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                      "Are you sure to Block this user?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    ElevatedButton(
                                        onPressed: () => context
                                            .read<BlockUserBloc>()
                                            .add(BlockUserEvent.blockUser(
                                                uuid: widget.membersModel.uid,
                                                status: widget.membersModel
                                                            .isBlocked !=
                                                        null
                                                    ? !(widget.membersModel
                                                        .isBlocked!)
                                                    : true)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    StyleResources.errorColor)),
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
    return InkWell(
      onTap: () {
        widget.membersModel.propicUrl != null
            ? showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Container(
                    height: 60.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.membersModel.propicUrl!),
                            fit: BoxFit.cover)),
                  ),
                ),
              )
            : null;
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: widget.membersModel.propicUrl != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                      widget.membersModel.propicUrl!),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  scale: .5)
              : null,
        ),
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
      {required IconData icon,
      required String label,
      VoidCallback? onTap,
      Color? iconColor}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.grey,
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

  lauchMembersConnectivity({required Uri url}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildTransactionDetailsRow(
      {required String label, required String content, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ":",
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: 10.sp, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }
}

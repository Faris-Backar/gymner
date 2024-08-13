import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/service/model/members_model.dart';

class MemberDetailsCard extends StatefulWidget {
  final MembersModel membersModel;
  const MemberDetailsCard({
    super.key,
    required this.membersModel,
  });

  @override
  State<MemberDetailsCard> createState() => _MemberDetailsCardState();
}

class _MemberDetailsCardState extends State<MemberDetailsCard> {
  bool isCardTapped = false;

  void _toggleCardTap() {
    setState(() {
      isCardTapped = !isCardTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(PageResources.viewMembersScreen),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: StyleResources.accentColor,
          border: isCardTapped
              ? Border.all(color: StyleResources.primaryColor)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(),
            SizedBox(width: 1.w),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMemberInfo(),
                  SizedBox(height: 2.h),
                  _buildPlanDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Expanded(
      flex: 2,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: widget.membersModel.propicUrl != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                      widget.membersModel.propicUrl!),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  scale: .5)
              : null,
        ),
      ),
    );
  }

  Widget _buildMemberInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.membersModel.name,
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.membersModel.mobileNumber.toString(),
              style: TextStyle(color: StyleResources.greyBlack, fontSize: 8.sp),
            ),
          ],
        ),
        IconButton(
          onPressed: _toggleCardTap,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Icon(
              isCardTapped
                  ? FontAwesomeIcons.circleChevronDown
                  : FontAwesomeIcons.circleChevronRight,
              key: ValueKey<bool>(isCardTapped),
              color: isCardTapped
                  ? StyleResources.primaryColor
                  : StyleResources.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Plan Expiry",
              style: TextStyle(color: StyleResources.greyBlack, fontSize: 8.sp),
            ),
            Text(
              "01 Aug 2021",
              style: TextStyle(
                color: StyleResources.black,
                fontSize: 9.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Days Remaining",
              style: TextStyle(color: StyleResources.greyBlack, fontSize: 8.sp),
            ),
            Text(
              "10",
              style: TextStyle(
                color: StyleResources.black,
                fontSize: 9.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

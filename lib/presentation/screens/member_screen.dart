import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final membersBloc = getIt<MembersBloc>();
    membersBloc.add(GetMembersEvent());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Members'),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(PageResources.addMemberScreen),
            child: const Text('Add Members'),
          )
        ],
      ),
      body: BlocBuilder(
        bloc: membersBloc,
        builder: (context, state) {
          log(state.toString());
          if (state is MembersLoadding) {
            return Center(
              child: SizedBox(
                height: 10.h,
                width: 10.h,
              ),
            );
          }
          if (state is MembersFailed) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is GetMembersLoaded) {
            final membersData = state.membersList;
            if (membersData.isEmpty) {
              return Center(
                child: Text(
                  "No data available",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemCount: membersData.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    PageResources.viewMembersScreen,
                    arguments: membersData[index]),
                child: MembersCard(
                  mobileNumber: membersData[index].mobileNumber.toString(),
                  name: membersData[index].name,
                  registrationNumber:
                      membersData[index].registerNumber.toString(),
                  profilePicUrl: membersData[index].propicUrl,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class MembersCard extends StatelessWidget {
  const MembersCard({
    Key? key,
    required this.name,
    required this.mobileNumber,
    required this.registrationNumber,
    this.profilePicUrl,
  }) : super(key: key);
  final String name;
  final String mobileNumber;
  final String registrationNumber;
  final String? profilePicUrl;

  @override
  Widget build(BuildContext context) {
    log('profiel pic =>$profilePicUrl');
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 10.h,
              width: 10.h,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                imageUrl: profilePicUrl ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.red,
                        BlendMode.colorBurn,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 5.h,
                    width: 5.w,
                    child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reg: $registrationNumber"),
                Text("Name: $name"),
                Text('Mobile : $mobileNumber'),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
      ),
    );
  }
}

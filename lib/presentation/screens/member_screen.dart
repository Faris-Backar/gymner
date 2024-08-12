import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/presentation/widgets/member_details_card.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final _searchController = TextEditingController();
  final membersBloc = getIt<MembersBloc>();
  String? filterByPackageSelectedValue;
  String? filterByExpiredSelectedValue;

  final List<String> items = ['Option 1', 'Option 2', 'Option 3'];

  @override
  void initState() {
    super.initState();
    filterByExpiredSelectedValue = items[0];
    filterByExpiredSelectedValue = items[1];
    membersBloc.add(GetMembersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleResources.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Members",
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildMembersList(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu_rounded),
      ),
      title: const Text("Members"),
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
      bottom: PreferredSize(
        preferredSize: Size(100.w, 15.h),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextInputFormField(
                  controller: _searchController,
                  borderRadius: 30,
                  hint: "Search Name / Mobile Number",
                  fillColor: StyleResources.accentColor.withOpacity(0.05),
                  prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                  hintDecoration: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: StyleResources.accentColor.withOpacity(0.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            _buildDropdowns(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdowns() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              child: _buildDropdown(filterByPackageSelectedValue, (value) {
            setState(() {
              filterByPackageSelectedValue = value;
            });
          })),
          SizedBox(width: 3.w),
          Expanded(
              child: _buildDropdown(filterByExpiredSelectedValue, (value) {
            setState(() {
              filterByExpiredSelectedValue = value;
            });
          })),
        ],
      ),
    );
  }

  Widget _buildDropdown(
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Container(
      height: 5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: StyleResources.accentColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          style: const TextStyle(color: Colors.black),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  value,
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMembersList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<MembersBloc, MembersState>(
          bloc: membersBloc,
          builder: (context, state) {
            log(state.toString());
            if (state is MembersLoadding) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MembersFailed) {
              return const Text("Something went wrong");
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
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                separatorBuilder: (context, index) => SizedBox(height: 2.h),
                itemCount: membersData.length,
                itemBuilder: (context, index) {
                  final member = membersData[index];
                  return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                            PageResources.viewMembersScreen,
                            arguments: member,
                          ),
                      child: MemberDetailsCard(
                        membersModel: membersData[index],
                      ));
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

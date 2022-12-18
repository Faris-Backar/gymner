import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/resources/page_resources.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Members'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(PageResources.addMemberScreen),
              child: const Text('Add Members'))
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => SizedBox(height: 2.h),
        itemCount: 10,
        itemBuilder: (context, index) => const MembersCard(
          mobileNumber: '7736563740',
          name: "Faris",
          registrationNumber: "001",
        ),
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
  }) : super(key: key);
  final String name;
  final String mobileNumber;
  final String registrationNumber;

  @override
  Widget build(BuildContext context) {
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
            CircleAvatar(
              radius: 4.h,
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

import 'package:flutter/material.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> gridDetails = [
      {
        'name': 'Add Members',
        'page': PageResources.addMemberScreen,
      },
      {'name': 'View Members', 'page': PageResources.memberScreen},
      {'name': 'Fees Pending', 'page': () {}},
      {'name': 'Fees Payment', 'page': () {}},
      {'name': 'Reports', 'page': () {}},
      {'name': 'Settings', 'page': PageResources.settingsScreen},
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PowerHouse',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: gridDetails.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(gridDetails[index]['page']),
                  child: Material(
                    elevation: 5.0,
                    color: const Color(0xFF1C315E),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        gridDetails[index]['name'],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

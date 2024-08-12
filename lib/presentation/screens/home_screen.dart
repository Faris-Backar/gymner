// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gym/core/resources/page_resources.dart';
// import 'package:gym/di/di.dart';
// import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
// import 'package:gym/presentation/bloc/members/members_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> gridDetails = [
//       {
//         'name': 'Add Members',
//         'page': PageResources.addMemberScreen,
//       },
//       {'name': 'View Members', 'page': PageResources.memberScreen},
//       {'name': 'Fees Pending', 'page': PageResources.pendingFeeScreen},
//       {'name': 'Fees Payment', 'page': PageResources.feePaymentScreen},
//       {'name': 'Reports', 'page': () {}},
//       {'name': 'Settings', 'page': PageResources.settingsScreen},
//     ];
//     final feePaymentBloc = getIt<FeePaymentBloc>();
//     feePaymentBloc.add(GetRecentTransactionsEvent());
//     final membersBloc = getIt<MembersBloc>();
//     membersBloc.add(GetMembersEvent());
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'PowerHouse',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () => Navigator.of(context)
//                           .pushNamedAndRemoveUntil(
//                               PageResources.loginScreen, (route) => false),
//                       icon: const Icon(Icons.logout_rounded),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 3.h,
//                 ),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   itemCount: gridDetails.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) => InkWell(
//                     onTap: () => Navigator.of(context)
//                         .pushNamed(gridDetails[index]['page']),
//                     child: Material(
//                       elevation: 5.0,
//                       color: const Color(0xFF1C315E),
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           gridDetails[index]['name'],
//                           style: const TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Recent Transactions',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Text(
//                         'View all',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 BlocBuilder(
//                   bloc: feePaymentBloc,
//                   builder: (context, state1) {
//                     if (state1 is GetRecentTransactionsSucess) {
//                       final txData = state1.transactionList;
//                       return BlocBuilder(
//                         bloc: membersBloc,
//                         builder: (context, state2) {
//                           if (state2 is GetMembersLoaded) {
//                             log(txData.toString());
//                             final membersData = state2.membersList;
//                             if (txData.isNotEmpty) {
//                               return ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: txData.length,
//                                   itemBuilder: (context, index) {
//                                     final individualMember =
//                                         membersData.singleWhere((element) =>
//                                             element.uid ==
//                                             state1.transactionList[index]
//                                                 .memberuid);
//                                     return Card(
//                                       color: Colors.blueGrey[100],
//                                       elevation: 5.0,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(16.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               flex: 4,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     'Name : ${individualMember.name}',
//                                                   ),
//                                                   Text(
//                                                       'Date : ${DateFormat('dd-MM-yyyy').format(txData[index].feesDate)}'),
//                                                 ],
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 '\u{20B9}${txData[index].amountpayed}',
//                                                 style: TextStyle(
//                                                     fontSize: 14.sp,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   });
//                             } else {
//                               return const Center(
//                                 child: Text('No Transactions found.'),
//                               );
//                             }
//                           }
//                           return const SizedBox.shrink();
//                         },
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/constants/dashboard_constants.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/presentation/bloc/expiry_report/expiry_report_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExpiryReportBloc>(context)
        .add(const ExpiryReportEvent.getExpiryReport());
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upcoming Expiry Report",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 30.h,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: StyleResources.accentColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "01",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DashboardConstants.upcomingExpiryReport[index],
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              "Registration Report",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 30.h,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: StyleResources.accentColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "01",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DashboardConstants.registartionReport[index],
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/expiry_report/expiry_report_bloc.dart';
import 'package:gym/presentation/bloc/registration_report/registration_report_bloc.dart';
import 'package:gym/service/model/expiry_report_model.dart';
import 'package:gym/service/model/registration_report_model.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/core/constants/dashboard_constants.dart';
import 'package:gym/core/resources/style_resources.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getIt<ExpiryReportBloc>().add(const ExpiryReportEvent.getExpiryReport());
    getIt<RegistrationReportBloc>()
        .add(const RegistrationReportEvent.getRegistrationReport());
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
              child: BlocBuilder<ExpiryReportBloc, ExpiryReportState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => _buildGridView(
                      itemCount: 4,
                      builder: (context, index) => _buildGridItem(
                        context,
                        "00",
                        DashboardConstants.upcomingExpiryReport[index],
                        isLoading: false,
                      ),
                    ),
                    loading: () => _buildGridView(
                      itemCount: 4,
                      builder: (context, index) => _buildGridItem(
                        context,
                        null,
                        DashboardConstants.upcomingExpiryReport[index],
                        isLoading: true,
                      ),
                    ),
                    loaded: (expiryReport) => _buildGridView(
                      itemCount: 4,
                      builder: (context, index) => _buildGridItem(
                        context,
                        _getExpiryReportByIndex(
                                expiryReport: expiryReport, index: index)
                            .toString(),
                        DashboardConstants.upcomingExpiryReport[index],
                        isLoading: false,
                      ),
                    ),
                    failed: (error) => Center(child: Text(error)),
                  );
                },
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
              child:
                  BlocBuilder<RegistrationReportBloc, RegistrationReportState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => _buildGridView(
                      itemCount: 4,
                      builder: (context, index) => _buildGridItem(
                        context,
                        "00",
                        DashboardConstants.registartionReport[index],
                        isLoading: false,
                      ),
                    ),
                    loading: () => _buildGridView(
                      itemCount: 4,
                      builder: (context, index) => _buildGridItem(
                        context,
                        null,
                        DashboardConstants.registartionReport[index],
                        isLoading: true,
                      ),
                    ),
                    loaded: (registrationReport) => _buildGridView(
                      itemCount: 4,
                      builder: (context, index) => _buildGridItem(
                        context,
                        _getRegistrationReportByIndex(
                                registrationReport: registrationReport,
                                index: index)
                            .toString(),
                        DashboardConstants.registartionReport[index],
                        isLoading: false,
                      ),
                    ),
                    failed: (error) => Center(child: Text(error)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: StyleResources.primaryColor,
            heroTag: 'feePaymentButton', // Unique tag for fee payment button
            onPressed: () =>
                Navigator.of(context).pushNamed(PageResources.feePaymentScreen),
            child: const Icon(Icons.currency_rupee_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            backgroundColor: StyleResources.primaryColor,
            heroTag: 'addMemberButton', // Unique tag for add member button
            onPressed: () =>
                Navigator.of(context).pushNamed(PageResources.addMemberScreen),
            child: const Icon(Icons.person_add_alt_1_rounded),
          ),
        ],
      ),
    );
  }

// Method to build the GridView
  Widget _buildGridView(
      {required int itemCount, required IndexedWidgetBuilder builder}) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: builder,
    );
  }

// Method to build each grid item
  Widget _buildGridItem(BuildContext context, String? value, String subtitle,
      {required bool isLoading}) {
    return Container(
      decoration: BoxDecoration(
        color: StyleResources.accentColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Text(
                  value ?? "00",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 7.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Method to return text based on the index
  int _getExpiryReportByIndex(
      {required int index, required ExpiryReportModel expiryReport}) {
    switch (index) {
      case 0:
        return expiryReport.expiryWithinOneToThreeDays;
      case 1:
        return expiryReport.expiryWithinFourToSevenDays;
      case 2:
        return expiryReport.expiryWithinSeventoThirtyDays;
      default:
        return expiryReport.expiredActiveMembers;
    }
  }

  int _getRegistrationReportByIndex(
      {required int index,
      required RegistrationReportModel registrationReport}) {
    switch (index) {
      case 0:
        return registrationReport.totalMembers;
      case 1:
        return registrationReport.activeMembers;
      case 2:
        return registrationReport.inActiveMembers;
      default:
        return registrationReport.blockedMembers;
    }
  }
}

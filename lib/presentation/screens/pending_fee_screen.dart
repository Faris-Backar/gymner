import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/fee_pending/fee_pending_bloc.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:gym/presentation/screens/member_screen.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/model/sms_model.dart';
import 'package:lottie/lottie.dart';

class PendingFeeScreen extends StatefulWidget {
  const PendingFeeScreen({super.key});

  @override
  State<PendingFeeScreen> createState() => _PendingFeeScreenState();
}

class _PendingFeeScreenState extends State<PendingFeeScreen> {
  DateTime selectedDate = DateTime.now();
  late FeePendingBloc _pendingFeeBloc;
  List<MembersModel> feePendingMembersData = [];

  @override
  void initState() {
    super.initState();
    _pendingFeeBloc = getIt<FeePendingBloc>();
    _pendingFeeBloc.add(GetFeePendingMembersEvent(date: selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Fees Pending'),
        actions: [
          IconButton(
            onPressed: () async => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2040),
            ).then((value) {
              log('selected date =>$value');
              selectedDate = value!;
              _pendingFeeBloc
                  .add(GetFeePendingMembersEvent(date: selectedDate));
              setState(() {});
            }),
            icon: const Icon(Icons.date_range_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer(
          bloc: _pendingFeeBloc,
          listener: (context, state) {
            log(state.toString());
            if (state is FeePendingFailed) {
              getSnackBar(context, title: state.error, bgcolor: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is FeePendingLoaded) {
              if (state.pendingMembersList.isEmpty) {
                return const Center(
                  child: Text("No Pending Members found"),
                );
              }
              feePendingMembersData = state.pendingMembersList;
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: feePendingMembersData.length,
                itemBuilder: (context, index) {
                  return MembersCard(
                      name: feePendingMembersData[index].name,
                      mobileNumber:
                          feePendingMembersData[index].mobileNumber.toString(),
                      registrationNumber: feePendingMembersData[index]
                          .registerNumber
                          .toString());
                },
              );
            }
            if (state is MembersLoadding) {
              return Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: LottieBuilder.asset(AssetResources.dumbleBlue),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<SmsModel> smsToBeSent = [];
          for (var i = 0; i < feePendingMembersData.length; i++) {
            final smsData =
                SmsModel(member: feePendingMembersData[i], isSelected: true);
            smsToBeSent.add(smsData);
          }
          Navigator.of(context)
              .pushNamed(PageResources.smsScreen, arguments: smsToBeSent);
        },
        backgroundColor: StyleResources.primaryColor,
        child: const Icon(Icons.sms),
      ),
    );
  }
}

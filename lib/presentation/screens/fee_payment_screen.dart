import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:gym/service/model/package_model.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class FeePaymentScreen extends StatefulWidget {
  const FeePaymentScreen({super.key});

  @override
  State<FeePaymentScreen> createState() => _FeePaymentScreenState();
}

class _FeePaymentScreenState extends State<FeePaymentScreen> {
  final _searchController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _pendingAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double totalFees = 1000.00;
  double enteredPrice = 0.0;
  String? membersUid;
  PackageModel? packageModel;
  int? feeDuration;
  late MembersBloc _membersBloc;
  late FeePaymentBloc _feePaymentBloc;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _membersBloc = getIt<MembersBloc>();
    _feePaymentBloc = getIt<FeePaymentBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Fee Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 6.h,
                child: TextInputFormField(
                    controller: _searchController,
                    textInputType: TextInputType.number,
                    hint: 'Register Number'),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 6.h,
                    width: 40.w,
                    child: PrimaryButton(
                        label: 'Search',
                        ontap: () {
                          if (_searchController.text.isNotEmpty) {
                            _membersBloc.add(GetMembersEvent());
                            FocusScope.of(context).unfocus();
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              BlocBuilder<MembersBloc, MembersState>(
                builder: (context, state) {
                  if (state is MembersLoadding) {
                    return Center(
                      child: LottieBuilder.asset(AssetResources.dumbleBlue),
                    );
                  }
                  if (state is GetMembersLoaded) {
                    final membersData = state.membersList
                        .where((element) =>
                            element.registerNumber.toString() ==
                            _searchController.text)
                        .toList();
                    if (membersData.isNotEmpty) {
                      packageModel = membersData[0].packageModel;
                      membersUid = membersData[0].uid;
                      return Column(
                        children: [
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF08203e),
                                    Color(0xFF557c93)
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  buildDetailsRow(
                                    child: membersData[0]
                                        .registerNumber
                                        .toString(),
                                    title: 'Register Number : ',
                                  ),
                                  buildDetailsRow(
                                    child: membersData[0]
                                        .packageModel
                                        .name
                                        .toString(),
                                    title: 'Club Type : ',
                                  ),
                                  buildDetailsRow(
                                      child: membersData[0].name,
                                      title: 'Name : '),
                                  buildDetailsRow(
                                      child: membersData[0].age.toString(),
                                      title: 'Age : '),
                                  buildDetailsRow(
                                      child: membersData[0]
                                          .mobileNumber
                                          .toString(),
                                      title: 'Phone : '),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(height: 2.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 6.h,
                                  child: TextInputFormField(
                                      controller: _priceController,
                                      textInputType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      hint: 'Amount',
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() => enteredPrice =
                                              double.parse(value));
                                        } else {
                                          enteredPrice = 0.0;
                                        }
                                      }),
                                ),
                                SizedBox(height: 2.h),
                                InkWell(
                                  onTap: () => showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2040),
                                  ).then((value) {
                                    setState(() {
                                      selectedDate = value!;
                                    });
                                  }),
                                  child: Container(
                                    height: 6.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: StyleResources.secondaryColor),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    alignment: Alignment.centerLeft,
                                    child:
                                        Text(dateFormate(date: selectedDate)),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                SizedBox(
                                  height: 6.h,
                                  child: TextInputFormField(
                                    controller: _durationController,
                                    hint: 'Duration',
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  height: 6.h,
                                  child: TextInputFormField(
                                    controller: _pendingAmountController,
                                    hint: 'Pending Amount',
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Text('Pending Fees - ${getPendingFees()}'),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("No Data available"),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: membersUid != null
          ? BlocListener<FeePaymentBloc, FeePaymentState>(
              listener: (context, state) {
                if (state is FeePaymentSucess) {
                  getSnackBar(context, title: 'Successfully paid.');
                  Navigator.of(context).pop();
                }
              },
              child: BlocBuilder<MembersBloc, MembersState>(
                builder: (context, state) {
                  if (state is MembersLoadding) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PrimaryButton(
                          label: '',
                          child:
                              LottieBuilder.asset(AssetResources.dumbleWhite)),
                    );
                  }
                  if (state is GetMembersLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PrimaryButton(
                          label: 'Pay',
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              final duration =
                                  _durationController.text.isNotEmpty
                                      ? int.parse(_durationController.text)
                                      : 30;
                              var feePaymentDetails = FeesPaymentModel(
                                memberuid: membersUid!,
                                feesDate: selectedDate,
                                feesPackage: packageModel!,
                                totalDuration: duration,
                                amountpayed:
                                    double.parse(_priceController.text),
                                packageEndDate: selectedDate.add(
                                  Duration(days: duration),
                                ),
                              );
                              log('date time after => $feePaymentDetails');
                              _feePaymentBloc.add(NewFeesPaymentEvent(
                                  feesPaymentModel: feePaymentDetails));
                            }
                          }),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Row buildDetailsRow({required String title, required String child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          child,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  double getPendingFees() {
    return totalFees - enteredPrice;
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:gym/service/model/members_model.dart';

class ViewMembersScreen extends StatelessWidget {
  final MembersModel membersModel;
  const ViewMembersScreen({
    Key? key,
    required this.membersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feePaymentBloc = getIt<FeePaymentBloc>();
    feePaymentBloc
        .add(GetFeesPaymentDetailsByIdEvent(memberUid: membersModel.uid));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(membersModel.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              background: membersModel.propicUrl != null
                  ? CachedNetworkImage(imageUrl: membersModel.propicUrl!)
                  : Image.asset(
                      AssetResources.defaultImage,
                      fit: BoxFit.fill,
                    ),
              expandedTitleScale: 3,
            ),
            expandedHeight: 35.h,
            backgroundColor: StyleResources.secondaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              tooltip: 'close',
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    buildListTile(
                      label: 'Name : ',
                      labelChildString: membersModel.name,
                    ),
                    buildListTile(
                      label: 'Mobile Number : ',
                      labelChildString: membersModel.mobileNumber.toString(),
                    ),
                    buildListTile(
                      label: 'Package type : ',
                      labelChildString: membersModel.packageModel.name,
                    ),
                    buildListTile(
                      label: 'Fees Pending : ',
                      labelChildString: membersModel.age.toString(),
                    ),
                    buildListTile(
                      label: 'Age : ',
                      labelChildString: membersModel.age.toString(),
                    ),
                    buildListTile(
                      label: 'Weight : ',
                      labelChildString: membersModel.weight.toString(),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder(
                      bloc: feePaymentBloc,
                      builder: (context, state) {
                        log(state.toString());
                        if (state is FeePaymentFailed) {
                          log(state.error);
                        }
                        if (state is FeePaymentLoading) {
                          return SizedBox(
                            height: 10.h,
                            width: 60.w,
                            child:
                                LottieBuilder.asset(AssetResources.dumbleBlue),
                          );
                        }
                        if (state is GetFeePaymentDetailsSucess) {
                          return SizedBox(
                            width: 100.w,
                            child: DataTable(
                              border: TableBorder(
                                borderRadius: BorderRadius.circular(10),
                                bottom: const BorderSide(
                                    color: StyleResources.secondaryColor,
                                    width: 2),
                                horizontalInside: const BorderSide(
                                    color: StyleResources.secondaryColor,
                                    width: 1),
                                verticalInside: const BorderSide(
                                    color: StyleResources.secondaryColor,
                                    width: 1),
                                left: const BorderSide(
                                    color: StyleResources.secondaryColor,
                                    width: 2),
                                right: const BorderSide(
                                    color: StyleResources.secondaryColor,
                                    width: 2),
                                top: const BorderSide(
                                    color: StyleResources.secondaryColor,
                                    width: 2),
                              ),
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Sn',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Pending Amount',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                              rows: dataRows(
                                  feePaymentsList: state.feePaymentsList),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Row buildListTile({required String label, required String labelChildString}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        Text(
          labelChildString,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  List<DataRow> dataRows({required List<FeesPaymentModel> feePaymentsList}) {
    List<DataRow> dataRows = [];
    for (var i = 0; i < feePaymentsList.length; i++) {
      List<DataCell> cellsData = [];
      cellsData.add(DataCell(Text((i + 1).toString())));
      cellsData.add(DataCell(
          Text(DateFormat('dd-MM-yyyy').format(feePaymentsList[i].feesDate))));
      cellsData.add(DataCell(Text(feePaymentsList[i].amountpayed.toString())));
      cellsData
          .add(DataCell(Text(feePaymentsList[i].pendingAmount.toString())));

      dataRows.add(DataRow(cells: cellsData));
    }
    return dataRows;
  }
}

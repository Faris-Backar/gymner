import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/presentation/bloc/fee_package/package_cubit.dart';
import 'package:gym/presentation/widgets/default_back_button.dart';
import 'package:gym/presentation/widgets/package_card.dart';
import 'package:sizer/sizer.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PackageCubit>(context).getFeePackages();
    return Scaffold(
      appBar: AppBar(
        leading: const DefaultBackButton(),
        title: const Text('Packages'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(PageResources.createPackageScreen),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Available Packages',
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            BlocBuilder<PackageCubit, PackageState>(
              builder: (context, state) {
                log(state.toString());
                if (state is PackageLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PackageLoaded) {
                  if (state.packageList.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Center(
                        child: Text(
                          'Currently no packages avilable, Please add.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final packageData = state.packageList;
                      return PackageCard(
                          title: packageData[index].name,
                          price: packageData[index].price.toString());
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                    itemCount: state.packageList.length,
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

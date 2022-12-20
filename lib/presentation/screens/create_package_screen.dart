import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/presentation/bloc/fee_package/package_cubit.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:gym/service/model/package_model.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class CreatePackageScreen extends StatefulWidget {
  const CreatePackageScreen({super.key});

  @override
  State<CreatePackageScreen> createState() => _CreatePackageScreenState();
}

class _CreatePackageScreenState extends State<CreatePackageScreen> {
  final nameController = TextEditingController();
  final cashController = TextEditingController();
  late PackageCubit _packageCubit;
  @override
  void initState() {
    super.initState();
    _packageCubit = BlocProvider.of(context);
    _packageCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            _packageCubit.getFeePackages();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Create Package'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 6.h,
                child: TextInputFormField(
                  controller: nameController,
                  hint: 'Name',
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                height: 6.h,
                child: TextInputFormField(
                  controller: cashController,
                  hint: 'Amount',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PackageCubit, PackageState>(
          listener: (context, state) {
            log(state.toString());
            if (state is CreatePackageLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Package Created Successfully.',
                    style: TextStyle(color: Colors.white),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: StyleResources.accentColor,
                ),
              );
              Navigator.of(context).pop();
              _packageCubit.getFeePackages();
            }
          },
          builder: (context, state) {
            if (state is PackageLoaded) {
              return PrimaryButton(
                label: '',
                child: LottieBuilder.asset(AssetResources.dumbleWhite),
              );
            }
            return PrimaryButton(
              label: 'Create New Package',
              ontap: () {
                var uuid = const Uuid();
                final package = PackageModel(
                  name: nameController.text,
                  price: double.parse(cashController.text),
                  uid: uuid.v4(),
                );
                _packageCubit.createFeePackages(packageModel: package);
              },
            );
          },
        ),
      ),
    );
  }
}

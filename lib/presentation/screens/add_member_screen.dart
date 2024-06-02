// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/fee_package/package_cubit.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/model/package_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
// import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final regnumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  double progress = 0.0;
  String imageUrl = '';
  late MembersBloc _membersBloc;
  late PackageCubit _packageCubit;
  PackageModel? selectedpackages;
  String? selectedPackageValue;

  @override
  void initState() {
    super.initState();
    _membersBloc = getIt<MembersBloc>();
    _packageCubit = getIt<PackageCubit>();
    _packageCubit.getFeePackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleResources.accentColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: StyleResources.accentColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Add Members',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(PageResources.memberScreen),
            child: const Text('View Members'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 15.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: BlocBuilder(
                    bloc: _membersBloc,
                    builder: (context, state) {
                      if (state is UploadImageLoading) {
                        state.taskSnapshot.listen((event) {
                          setState(() {
                            progress = ((event.bytesTransferred.toDouble() /
                                        event.totalBytes.toDouble()) *
                                    100)
                                .roundToDouble();
                          });
                        });

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 375),
                          child: progress == 100.0
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_rounded,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Upload Complete',
                                    ),
                                  ],
                                )
                              : LiquidCircularProgressIndicator(
                                  value: progress / 100,
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.pinkAccent),
                                  backgroundColor: Colors.white,
                                  direction: Axis.vertical,
                                  center: Text(
                                    "$progress%",
                                  ),
                                ),
                        );
                      }
                      return GestureDetector(
                          onTap: () async {
                            await bottomModalSheetWidget(context);
                          },
                          child: selectedImage == null
                              ? Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black.withOpacity(.5),
                                  size: 50.sp,
                                )
                              : Container(
                                  height: 15.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(selectedImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ));
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  child: TextInputFormField(
                    controller: regnumberController,
                    hint: 'Register Number',
                    isPasswordVisible: false,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid register number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  // height: 6.h,
                  child: TextInputFormField(
                      controller: nameController,
                      hint: 'Name',
                      isPasswordVisible: false,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  child: TextInputFormField(
                      controller: mobileController,
                      hint: 'Mobile Number',
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      isPasswordVisible: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                    controller: ageController,
                    hint: 'Age',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: false,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                    controller: heightController,
                    hint: 'Height',
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: false,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                    controller: weightController,
                    hint: 'Weight',
                    isPasswordVisible: false,
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder(
                  bloc: _packageCubit,
                  builder: (context, state) {
                    if (state is PackageLoaded) {
                      final packageData = state.packageList;
                      List<String> packageDropdownItems = [];
                      for (var i = 0; i < packageData.length; i++) {
                        packageDropdownItems.add(packageData[i].name);
                      }
                      return SizedBox(
                        height: 6.h,
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: StyleResources.primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: StyleResources.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                            value: selectedPackageValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPackageValue = newValue!;
                                selectedpackages = packageData.singleWhere(
                                    (element) => element.name == newValue);
                              });
                            },
                            items: packageDropdownItems.map((String category) {
                              return DropdownMenuItem(
                                  value: category, child: Text(category));
                            }).toList()),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<MembersBloc, MembersState>(
          listener: (context, state) {
            log(state.toString());
            if (state is CreateMembersLoaded) {
              getSnackBar(context, title: 'Successfully added.');
              Navigator.of(context).pop();
            }
            if (state is UploadImageSucess) {
              final uid = getIt<Uuid>();
              final membersModel = MembersModel(
                uid: uid.v4(),
                registerNumber: int.parse(regnumberController.text),
                name: nameController.text,
                mobileNumber: int.parse(mobileController.text),
                age: ageController.text.isNotEmpty
                    ? int.parse(ageController.text)
                    : null,
                weight: weightController.text.isNotEmpty
                    ? double.parse(weightController.text)
                    : null,
                propicUrl: state.profilePicUrl,
                packageModel: selectedpackages!,
              );
              _membersBloc.add(CreateMembersEvent(membersModel: membersModel));
            }
            if (state is MembersFailed) {
              getSnackBar(context, title: state.error, bgcolor: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is MembersLoadding) {
              return PrimaryButton(
                label: '',
                child: LottieBuilder.asset(AssetResources.dumbleWhite),
              );
            }
            return PrimaryButton(
              label: 'Add Member',
              ontap: () {
                if (_formKey.currentState!.validate()) {
                  final uid = getIt<Uuid>();
                  final uidValue = uid.v4();
                  if (selectedImage != null) {
                    _membersBloc.add(UploadProfileImageEvent(
                        image: selectedImage!, uid: uidValue));
                  } else {
                    final membersModel = MembersModel(
                      uid: uidValue,
                      registerNumber: int.parse(regnumberController.text),
                      name: nameController.text,
                      mobileNumber: int.parse(mobileController.text),
                      age: ageController.text.isNotEmpty
                          ? int.parse(ageController.text)
                          : null,
                      weight: weightController.text.isNotEmpty
                          ? double.parse(weightController.text)
                          : null,
                      propicUrl: null,
                      packageModel: selectedpackages!,
                    );
                    _membersBloc
                        .add(CreateMembersEvent(membersModel: membersModel));
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }

  bottomModalSheetWidget(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16.0),
        height: 20.h,
        width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                var status = await Permission.camera.status;
                Navigator.of(ctx).pop();
                if (status.isGranted) {
                  final pickedFile = await _picker
                      .pickImage(
                        source: ImageSource.camera,
                      )
                      .whenComplete(() {});
                  final File file =
                      File(pickedFile!.path + regnumberController.text);
                  setState(() {
                    selectedImage = file;
                  });
                } else if (status.isDenied) {
                  await Permission.camera.request();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Camera Permission'),
                      content: const Text(
                          'This app needs camera access to take pictures for upload photo'),
                      actions: <Widget>[
                        MaterialButton(
                          child: const Text('Deny'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        MaterialButton(
                          child: const Text('Settings'),
                          onPressed: () {
                            openAppSettings();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: StyleResources.secondaryColor,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Take a Picture',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                var status = await Permission.camera.status;
                Navigator.of(ctx).pop();
                if (status.isGranted) {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  final File file =
                      File(pickedFile!.path + regnumberController.text);
                  setState(() {
                    selectedImage = file;
                  });
                } else if (status.isDenied) {
                  await Permission.camera.request().then((value) async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    final File file =
                        File(pickedFile!.path + regnumberController.text);
                    setState(() {
                      selectedImage = file;
                    });
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Camera Permission'),
                      content: const Text(
                          'This app needs camera access to take pictures for upload photo'),
                      actions: <Widget>[
                        MaterialButton(
                          child: const Text('Deny'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        MaterialButton(
                          child: const Text('Settings'),
                          onPressed: () => openAppSettings(),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: StyleResources.secondaryColor,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Upload From Gallery',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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

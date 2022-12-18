// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym/core/resources/page_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

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
        child: Form(
          child: Column(
            children: [
              Container(
                height: 15.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
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
                                      .getImage(source: ImageSource.camera)
                                      .whenComplete(() {});
                                  final File file = File(pickedFile!.path);
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
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
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
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                var status = await Permission.camera.status;
                                Navigator.of(ctx).pop();
                                if (status.isGranted) {
                                  final pickedFile = await _picker.getImage(
                                      source: ImageSource.gallery);
                                  final File file = File(pickedFile!.path);
                                  setState(() {
                                    selectedImage = file;
                                  });
                                } else if (status.isDenied) {
                                  await Permission.camera
                                      .request()
                                      .then((value) async {
                                    final pickedFile = await _picker.getImage(
                                        source: ImageSource.gallery);
                                    final File file = File(pickedFile!.path);
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
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
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
                        ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 6.h,
                child: TextInputFormField(
                  controller: nameController,
                  hint: 'Username',
                  isPasswordVisible: false,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 6.h,
                child: TextInputFormField(
                  controller: nameController,
                  hint: 'Mobile Number',
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
                  controller: nameController,
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
                  controller: nameController,
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
                  controller: nameController,
                  hint: 'Weight',
                  isPasswordVisible: false,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(16.0),
        child: PrimaryButton(label: 'Add Member'),
      ),
    );
  }
}

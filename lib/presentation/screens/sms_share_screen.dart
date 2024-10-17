import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:gym/presentation/widgets/primary_button.dart';

import 'package:gym/service/model/sms_model.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsShareScreen extends StatefulWidget {
  final List<SmsModel> pendingMembersList;
  const SmsShareScreen({
    super.key,
    required this.pendingMembersList,
  });

  @override
  State<SmsShareScreen> createState() => _SmsShareScreenState();
}

class _SmsShareScreenState extends State<SmsShareScreen> {
  List<SmsModel> smsTobeSend = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: widget.pendingMembersList
              .map((members) => CheckboxListTile(
                    title: Text(members.member.name),
                    value: members.isSelected,
                    onChanged: (bool? value) {
                      members.isSelected = value!;
                      if (members.isSelected == true) {
                        if (!smsTobeSend.contains(members)) {
                          smsTobeSend.add(members);
                        }
                      } else {
                        smsTobeSend.remove(members);
                      }
                      setState(() {});
                    },
                  ))
              .toList(),
        ),
      ),
      bottomNavigationBar: smsTobeSend.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                label: 'Send SMS',
                ontap: () async {
                  List<String> receipents = [];
                  for (var i = 0; i < smsTobeSend.length; i++) {
                    receipents
                        .add(smsTobeSend[i].member.mobileNumber.toString());
                  }
                  getPermission(recipents: receipents);
                },
              ),
            )
          : null,
    );
  }

  Future<void> _sendSMS({required List<String> recipents}) async {
    String message =
        "This is a remainder from POWER HOUSE GYM Pattambi. your training package validity has been expired, Please make payment inorder to continue the service.\n\nThankyou\nPOWER HOUSE ";
    // String result = await sendSMS(
    //         message: message, recipients: recipents, sendDirect: false)
    //     .catchError((onError) {
    //   if (kDebugMode) {
    //     print(onError);
    //   }
    // });
    // log(result);
    // if (result == 'SMS Sent!') {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: const Text('Successfully Send SMS'),
    //       content: const Text('Successfully send SMS to '),
    //       actions: [
    //         ElevatedButton(
    //           onPressed: () => Navigator.of(context).pop(),
    //           child: const Text('Ok'),
    //         ),
    //       ],
    //     ),
    //   );
  }
}

getPermission({required List<String> recipents}) async {
  final getsmsPermission = await Permission.sms.isDenied;
  if (getsmsPermission) {
    await Permission.sms.request().then((value) async {
      if (value.isGranted) {
        // await _sendSMS(recipents: recipents);
      }
    });
  } else if (await Permission.sms.isGranted) {
    // await _sendSMS(recipents: recipents);
    // }
  }
}

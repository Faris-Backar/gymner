import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:gym/presentation/widgets/primary_button.dart';

import 'package:gym/service/model/sms_model.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsShareScreen extends StatefulWidget {
  final List<SmsModel> pendingMembersList;
  const SmsShareScreen({
    Key? key,
    required this.pendingMembersList,
  }) : super(key: key);

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
                  label: 'Send SMS', ontap: () async => getPermission()),
            )
          : null,
    );
  }

  Future<void> _sendSMS() async {
    String message = "This is a test message!";
    List<String> recipents = ["7736563740", "8714799791"];

    String result = await sendSMS(
            message: message, recipients: recipents, sendDirect: false)
        .catchError((onError) {
      print(onError);
    });
    log(result);
    if (result == 'SMS Sent!') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Successfully Send SMS'),
          content: const Text('Successfully send SMS to '),
          actions: [ElevatedButton(onPressed: () {}, child: const Text('Ok'))],
        ),
      );
    }
  }

  getPermission() async {
    final getsmsPermission = await Permission.sms.isDenied;
    if (getsmsPermission) {
      await Permission.sms.request().then((value) async {
        if (value.isGranted) {
          await _sendSMS();
        }
      });
    } else if (await Permission.sms.isGranted) {
      await _sendSMS();
    }
  }
}

import 'package:gym/core/resources/firebase_resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/model/package_model.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'pdf_generator.dart'; // This imports the correct platform-specific file

Future<void> generateTransactionPdf(
    List<FeesPaymentModel> feesPaymentList, List<MembersModel> membersList,
    {DateTime? fromDate, DateTime? toDate}) async {
  final pdf = pw.Document();

  // Load the Malayalam font
  final ByteData fontData = await rootBundle
      .load("assets/fonts/malayalam/NotoSansMalayalam-Regular.ttf");
  final pw.Font malayalamFont = pw.Font.ttf(fontData);

  // Create a list of table rows based on the FeesPaymentModel and MembersModel data
  final dataRows = <List<String>>[];

  double totalIncome = 0.0;
  double totalExpense = 0.0;
  for (int i = 0; i < feesPaymentList.length; i++) {
    final feesPayment = feesPaymentList[i];
    MembersModel? member;
    if (feesPayment.transactionType == FirebaseResources.income) {
      // Find the member only if it's an income transaction
      member = membersList.firstWhere(
        (member) => member.uid == feesPayment.memberuid,
        orElse: () => MembersModel(
          mobileNumber: 0,
          name: "",
          packageModel: PackageModel(name: "", price: 0, uid: ""),
          registerNumber: 0,
          uid: "",
        ),
      );
    }

    // Add data row depending on the transaction type
    dataRows.add([
      (i + 1).toString(), // Sl.No
      feesPayment.transactionType, // Payment Type
      feesPayment.transactionType == FirebaseResources.income
          ? member?.registerNumber.toString() ?? '0' // Registration Number
          : '0', // Set to '0' for expense
      feesPayment.transactionType == FirebaseResources.income
          ? member?.name ?? '' // Name
          : feesPayment.expenseName ?? "", // Set to empty for expense
      feesPayment.transactionType == FirebaseResources.income
          ? member?.mobileNumber.toString() ?? '0' // Mobile Number
          : '0', // Set to '0' for expense
      feesPayment.amountpayed?.toString() ?? '0', // Amount Paid
      feesPayment.pendingAmount?.toString() ?? '0', // Pending Amount
      feesPayment.transactionType == FirebaseResources.income
          ? feesPayment.feesPackage?.name ?? '' // Name
          : feesPayment.remarks ?? "", // Remarks (fallback to package name)
    ]);

    // Calculate total income and expenses
    if (feesPayment.transactionType == 'income') {
      totalIncome += feesPayment.amountpayed ?? 0.0;
    } else if (feesPayment.transactionType == 'expense') {
      totalExpense += feesPayment.amountSpend ?? 0.0;
    }
  }

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                  'Created Date: ${dateFormate(date: DateTime.now())}',
                  style:
                      pw.TextStyle(fontSize: 12, fontFallback: [malayalamFont]),
                  textAlign: pw.TextAlign.start),
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                      'From Date: ${dateFormate(date: fromDate ?? DateTime.now())}',
                      style: pw.TextStyle(
                          fontSize: 12, fontFallback: [malayalamFont]),
                      textAlign: pw.TextAlign.start),
                  pw.Text(
                      'To Date: ${dateFormate(date: toDate ?? DateTime.now())}',
                      style: pw.TextStyle(
                          fontSize: 12, fontFallback: [malayalamFont]),
                      textAlign: pw.TextAlign.start),
                ]),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: [
                'Sl.No',
                'Payment Type',
                'Ad.No',
                'Name',
                'Mobile Number',
                'Amount Paid',
                'Pending Amount',
                'Remarks',
              ],
              data: dataRows,
              cellStyle:
                  pw.TextStyle(fontSize: 10, fontFallback: [malayalamFont]),
              headerStyle: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  fontFallback: [malayalamFont]),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
              columnWidths: {
                0: const pw.FixedColumnWidth(50),
                1: const pw.FixedColumnWidth(100),
                2: const pw.FixedColumnWidth(80),
                3: const pw.FixedColumnWidth(100),
                4: const pw.FixedColumnWidth(100),
                5: const pw.FixedColumnWidth(60),
                6: const pw.FixedColumnWidth(60),
                7: const pw.FixedColumnWidth(100),
              },
            ),
            pw.SizedBox(height: 30),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total Income: ₹${totalIncome.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontFallback: [malayalamFont])),
                pw.Text('Total Expense: ₹${totalExpense.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontFallback: [malayalamFont])),
              ],
            ),
            pw.SizedBox(height: 30),
            pw.Text('End of Report',
                style:
                    pw.TextStyle(fontSize: 16, fontFallback: [malayalamFont])),
          ],
        );
      },
    ),
  );

  // Platform-specific save
  savePdf(pdf);
}

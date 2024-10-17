import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';

Future<void> savePdf(pw.Document pdf) async {
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/transaction_report.pdf");
  await file.writeAsBytes(await pdf.save());
  await OpenFilex.open(file.path);
}

import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;

Future<void> savePdf(pw.Document pdf) async {
  final bytes = await pdf.save();
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'transaction_report.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);
}

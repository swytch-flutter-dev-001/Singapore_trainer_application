import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificatePage extends StatefulWidget {
  final String name;
  final String role;
  final String courseOrExperience;

  CertificatePage({
    required this.name,
    required this.role,
    required this.courseOrExperience,
  });

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  /// Generates and displays the PDF certificate.
  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(32),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColor.fromHex('#659F62'), width: 5),
            ),
            child: pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [

                  pw.Text(
                    'Certificate of Achievement',
                    style: pw.TextStyle(
                      fontSize: 32,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#659F62'),
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Text(
                    'This is to certify that',
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    widget.name,
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Text(
                    'has successfully completed:',
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    widget.courseOrExperience,
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 60),
                  pw.Text(
                    'Congratulations!',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#92C287'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text(
          'CERTIFICATE PAGE',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white,fontSize: 18),
        ),
        backgroundColor: Color(0xFF659F62), // Dark Green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () => _generatePdf(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF659F62), // Dark Green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              elevation: 4,
            ),
            child: Text(
              'Generate Certificate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

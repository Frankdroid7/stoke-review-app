import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final pdf = pw.Document();
  String? pdfPath;

  convertImgToPdfAndShare() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final dir = await getApplicationDocumentsDirectory();

    var bytes = await image!.readAsBytes();

    var tempFile = await File('${dir.path}/myImg').writeAsBytes(bytes);
    final imageProvider = pw.MemoryImage(File(tempFile.path).readAsBytesSync());

    pdf.addPage(pw.Page(
        build: (context) => pw.Expanded(
              child: pw.Image(imageProvider),
            )));

    var imgPdfFile = File('${dir.path}/baseImg.pdf');

    var savedPdf = await pdf.save();
    imgPdfFile.writeAsBytes(savedPdf);

    Share.shareXFiles([XFile(imgPdfFile.path)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    convertImgToPdfAndShare();
                    // getPdfBytesFromUrl(
                    //         'https://www.vuemastery.com/pdf/Vue-Essentials-Cheat-Sheet.pdf')
                    //     .then((bytes) {
                    //   storeAndSharePdf(bytes);
                    // });
                  },
                  child: const Text('Get PDF'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (pdfPath != null) {
                      sharePdfFile(pdfPath!);
                    }
                  },
                  child: const Text('Share PDF'),
                ),
              ],
            ),
            pdfPath != null
                ? Expanded(
                    child: PDFView(
                      filePath: pdfPath,
                      autoSpacing: false,
                      onError: (error) {
                        print(error.toString());
                      },
                      onPageError: (page, error) {
                        print('$page: ${error.toString()}');
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Future storeAndSharePdf(Uint8List bytes) async {
    const filename = 'VueJs CheatSheet';
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename.pdf');
    await file.writeAsBytes(bytes);
    setState(() {
      pdfPath = file.path;
    });
  }

  Future<Uint8List> getPdfBytesFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    Uint8List bytes = response.bodyBytes;

    return bytes;
  }

  sharePdfFile(String pdfPath) {
    Share.shareXFiles([XFile(pdfPath)]);
  }
}

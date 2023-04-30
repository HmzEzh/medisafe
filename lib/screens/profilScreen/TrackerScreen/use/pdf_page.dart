import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medisafe/screens/profilScreen/TrackerScreen/use/util.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPage1 extends StatefulWidget {
  const PdfPage1({Key? key}) : super(key: key);

  @override
  State<PdfPage1> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage1> {

  PrintingInfo? printingInfo;

  @override
  void initState(){
    super.initState();
    _init();
  }

  Future<void> _init() async{
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug =true;
    final actions = <PdfPreviewAction>[
      if(!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveAsFile)
    ];
    return Scaffold(
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build:generatePdf,
      ),
    );
  }
}

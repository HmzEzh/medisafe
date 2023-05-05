

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:medisafe/models/Mesure.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../helpers/DatabaseHelper.dart';
import '../../../../models/Rappel.dart';



Future<Uint8List>generatePdf(final PdfPageFormat format)async{
DatabaseHelper trackerservice = DatabaseHelper.instance;
Rappel rap = Rappel();
  final doc = pw.Document(
    title: 'Flutter School',
  );
final bytes = await rootBundle.load('assets/images/cardiogram.png');
final image = pw.MemoryImage(bytes.buffer.asUint8List());

  final font = await rootBundle.load('assets/OpenSansRegular.ttf');
  final ttf = pw.Font.ttf(font);

  List<MyObject> myObjects = [];
  List<Mesure> mesures = await trackerservice.getMesuresByIdTracker(rap.idTracker);

  for (Mesure mesure in mesures) {
    myObjects.add(MyObject(column1: mesure.date, column2: mesure.value));
  }

List<double> myts = [];

for (Mesure mesure in mesures) {
  myts.add(double.parse(mesure.value));
}

  var unit ;
  rap.type == "tension"? unit="mmHg":unit="mg/dl";

  final pageTheme = await _myPageTheme(format);
  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      header: (pw.Context context) {
        return pw.Container(
          width: 100,
          height: 100,
          decoration: pw.BoxDecoration(
            image: pw.DecorationImage(
              image: image,
              fit: pw.BoxFit.scaleDown,
            ),
          ),
        );
      },
      build: (final context)=>[
        // the main content of pdf
        pw.Container(
          padding: const pw.EdgeInsets.only(left: 30,bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text("Nom patient:"),
                        pw.Text("date de naissance:"),
                        pw.Text("Télephone:"),
                      ]
                    ),
                    pw.SizedBox(width: 70),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(rap.nomUtilisateur),
                        pw.Text(rap.dateNaissance),
                        pw.Text(rap.telephone),
                      ]
                    ),
                    pw.SizedBox(width: 70),
                    // pw.BarcodeWidget(
                    //     data:'youssef',
                    // width: 40,
                    // height: 40,
                    // barcode: pw.Barcode.qrCode(),
                    // drawText: false
                    // ),
                    pw.Padding(padding: pw.EdgeInsets.zero),
                  ]
              )
            ]
          )
        ),
        pw.Center(
          child: pw.Text(
            'Rapport d\'un Tracker',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              font:ttf,
              fontSize: 30,
              fontWeight: pw.FontWeight.bold
            )
          )
        ),
        pw.SizedBox(height: 10),
        // pw.Align(
        //   alignment: pw.Alignment.centerLeft,
        //   child:
        // )
        pw.Center(
          
          child: pw.Container(
            padding:pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(
                begin: pw.Alignment.topCenter,
                end: pw.Alignment.bottomCenter,
                colors: [PdfColors.white,PdfColors.white],
              ),
            ),
            width: 440,
            height: 150,
            child:BarChart(data: myts),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Center(
            child: pw.Text(
                'Les mesures',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font:ttf,
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold
                )
            )
        ),
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Container(
            child: pw.Table(
              border: pw.TableBorder.all(width: 1,color: PdfColors.black),
              children: [
                pw.TableRow(children: [
                pw.Center(heightFactor: 2,child:pw.Text('Date', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Center(heightFactor: 2,child:pw.Text('Valeur', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                ]),
                ...myObjects.map((object) {
                  return pw.TableRow(children: [
                    pw.Center(child:pw.Text(object.column1)),
                    pw.Center(child:pw.Text('${object.column2}  ${unit}')),
                  ]);
                }).toList(),
              ],
            ),

          )
        )

      ]
    )
  );

  return doc.save();


}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async{
  final logoImage =pw.MemoryImage((await rootBundle.load('assets/images/medine.png')).buffer.asUint8List());
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 0.5*PdfPageFormat.cm,vertical: 0.5*PdfPageFormat.cm
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context)=> pw.FullPage(
      ignoreMargins: true,
      child: pw.Watermark(
        angle: 20,
        child: pw.Opacity(
          opacity: 0.2,
          child: pw.Image(
            alignment: pw.Alignment.center,
            logoImage,
            fit: pw.BoxFit.cover
          )
        )
      )
    )
  );
}


Future<void> saveAsFile(
final BuildContext conext,
final LayoutCallback build,
final PdfPageFormat pageFormat,
)async{
  final bytes = await build(pageFormat);
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print("save at ${file.path}");
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);


}

void showPrintedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Document printed successfully")));
}

void showSharedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Document shared successfully")));
}


class UrlText extends pw.StatelessWidget{
  final String text;
  final String url;
  UrlText(this.text,this.url);

  @override
  pw.Widget build(pw.Context context) => pw.UrlLink(
    destination: url,
    child: pw.Text(
      text,
      style: const pw.TextStyle(
        decoration: pw.TextDecoration.underline,
        color: PdfColors.blue
      )
    )
  );
}



class BarChart extends pw.StatelessWidget {
  final List<double> data;
  final double barWidth;
  final double maxBarHeight;
  final double axisLineWidth;
  final double axisLabelFontSize;

  BarChart({
    required this.data,
    this.barWidth = 10.0,
    this.maxBarHeight = 100.0,
    this.axisLineWidth = 1.0,
    this.axisLabelFontSize = 10.0,
  });

  @override
  pw.Widget build(pw.Context context) {
    final bars = List<pw.Widget>.generate(
      data.length,
          (i) => pw.Container(
        width: barWidth,
        height: data[i] / maxBarHeight * 100.0,
        decoration: const pw.BoxDecoration(
          color: PdfColors.grey,
          border: pw.Border(
            bottom: pw.BorderSide(
              color: PdfColors.black,
              width: 0.0,
            ),
          ),
        ),
      ),
    );
    final List<pw.Widget> yAxisLabels = List<pw.Widget>.generate(
      4,
          (i) => pw.Text('${i * 70}'),
    ).toList().reversed.toList();


    final List<pw.Widget> xAxisLabels = List<pw.Widget>.generate(
      data.length,
          (i) => pw.Text('${i + 1}'),
    );

    final verticalAxis = pw.Container(
      height: maxBarHeight + axisLineWidth,
      width: axisLineWidth,
      decoration: const pw.BoxDecoration(
        color: PdfColors.black,
      ),
    );

    final horizontalAxis = pw.Container(
      height: axisLineWidth,
      width: data.length * barWidth,
      decoration: const pw.BoxDecoration(
        color: PdfColors.black,
      ),
    );

    return pw.Stack(
      children: [
        pw.Row(
          children: bars,
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
        ),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: yAxisLabels,
        ),
        pw.Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: verticalAxis,
        ),

        pw.Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: horizontalAxis,
        ),
        pw.Positioned(
          bottom: -axisLabelFontSize - 2,
          left: 0,
          child: pw.Text(
            "X Axis Label",
            style: pw.TextStyle(fontSize: axisLabelFontSize),
          ),
        ),
        pw.Positioned(
          top: -axisLabelFontSize - 2,
          left: -maxBarHeight - 2,
          child: pw.Transform.rotate(
            angle: -90,
            child: pw.Text(
              "Y Axis Label",
              style: pw.TextStyle(fontSize: axisLabelFontSize),
            ),
          ),
        ),
      ],
    );
  }
}



class MyObject {
  final String column1;
  final String column2;

  MyObject({required this.column1, required this.column2});
}



Future<Uint8List>sendToDoctor(final PdfPageFormat format, String email, int idTracker, String unitType)async{
  DatabaseHelper trackerservice = DatabaseHelper.instance;
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  if (await file.exists()) {
    await file.delete();
    print('File deleted successfully');
  } else {
    print('File does not exist');
  }
  final doc = pw.Document(
    title: 'Flutter School',
  );
  final byt = await rootBundle.load('assets/images/cardiogram.png');
  final image = pw.MemoryImage(byt.buffer.asUint8List());
  final font = await rootBundle.load('assets/OpenSansRegular.ttf');
  final ttf = pw.Font.ttf(font);


  List<MyObject> myObjects = [];
  List<Mesure> mesures = await trackerservice.getMesuresByIdTracker(idTracker);

  for (Mesure mesure in mesures) {
    myObjects.add(MyObject(column1: mesure.date, column2: mesure.value));
  }

  List<double> myts = [];

  for (Mesure mesure in mesures) {
    myts.add(double.parse(mesure.value));
  }
  Rappel rap = Rappel();
  var unit ;
  unitType == "tension"? unit="mmHg":unit="mg/dl";
  final pageTheme = await _myPageTheme(format);
  doc.addPage(
      pw.MultiPage(
          pageTheme: pageTheme,
          header: (pw.Context context) {
            return pw.Container(
              width: 100,
              height: 100,
              decoration: pw.BoxDecoration(
                image: pw.DecorationImage(
                  image: image,
                  fit: pw.BoxFit.scaleDown,
                ),
              ),
            );
          },
          build: (final context)=>[
            // the main content of pdf
            pw.Container(
                padding: const pw.EdgeInsets.only(left: 30,bottom: 20),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  pw.Text("Nom patient:"),
                                  pw.Text("date de naissance:"),
                                  pw.Text("Télephone:"),
                                ]
                            ),
                            pw.SizedBox(width: 70),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(rap.nomUtilisateur),
                                  pw.Text(rap.dateNaissance),
                                  pw.Text(rap.telephone),
                                ]
                            ),
                            pw.SizedBox(width: 70),
                            // pw.BarcodeWidget(
                            //     data:'youssef',
                            //     width: 40,
                            //     height: 40,
                            //     barcode: pw.Barcode.qrCode(),
                            //     drawText: false
                            // ),
                            pw.Padding(padding: pw.EdgeInsets.zero),
                          ]
                      )
                    ]
                )
            ),
            pw.Center(
                child: pw.Text(
                    'Rapport d\'un Tracker',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font:ttf,
                        fontSize: 30,
                        fontWeight: pw.FontWeight.bold
                    )
                )
            ),
            pw.SizedBox(height: 10),
            // pw.Align(
            //   alignment: pw.Alignment.centerLeft,
            //   child:
            // )
            pw.Center(

              child: pw.Container(
                padding:pw.EdgeInsets.all(2),
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    begin: pw.Alignment.topCenter,
                    end: pw.Alignment.bottomCenter,
                    colors: [PdfColors.white,PdfColors.white],
                  ),
                ),
                width: 440,
                height: 150,
                child:BarChart(data: myts),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Center(
                child: pw.Text(
                    'Les mesures',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font:ttf,
                        fontSize: 30,
                        fontWeight: pw.FontWeight.bold
                    )
                )
            ),
            pw.SizedBox(height: 10),
            pw.Center(
                child: pw.Container(
                  child: pw.Table(
                    border: pw.TableBorder.all(width: 1,color: PdfColors.black),
                    children: [
                      pw.TableRow(children: [
                        pw.Center(child:pw.Text('Date', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                        pw.Center(child:pw.Text('Valeur', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      ]),
                      ...myObjects.map((object) {
                        return pw.TableRow(children: [
                          pw.Center(child:pw.Text(object.column1)),
                        pw.Center(child:pw.Text('${object.column2}  ${unit}')),
                        ]);
                      }).toList(),
                    ],
                  ),

                )
            )

          ]
      )
  );

  final h = await doc.save();
  final bytes = h.toList();
  print("save at ${file.path}");
  await file.writeAsBytes(bytes);
  //await OpenFile.open(file.path);

  sendEmail(String em) async {
    final String base64Pdf = base64Encode(bytes);
    final Email email = Email(
      body: 'Please find attached PDF document.',
      subject: 'PDF document',
      recipients: [em],
      attachmentPaths: [
        '${file.path}' // This method returns the path of your PDF file
      ],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  sendEmail(email);

  return doc.save();


}

import 'dart:io';
import 'package:medisafe/models/raport.dart';
import 'package:medisafe/service/raportService/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../utils/utils.dart';

class PdfReportApi {
  static Future<File> generate(DateTime dateDebut , DateTime dateFin ,List<Raport> raport) async {

    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(dateDebut,dateFin),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildInvoice(raport),
        Divider(),
       
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: 'raport.pdf', pdf: pdf,dateDebut: dateDebut,dateFin: dateFin);
  }

  static Widget buildHeader(DateTime dateDebut , DateTime dateFin) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInvoiceInfo(dateDebut,dateFin),
             
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: "https://www.ensaj.ucd.ac.ma",
                ),
              ),
              
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ]
      );

  

  static Widget buildInvoiceInfo(DateTime dateDebut , DateTime dateFin) {
    final nbrJours = '${dateFin.difference(dateDebut).inDays} jours';
    final titles = <String>[
      'Date de debut:',
      'Date de fin:',
      'nombre du joures:',
     
    ];
    final data = <String>[
      Utils.formatDate2(dateDebut),
      Utils.formatDate2(dateFin),
      nbrJours,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];
        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

 

  

  static Widget buildInvoice(List<Raport> raport) {
    final headers = [
      'Nom',
      'Enregistré le',
      'Prévu pour',
      'Valeur',
      'Remarques'
    ];
    final data = raport.map((item) {
      
      return [
        item.name,
        item.datePrevu.split(" ")[0] +" "+item.dateEnrg,
        item.datePrevu,
        item.valeur,
        item.remarque,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      cellPadding :  EdgeInsets.zero,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
      },
    );
  }



  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          //TODO:
          buildSimpleText(title: 'Address', value: "Route d'Azemmour, Nationale N°1, ELHAOUZIA "),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Tel', value: "(+212) 5 23 34 48 22"),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}

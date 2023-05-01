import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:medisafe/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({required String name,required Document pdf,required DateTime dateDebut , required DateTime dateFin}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    print(file.path);
    final Email email = Email(
      body: '''
      Rapport d'état des médicaments 
      | ${Utils.formatDate2(dateDebut)} - ${Utils.formatDate2(dateFin)} 

      Veuillez trouver en pièce jointe le rapport d'état de votre médicaments . 
     ''',
      subject: "Rapport du statut médical",
      recipients: ['hamzaezzahi177@gmail.com'],
     
      attachmentPaths: [file.path],
      isHTML: false,);
    await FlutterEmailSender.send(email);
    return file;
  }

}

import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:medisafe/helpers/DatabaseHelper.dart';
import 'package:medisafe/models/Rappel.dart';

class MyEncryptionDecryption{

  //static DatabaseHelper passwordController = DatabaseHelper.instance;
  Rappel rap = Rappel();
  static String passe ="";

  static final key = Key.fromUtf8(sha256.convert(utf8.encode(passe)).toString().substring(0, 32));
  //encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  MyEncryptionDecryption(){
    passe =rap.motDePasse;
  }

  static encryptAES(text) {
    print("the password is ${passe}");
    final encrypted = encrypter.encrypt(text,iv:iv);
    // print(encrypted.bytes);
    // print(encrypted.base16);
    // print(encrypted.base64);
    // print("password=${passe}");
    return encrypted;
  }

  static decryptAES(String text) {
      return encrypter.decrypt(Encrypted.fromBase64(text),iv:iv);
  }
}
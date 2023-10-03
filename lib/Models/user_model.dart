import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';

class UserModel {
  String code;
  String numero;
  String prenom;
  String nom;
  String email;
  String password;
  String pin;
  String formeJuridique;
  String raisonSocial;
  String matriculeFiscale;
  String adresse;
  String siteWeb;
  String activites;
  String image1;
  String image2;
  String image3;
  String image4;
  String deviceId;
  String hash;

  UserModel({
    required this.numero,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.password,
    required this.pin,
    required this.formeJuridique,
    required this.raisonSocial,
    required this.matriculeFiscale,
    required this.adresse,
    required this.siteWeb,
    required this.activites,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.deviceId,
    required this.hash,
    required this.code,
  });

  Future<FormData> Register() async {
    /* var formData = FormData.fromMap({
      'username': numero,
      'first_name': prenom,
      'last_name': nom,
      'email': email,
      'password': password,
      'code': code,
      'hash': hash,
      'pin': pin,
      'address': adresse,
      'website': siteWeb,
      'activity': activites,
      'legal_status': formeJuridique,
      'fiscal_id': matriculeFiscale,
      'company': raisonSocial,
      'device_token': deviceId,
    });
 */
    var formData = FormData();
    var fields = {
      'username': numero,
      'first_name': prenom,
      'last_name': nom,
      'email': email,
      'password': password,
      'code': code,
      'hash': hash,
      'pin': pin,
      'address': adresse,
      'website': siteWeb,
      'activity': activites,
      'legal_status': formeJuridique,
      'fiscal_id': matriculeFiscale,
      'company': raisonSocial,
      'device_token': deviceId,
      'cin_img_recto': image1,
      'cin_img_verso': image2,
      'business_number': image3,
      'business_tax': image4
    };
    var fieldEntries = fields.entries.map((entry) {
      return MapEntry(entry.key, entry.value);
    });

    formData.fields.addAll(fieldEntries);

    /* Future<MultipartFile> checkFile(String path) async {
      if (path.isEmpty) {
        return '';
      }

      return MultipartFile.fromFile(path,
          filename: path, contentType: MediaType('image', 'jpg'));
    } */

    image1.isEmpty
        ? null
        : formData.files.add(MapEntry(
            'cin_img_recto',
            await MultipartFile.fromFile(image1,
                filename: 'cinRecto', contentType: MediaType('image', 'jpg'))));
    image2.isEmpty
        ? null
        : formData.files.add(MapEntry(
            'cin_img_verso',
            await MultipartFile.fromFile(image2,
                filename: 'cinVerso', contentType: MediaType('image', 'jpg'))));
    image3.isEmpty
        ? null
        : formData.files.add(MapEntry(
            'business_number',
            await MultipartFile.fromFile(image3,
                filename: 'businessNumber',
                contentType: MediaType('image', 'jpg'))));
    image4.isEmpty
        ? null
        : formData.files.add(MapEntry(
            'business_tax',
            await MultipartFile.fromFile(image4,
                filename: 'businessTax',
                contentType: MediaType('image', 'jpg'))));

    return formData;
  }
}

import 'package:QRScanner/models/actualite.dart';
import 'package:http/http.dart' as http;

Future<List<Actualite>> fetchActualite() async {
  String url = "http://192.168.1.87/iacomappiuapp/actualites.php";
  final response = await http.get(url);
  return actualiteFromJson(response.body);
}
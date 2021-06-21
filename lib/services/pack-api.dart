import 'package:QRScanner/models/pack.dart';
import 'package:http/http.dart' as http;

Future<List<Pack>> fetchPack() async {
  String url = "http://192.168.1.87/iacomappiuapp/packs.php";
  final response = await http.get(url);
  return packFromJson(response.body);
}
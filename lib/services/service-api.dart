import 'package:QRScanner/models/service.dart';
import 'package:http/http.dart' as http;

Future<List<Service>> fetchService() async {
  String url = "http://192.168.1.87/iacomappiuapp/services.php";
  final response = await http.get(url);
  return serviceFromJson(response.body);
}
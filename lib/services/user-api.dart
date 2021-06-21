import 'package:QRScanner/models/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUser() async {
  String url = "http://192.168.1.110/iacomappiuapp/user.php";
  final response = await http.get(url);
  return userFromJson(response.body);
}
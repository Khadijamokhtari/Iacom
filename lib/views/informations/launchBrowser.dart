import 'package:url_launcher/url_launcher.dart';

Future<void> launchBrowser(String url) async{
  if(await canLaunch(url)) {
    await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'});
  }
  else{
    throw "Nous ne pouvons pas ouvrir l'$url";
  }
}

Future<void> makeCall(String url) async{
  if(await canLaunch(url)) {
    await launch(url);}
    else{
    throw "Nous ne pouvons pas passer l'appel au $url";
  }
}

Future<void> makeMail(String url) async{
  if(await canLaunch(url)) {
    await launch(url);}
  else{
    throw "Nous ne pouvons pas écrire de mail à l'dresse $url";
  }
}
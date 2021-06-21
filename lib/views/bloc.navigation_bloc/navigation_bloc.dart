import 'package:bloc/bloc.dart';
import 'package:QRScanner/views/body.dart';
import 'package:QRScanner/views/sidebar_content/pack_screen.dart';
import 'package:QRScanner/views/sidebar_content/service_screen.dart';
import 'package:QRScanner/views/sidebar_content/actualite_screen.dart';
import 'package:QRScanner/views/Contact.dart';
import 'package:QRScanner/views/sidebar_content/login/login.dart';

enum NavigationEvents {
  BodyClickedEvent,
  ServiceListScreenClickedEvent,
  PackListScreenClickedEvent,
  ActualiteListScreenClickedEvent,
  ContactClickedEvent,
  LoginClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Body();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.BodyClickedEvent:
        yield Body();
        break;
      case NavigationEvents.ServiceListScreenClickedEvent:
        yield ServiceScreen();
        break;
      case NavigationEvents.PackListScreenClickedEvent:
        yield PackScreen();
        break;
      case NavigationEvents.ActualiteListScreenClickedEvent:
        yield ActualiteListScreen();
        break;
      case NavigationEvents.ContactClickedEvent:
        yield Contact();
        break;
      case NavigationEvents.LoginClickedEvent:
        yield
        RegisterLogin();
        break;
    }
  }
}

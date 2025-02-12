import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@singleton
@injectable
 class InternetConnectionCheck {
  getInstance() {
    final connectionChecker = InternetConnectionChecker.instance;
    return connectionChecker;
  }
}

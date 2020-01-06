import 'package:get_it/get_it.dart';
import 'package:uas/src/services/callmsgservice.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerSingleton(CallMsgService());
}
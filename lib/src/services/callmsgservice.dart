import 'package:url_launcher/url_launcher.dart';

class CallMsgService {
  void call(String number) => launch("tel://$number");
  void msg(String number) => launch("sms:$number");
  void mail(String email) => launch("mailto:$email");
  void maps(String maps) => launch("$maps");
}
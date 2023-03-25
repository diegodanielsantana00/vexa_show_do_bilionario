import 'package:url_launcher/url_launcher.dart';

class ViewsController {
  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

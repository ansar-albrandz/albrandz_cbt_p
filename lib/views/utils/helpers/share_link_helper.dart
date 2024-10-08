import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareLinkHelper {
  static shareLink(String link) => Share.share(link);
  static shareLinkWithTitle(String link,String title) => Share.share("$title \n$link");

  static launchNormalUrl(String url)async{
    if(await launchUrl(Uri.parse(url))){
      throw Exception("Cann't launch $url");
    }
  }

  static void makePhoneCall(String countryCode,String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: "$countryCode$phoneNumber");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

}
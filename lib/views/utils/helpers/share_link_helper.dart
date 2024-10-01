import 'package:share_plus/share_plus.dart';

class ShareLinkHelper {
  static shareLink(String link) => Share.share(link);
  static shareLinkWithTitle(String link,String title) => Share.share("$title \n$link");

}
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(context, String? url) async {
  if (url != null) {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cannot launch this $url')));
    }
  }
}

Future<void> launchDialer(String phoneNumber) async {
  final Uri url = Uri.parse("tel:$phoneNumber");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw "تعذر فتح تطبيق الاتصال";
  }
}

  // void _launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'تعذر فتح الرابط: $url';
  //   }
  // }

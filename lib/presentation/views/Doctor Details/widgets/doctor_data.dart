import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorData extends StatelessWidget {
  final String? fname;
  final String? lname;
  final String? title;
  final List<Specialization>? specialization;
  final String? image;
  final String? phone;
  final String? facebookLink;
  final String? whatsappLink;

  DoctorData({
    required this.fname,
    required this.lname,
    required this.title,
    required this.specialization,
    required this.image,
    required this.phone,
    required this.facebookLink,
    required this.whatsappLink,
    super.key,
  });
  void _launchURL(String url) async {
    Uri uri = Uri.parse(Uri.encodeFull(url));

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("❌ Could not launch $url");
    }
  }

  void makeCall(String phoneNumber) async {
    var status = await Permission.phone.status;

    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      String telUri = 'tel:$phoneNumber'; // Removed +2 to avoid issues
      _launchURL(telUri);
    } else {
      print("❌ Permission Denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15.w),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: image!.isNotEmpty
                        ? NetworkImage(image ?? '')
                        : const AssetImage('assets/images/doctor.jpg')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'دكتور $fname $lname',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      title ?? '',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'دكتور متخصص في ${specialization?[0].title}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Ensures even spacing
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook,
                    color: Color(0xff0866FF)),
                onPressed: () {
                  if (facebookLink != null && facebookLink!.isNotEmpty) {
                    _launchURL(facebookLink!);
                  } else {
                    print("Facebook link is empty");
                  }
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.whatsapp,
                    color: Color(0xff25D366)),
                onPressed: () {
                  if (whatsappLink != null && whatsappLink!.isNotEmpty) {
                    _launchURL(whatsappLink!);
                  } else {
                    print("❌ WhatsApp link is empty");
                  }
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.phone,
                    color: Color(0xff0DCAF0)),
                onPressed: () {
                  if (phone != null && phone!.isNotEmpty) {
                    makeCall(phone!);
                  } else {
                    print("❌ Phone number is empty");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

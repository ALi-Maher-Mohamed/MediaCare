import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_images.dart';
import 'custom_intro_page.dart';
import 'custom_bottom_sheet.dart';
import 'custom_lets_go_button.dart';

class IntroViewBody extends StatefulWidget {
  const IntroViewBody({super.key});

  @override
  State<IntroViewBody> createState() => _IntroViewBodyState();
}

final controller = PageController();
bool isLastPage = false;

List<CustomIntroPage> intros = [
  CustomIntroPage(
      image: Assets.imagesDoctors,
      title: '! صحتك تبدأ هنا',
      subTitle: ' . استكشف مجموعة متكاملة من الخدمات الطبية بسهولة وسرعة'),
  CustomIntroPage(
      image: Assets.imagesApointment,
      title: '! احجز موعدك بضفطة زر',
      subTitle: ' . ابحث عن الاطباء المتخصصين واحجز موعدك في ثوانٍ'),
  CustomIntroPage(
      image: Assets.imagesArticals,
      title: ' ! معلومات  طبية في أي وقت',
      subTitle: ' . احصل على استشارات طبية موثوقة مباشرة عبر التطبيق'),
  CustomIntroPage(
      image: Assets.imagesLabs,
      title: '! الرعاية الصحية أصبحت أسهل',
      subTitle: ' . استمتع بتجربة طبية مريحة ومناسبة لجميع احتياجاتك'),
];

class _IntroViewBodyState extends State<IntroViewBody> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(360, 690), // Standard design size for responsiveness
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(bottom: 50.h), // Responsive padding
            child: PageView(
              onPageChanged: (index) => setState(() {
                isLastPage = index == intros.length - 1;
              }),
              controller: controller,
              children: intros,
            ),
          ),
          bottomSheet: isLastPage
              ? const CustomLetsGoButton()
              : CustomButomSheet(controller: controller, intros: intros),
        );
      },
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/profile/data/models/profile_model.dart';
import 'package:media_care/presentation/views/profile/data/repo/profile_repo_impl.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import 'package:media_care/presentation/views/profile/manager/profile_state.dart';
import 'package:media_care/presentation/views/profile/widgets/avatar_and_name.dart';
import 'package:media_care/presentation/views/profile/widgets/field_data.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        profileRepo: ProfileRepoImpl(ApiServiceFunctions(Dio())),
      )..fetchProfile(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('حسابي',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          backgroundColor: Color(0xFF0D47A1), // أزرق داكن أنيق
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {}, // إضافة وظيفة التعديل لاحقاً
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D47A1),
                Color(0xFFE3F2FD),
              ],
            ),
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileInitial) {
                return _buildLoadingState(context);
              } else if (state is ProfileLoading) {
                return _buildLoadingState(context);
              } else if (state is ProfileLoaded) {
                return _buildProfileContent(context, state.user);
              }
              return _buildLoginPrompt(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 20),
          AvatarAndName(
            name: user.name!,
            image: user.avatar ??
                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
          ),
          SizedBox(height: 30),
          _buildProfileCard(context, user),
          SizedBox(height: 20),
          _buildPointsCard(context, user.points!.toString()),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, UserModel user) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FieldData(
              title: 'البريد الإلكتروني',
              data: user.email!,
              icon: Icons.email_outlined,
            ),
            Divider(height: 30, thickness: 0.5),
            FieldData(
              title: 'رقم الهاتف',
              data: user.phone ?? 'غير محدد',
              icon: Icons.phone_android_outlined,
            ),
            Divider(height: 30, thickness: 0.5),
            FieldData(
              title: 'العنوان',
              data: user.address!,
              icon: Icons.location_on_outlined,
            ),
            Divider(height: 30, thickness: 0.5),
            FieldData(
              title: 'تاريخ الميلاد',
              data: user.birthDate!,
              icon: Icons.cake_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(BuildContext context, String points) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xFFE8F5E9), // أخضر فاتح
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Color(0xFF2E7D32)), // أخضر داكن
                SizedBox(width: 10),
                Text('النقاط',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    )),
              ],
            ),
            Text(points,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 80, color: Colors.white70),
            SizedBox(height: 20),
            Text('برجاء تسجيل الدخول لرؤية حسابك',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: Text('سجل دخول الآن',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}

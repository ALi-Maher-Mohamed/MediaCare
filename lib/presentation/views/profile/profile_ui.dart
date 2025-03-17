// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:media_care/core/Secure%20Storage/secure_storage.dart';
// import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import 'package:media_care/presentation/views/profile/manager/profile_state.dart';
import 'package:media_care/presentation/views/profile/widgets/avatar_and_name.dart';
import 'package:media_care/presentation/views/profile/widgets/field_data.dart';
// import 'data/repo/profile_repo_impl.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        title: Text('حسابي'),
        titleSpacing: -15,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        backgroundColor: AppColors.primaryLight,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
            return Center(child: Text('Initial state'));
          } else if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.user;
            return Column(
              children: [
                AvatarAndName(
                  name: user.name,
                  image: user.avatar ??
                      "https://cdn.pixabay.com/photo/2017/07/18/23/23/user-2517430_1280.png",
                ),
                const SizedBox(height: 15),
                FieldData(title: 'البريد الإلكتروني', data: user.email),
                FieldData(title: 'رقم الهاتف', data: user.phone),
                FieldData(title: 'العنوان', data: user.address),
                FieldData(title: 'تاريخ الميلاد', data: user.birthDate),
              ],
            );
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
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
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          title: Text('حسابي'),
          titleSpacing: -15,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              return Center(
                  child: Text('Initial state',
                      style: Theme.of(context).textTheme.bodyMedium));
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
            return Center(
                child: Text('Unexpected state',
                    style: Theme.of(context).textTheme.bodyMedium));
          },
        ),
      ),
    );
  }
}

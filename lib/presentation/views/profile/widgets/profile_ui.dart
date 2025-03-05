import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/profile_cubit.dart';
import '../manager/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
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
            return Center(child: Text('User: ${state.user.name}'));
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}

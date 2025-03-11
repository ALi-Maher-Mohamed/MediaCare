import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoadingState extends BlogState {}

class BlogSuccessState extends BlogState {
  final List<Blog> blogs;
  BlogSuccessState(this.blogs);
}

class BlogErrorState extends BlogState {
  final String message;
  BlogErrorState(this.message);
}

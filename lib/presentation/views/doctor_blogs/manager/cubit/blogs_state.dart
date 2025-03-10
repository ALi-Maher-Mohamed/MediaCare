import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  BlogLoaded(this.blogs);
}

class BlogError extends BlogState {
  final String message;
  BlogError(this.message);
}

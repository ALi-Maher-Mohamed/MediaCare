import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_state.dart';

class DoctorBlogsCubit extends Cubit<BlogState> {
  final BlogsRepo _blogsRepo;

  DoctorBlogsCubit(this._blogsRepo) : super(BlogInitial());

  Future<void> fetchBlogs() async {
    emit(BlogLoading());
    try {
      final blogResponse = await _blogsRepo.fetchBlogs();
      emit(BlogLoaded(blogResponse.data.blogs));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }
}

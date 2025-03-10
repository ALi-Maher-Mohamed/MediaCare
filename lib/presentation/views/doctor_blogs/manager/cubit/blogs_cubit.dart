import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:media_care/core/errors/failure.dart'; // تأكد من تعديل المسار حسب مكان Failure
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_state.dart';

class DoctorBlogsCubit extends Cubit<BlogState> {
  final BlogsRepo _blogsRepo;

  DoctorBlogsCubit(this._blogsRepo) : super(BlogInitial());

  Future<void> fetchBlogs() async {
    emit(BlogLoading());

    final result = await _blogsRepo.fetchBlogs();
    result.fold(
      (failure) =>
          emit(BlogError(failure.errMessage)), // نستخدم errMessage من Failure
      (blogResponse) => emit(BlogLoaded(blogResponse.data.blogs)),
    );
  }
}

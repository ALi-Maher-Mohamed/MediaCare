import 'package:bloc/bloc.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_state.dart';

class DoctorBlogsCubit extends Cubit<BlogState> {
  final BlogsRepo _blogsRepo;

  DoctorBlogsCubit(this._blogsRepo) : super(BlogInitial());

  Future<void> fetchBlogs() async {
    emit(BlogLoadingState());

    final result = await _blogsRepo.fetchBlogs();
    result.fold(
      (failure) => emit(
          BlogErrorState(failure.errMessage)), // نستخدم errMessage من Failure
      (blogResponse) => emit(BlogSuccessState(blogResponse.data.blogs)),
    );
  }
}

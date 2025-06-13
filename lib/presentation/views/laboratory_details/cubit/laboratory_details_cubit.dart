import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'laboratory_details_state.dart';

class LaboratoryDetailsCubit extends Cubit<LaboratoryDetailsState> {
  LaboratoryDetailsCubit() : super(LaboratoryDetailsInitial());
}

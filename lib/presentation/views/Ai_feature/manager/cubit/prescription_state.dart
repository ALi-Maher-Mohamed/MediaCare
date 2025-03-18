import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Ai_feature/data/models/Prescription_details_model.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object?> get props => [];
}

class AnalysisInitial extends AnalysisState {}

class AnalysisLoading extends AnalysisState {}

class AnalysisSuccess extends AnalysisState {
  final AnalysisData analysisData;

  const AnalysisSuccess(this.analysisData);

  @override
  List<Object?> get props => [analysisData];
}

class AnalysisFailure extends AnalysisState {
  final String errorMessage;

  const AnalysisFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

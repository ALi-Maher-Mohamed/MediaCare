import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/data/models/symptoms_model.dart';

abstract class SymptomAnalysisState extends Equatable {
  const SymptomAnalysisState();

  @override
  List<Object?> get props => [];
}

class SymptomAnalysisInitial extends SymptomAnalysisState {}

class SymptomAnalysisLoading extends SymptomAnalysisState {}

class SymptomAnalysisSuccess extends SymptomAnalysisState {
  final SymptomAnalysisData analysisData;

  const SymptomAnalysisSuccess(this.analysisData);

  @override
  List<Object?> get props => [analysisData];
}

class SymptomAnalysisFailure extends SymptomAnalysisState {
  final String errorMessage;

  const SymptomAnalysisFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

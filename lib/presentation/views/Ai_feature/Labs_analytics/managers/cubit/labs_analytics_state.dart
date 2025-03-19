import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/data/model/Labs_analytics_model.dart';

abstract class LabAnalysisState extends Equatable {
  const LabAnalysisState();

  @override
  List<Object?> get props => [];
}

class LabAnalysisInitial extends LabAnalysisState {}

class LabAnalysisLoading extends LabAnalysisState {}

class LabAnalysisSuccess extends LabAnalysisState {
  final LabAnalysisData analysisData;

  const LabAnalysisSuccess(this.analysisData);

  @override
  List<Object?> get props => [analysisData];
}

class LabAnalysisFailure extends LabAnalysisState {
  final String errorMessage;

  const LabAnalysisFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

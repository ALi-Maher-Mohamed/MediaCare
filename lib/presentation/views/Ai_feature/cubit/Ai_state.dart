import 'package:equatable/equatable.dart';

// نوع التحليل (روشتة، تحاليل، أعراض، أدوية)
enum AnalysisType { prescription, lab, symptom, medicine }

abstract class AiState extends Equatable {
  const AiState();

  @override
  List<Object?> get props => [];
}

class AiInitial extends AiState {}

class AiLoading extends AiState {
  final AnalysisType type;
  const AiLoading(this.type);

  @override
  List<Object?> get props => [type];
}

class AiSuccess extends AiState {
  final AnalysisType type;
  final dynamic result; // النتيجة (LabAnalysisData, MedicineDetail, إلخ)

  const AiSuccess(this.type, this.result);

  @override
  List<Object?> get props => [type, result];
}

class AiFailure extends AiState {
  final AnalysisType type;
  final String errorMessage;

  const AiFailure(this.type, this.errorMessage);

  @override
  List<Object?> get props => [type, errorMessage];
}

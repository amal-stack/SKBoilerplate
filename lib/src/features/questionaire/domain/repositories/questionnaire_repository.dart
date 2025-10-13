import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/step.dart';

abstract interface class QuestionnaireRepository {
  Future<List<AssessmentQuestion>> allQuestions();

  Future<List<AssessmentQuestion>> deviceFunctionalityQuestions();

  Future<List<AssessmentQuestion>> defectsSelectionQuestions();

  Future<List<AssessmentQuestion>> screenDefectsQuestions();

  Future<List<AssessmentQuestion>> displayDefectsQuestions();

  Future<List<AssessmentQuestion>> bodyDefectsQuestions();

  Future<List<AssessmentQuestion>> panelDefectsQuestions();

  Future<List<AssessmentQuestion>> accessoriesQuestions();

  Future<List<AssessmentQuestion>> additionalIssuesQuestions();

  Future<List<AssessmentQuestion>> warrantyQuestions();
}

extension QuestionnaireRepositoryStepExtension on QuestionnaireRepository {
  Future<List<AssessmentQuestion>> questionsForStep(
    DeviceAssessmentStep step,
  ) => switch (step) {
    DeviceAssessmentStep.functionality => deviceFunctionalityQuestions(),
    DeviceAssessmentStep.defectsSelection => defectsSelectionQuestions(),
    DeviceAssessmentStep.screenDefects => screenDefectsQuestions(),
    DeviceAssessmentStep.displayDefects => displayDefectsQuestions(),
    DeviceAssessmentStep.bodyDefects => bodyDefectsQuestions(),
    DeviceAssessmentStep.panelDefects => panelDefectsQuestions(),
    DeviceAssessmentStep.additionalDefects => additionalIssuesQuestions(),
    DeviceAssessmentStep.accessories => accessoriesQuestions(),
    DeviceAssessmentStep.warranty => warrantyQuestions(),
    DeviceAssessmentStep.imei ||
    DeviceAssessmentStep.imageUpload ||
    DeviceAssessmentStep.complete => Future.value(const []),
  };
}

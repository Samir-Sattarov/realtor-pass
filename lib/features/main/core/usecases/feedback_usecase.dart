import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../repository/main_repository.dart';

class FeedbackUsecase extends UseCase <void, FeedBackUsecaseParams> {
  final MainRepository repository;

  FeedbackUsecase(this.repository);
  @override
  Future<Either<AppError, void>> call(FeedBackUsecaseParams params) {
    return repository.sendFeedback(params.id, params.subject, params.feedback);
  }
}

class FeedBackUsecaseParams {
  final int id;
  final String subject;
  final String feedback;

  FeedBackUsecaseParams(this.id, this.subject, this.feedback);
}

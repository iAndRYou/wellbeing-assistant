import 'package:assistant/logic/http_repo.dart';

abstract class FormSubmitStatus {
  const FormSubmitStatus();
}

class InitialFormSubmitStatus extends FormSubmitStatus {
  const InitialFormSubmitStatus();
}

class FormSubmitting extends FormSubmitStatus {}

class FormSubmissionSuccess extends FormSubmitStatus {}

class FormSubmissionFailed extends FormSubmitStatus {
  final HttpServiceException exception;

  const FormSubmissionFailed(this.exception);
}

class FormSubmissionTimeout extends FormSubmitStatus {
  final HttpServiceTimeoutException exception;

  const FormSubmissionTimeout(this.exception);
}

abstract class FormSubmisstionStatus {
  const FormSubmisstionStatus();
}

class InitialFormStatus extends FormSubmisstionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmisstionStatus {}

class SubmissionSuccess extends FormSubmisstionStatus {}

class SubmissionFailed extends FormSubmisstionStatus {
  final Exception exception;
  SubmissionFailed(this.exception);
}

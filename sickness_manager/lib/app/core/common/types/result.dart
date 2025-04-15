abstract class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure;

  void onSuccess(void Function(T value) some) {
    if (this is Success<T>) some((this as Success<T>).value);
  }

  U when<U>({
    required U Function(T) success,
    required U Function(dynamic error) failure,
  }) =>
      switch (this) {
        Success(value: final v) => success.call(v),
        Failure(error: final e) => failure.call(e),
        _ => throw Exception('Unhandled Result type: $this'),
      };

  T? get valueOrNull {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }

    return null;
  }

  dynamic get errorOrNull {
    if (this is Failure) {
      return (this as Failure).error;
    }

    return null;
  }

  Result<S> map<S>(S Function(T) mappingFunction) => when(
        success: (content) => Success(mappingFunction(content)),
        failure: (error) => Failure(error),
      );
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final dynamic error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

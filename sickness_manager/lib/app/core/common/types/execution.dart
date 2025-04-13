abstract class Execution {
  const Execution();

  bool get isIdle => this is Idle;

  bool get isExecuting => this is Executing;

  bool get isFailed => this is Failed;

  bool get isSucceeded => this is Succeeded;

  U when<U>({
    required U Function() idle,
    required U Function() executing,
    required U Function(dynamic error) failed,
    required U Function() succeeded,
  }) {
    if (isIdle) {
      return idle();
    } else if (isExecuting) {
      return executing();
    } else if (isFailed) {
      final failure = this as Failed;
      return failed(failure.error);
    } else {
      return succeeded();
    }
  }
}

final class Idle extends Execution {
  const Idle();
}

final class Executing extends Execution {
  const Executing();
}

final class Failed extends Execution {
  const Failed([this.error]);

  final dynamic error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failed &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

final class Succeeded extends Execution {
  const Succeeded();
}

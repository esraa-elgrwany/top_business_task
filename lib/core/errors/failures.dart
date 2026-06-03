abstract class Failures {
  final String errorMsg;
  Failures(this.errorMsg);

  @override
  String toString() => errorMsg;
}

class ServerFailure extends Failures {
  final int? statusCode;
  ServerFailure(super.errorMsg, {this.statusCode});
}

class LocalFailures extends Failures {
  LocalFailures(super.errorMsg);
}

class NetworkFailure extends Failures {
  NetworkFailure(super.errorMsg);
}
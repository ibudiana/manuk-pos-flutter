abstract class Failures {
  final String message;
  const Failures(this.message);
}

// 🔥 Contoh turunan yang spesifik:

class ServerFailure extends Failures {
  const ServerFailure([String message = 'Server Failure']) : super(message);
}

class CacheFailure extends Failures {
  const CacheFailure([String message = 'Cache Failure']) : super(message);
}

class NetworkFailure extends Failures {
  const NetworkFailure([String message = 'Network Failure']) : super(message);
}

class UnknownFailure extends Failures {
  const UnknownFailure([String message = 'Unknown Failure']) : super(message);
}

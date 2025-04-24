abstract class Failures {
  final String message;
  const Failures(this.message);
}

// 🔥 Contoh turunan yang spesifik:

class ServerFailure extends Failures {
  const ServerFailure([super.message = 'Server Failure']);
}

class CacheFailure extends Failures {
  const CacheFailure([super.message = 'Cache Failure']);
}

class NetworkFailure extends Failures {
  const NetworkFailure([super.message = 'Network Failure']);
}

class UnknownFailure extends Failures {
  const UnknownFailure([super.message = 'Unknown Failure']);
}

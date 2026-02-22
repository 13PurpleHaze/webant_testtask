sealed class Error {
  const Error();

  const factory Error.networkFailure() = NetworkFailure;
  const factory Error.serverFailure() = ServerFailure;

  String get message {
    return switch (this) {
      NetworkFailure() => 'Отсутствует интерет соединение',
      ServerFailure() => 'Ошибка сервера',
    };
  }
}

class NetworkFailure extends Error {
  const NetworkFailure();
}

class ServerFailure extends Error {
  const ServerFailure();
}

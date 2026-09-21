class ServerException implements Exception {
  final String msg;
  
  new({required this.msg}); 
}

class InvalidInputException extends ServerException {
  new({required super.msg});
  
}

class InvaliCredentialsException extends ServerException {
  new({required super.msg});
  
}

class RateLimitedException extends ServerException {
  new({required super.msg});

}

class InvalidTokenException extends ServerException {
  new({required super.msg});
} 

class ExpiredTokenException extends ServerException {
  new({required super.msg});
}

class NotAuthorizedException extends ServerException {
  new({required super.msg});
  
} 

class NotFoundException extends ServerException {
  new({required super.msg});
  
}

class UnverifiedUserException extends ServerException {
  new({required super.msg});
}

class UnknownErrorException extends ServerException {
  new({required super.msg});
  
}

// those exceptions tells repo layer what to do and make the catching easier 

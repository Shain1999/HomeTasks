enum HttpStatusCode {
  ok,
  created,
  accepted,
  noContent,
  movedPermanently,
  found,
  badRequest,
  unauthorized,
  forbidden,
  internalServerError,
  notFound
}

extension HttpStatusExtension on HttpStatusCode {
  int get value {
    switch (this) {
      case HttpStatusCode.ok:
        return 200;
      case HttpStatusCode.created:
        return 201;
      case HttpStatusCode.accepted:
        return 202;
      case HttpStatusCode.noContent:
        return 204;
      case HttpStatusCode.movedPermanently:
        return 301;
      case HttpStatusCode.found:
        return 302;
      case HttpStatusCode.badRequest:
        return 400;
      case HttpStatusCode.unauthorized:
        return 401;
      case HttpStatusCode.forbidden:
        return 403;
      case HttpStatusCode.notFound:
        return 404;
      case HttpStatusCode.internalServerError:
        return 500;

    }
  }
}

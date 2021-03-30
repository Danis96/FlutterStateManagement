enum ApiPath {
  artists
}

class ApiPathHelper {
  static String getValue(ApiPath path, {String concatValue = ''}) {
    switch (path) {
      case ApiPath.artists:
        return 'f30a2517-60b4-11eb-a1e4-475264cf2bca';
      default:
        return '';
    }
  }
}
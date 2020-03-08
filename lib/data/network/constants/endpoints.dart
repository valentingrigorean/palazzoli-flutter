class Endpoints {
  Endpoints._();

  static const String user = "admin@admin.com";
  static const String password = "admin";

  static const String baseUrl = "http://lighting.bssplace.com";
  static const String baseApiUrl = baseUrl + '/api';

  static String basePhotoUrl = baseUrl + '/TipoWEB/';

  static const String login = "/auth/login";
  static const String getConfig = "/config";
  static const String getCatalog = "/subcategory/30601000000";
  static const String getCategories = "/subcategory_2";
  static const String getSubcategories = '/subcategory_3';
  static const String getProducts = '/products';
  static const String getProductDetail = '/products/info';

  static const String sendMail = '/send_mail';

  static const String searchProducts = '/search';

  static const String getActivities = '/activity';
  static const String saveInfo = '/save_info';

  static const String privacy =
      'https://www.palazzoli.com/it/content/informativa-privacy';
}

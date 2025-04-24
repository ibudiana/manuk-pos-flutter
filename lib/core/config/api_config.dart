class ApiConfig {
  static const String _baseDomain = 'http://10.0.2.2:8080';
  static const String _apiPath = '/api';

  static String get baseUrl => '$_baseDomain$_apiPath';

  // Auth
  static String register() => '$baseUrl/auth/register';
  static String login() => '$baseUrl/auth/login';

  // Inventories - Products
  static String products() => '$baseUrl/inventories/products';
  // static String productById(String id) => '$baseUrl/inventories/products/$id';
  static String productCategories() =>
      '$baseUrl/inventories/products/categories';
  // static String productCategoryById(String id) =>
  //     '$baseUrl/inventories/products/categories/$id';
  static String productSuppliers(String productId) =>
      '$baseUrl/inventories/products/$productId/suppliers';

  // Orders
  static String orders() => '$baseUrl/orders';
  //Fees
  static String fees() => '$baseUrl/orders/fees';

  // Customers
  static String customers() => '$baseUrl/customers';
  // static String customerById(String id) => '$baseUrl/customers/$id';

  // Vendor Suppliers
  static String suppliers() => '$baseUrl/vendor/suppliers';
  // static String supplierById(String id) => '$baseUrl/vendor/suppliers/$id';

  // Users
  static String users() => '$baseUrl/users';
  // static String userById(String id) => '$baseUrl/users/$id';

  // Roles
  static String roles() => '$baseUrl/roles';
  // static String roleById(String id) => '$baseUrl/roles/$id';

  // Branches
  static String branches() => '$baseUrl/store/branches';
  // static String branchById(String id) => '$baseUrl/store/branches/$id';

  // Finance - Taxes, Loans, Cash Drawers
  static String taxes() => '$baseUrl/finance/taxes';
  // static String taxById(String id) => '$baseUrl/finance/taxes/$id';

  static String loans() => '$baseUrl/finance/loans';
  // static String loanById(String id) => '$baseUrl/finance/loans/$id';

  static String cashDrawers() => '$baseUrl/finance/cash-drawers';
  // static String cashDrawerById(String id) =>
  //     '$baseUrl/finance/cash-drawers/$id';

  // Promotions
  static String promotions() => '$baseUrl/promotions';
  // static String promotionById(String id) => '$baseUrl/promotions/$id';

  static String discounts() => '$baseUrl/promotions/discounts';
  // static String discountById(String id) => '$baseUrl/promotions/discounts/$id';

  // Purchases
  static String purchases() => '$baseUrl/purchases';
  // static String purchaseById(String id) => '$baseUrl/purchases/$id';

  // Good Receivings
  static String goodReceivings() => '$baseUrl/purchases/good-receivings';
  // static String goodReceivingById(String id) =>
  // '$baseUrl/purchases/good-receivings/$id';
}

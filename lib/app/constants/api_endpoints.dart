class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String baseUrl = "http://192.168.1.71:3000/api/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  static const String login = "users/login";
  static const String register = "users/register";
  static const String verifyEmail = "users/verify-otp";
  static const String imageUrl = "http://10.0.2.2:1500/uploads/";
  static const String uploadImage = "users/uploadImage";
  // static const String getuser = "users/";

  // static const String getUserById = "users/";
  static const String getUserById = "profile/";
  static const String getProfile = "users/profile";
  static const String deleteUser = "users/";
  static const String getAllUsers = "users/all";

  // static const String getUserProfile = "/user/profile";
  // static String getUser(String userId) => "users/$userId";
  static String getUserProfile(String userId) => "profile/$userId";

  // static const String updateUserProfile = "/user/update";
  // static const String changePassword = "/user/change-password";
  // static const String logout = "/user/logout";

  static const String bookService = "books";
  // static const String bookService = "books/my-books";
  static const String getAllBookings = "bookings/all";
  static const String getUserBookings = "books/my-books";
  static const String confirmBooking = "bookings/confirm";

  static const String getAllServices = "services";
  static const String getServiceById = "services";
  static const String createService = "services";
  static const String updateServiceAvailability = "services/";
  static const String deleteService = "services/";
}

part of 'services.dart';

class AuthService {
  static Future<ApiReturnValue<UserModel?>> getDataUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('token') == null) {
        return ApiReturnValue(
          value: null,
          message: 'Token tidak ditemukan',
        );
      }
      final response = await http.get(
        Uri.parse(baseApi + 'user'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        String message = json['meta']['message'] ?? 'Silahkan login';
        return ApiReturnValue(
          value: null,
          message: message,
        );
      }

      return ApiReturnValue(
        value: UserModel.fromJson(json['data']),
        message: null,
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> login({
    required String username,
    required String password,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(baseApi + 'login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        String message = json['meta']['message'] ?? 'Gagal login';
        return ApiReturnValue(
          value: false,
          message: message,
        );
      }
      String token = json['data']['access_token'];

      await prefs.setString('token', token);
      return ApiReturnValue(value: true, message: 'berhasil');
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(baseApi + 'logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        String message = json['meta']['message'] ?? 'Gagal logout';
        return ApiReturnValue(
          value: false,
          message: message,
        );
      }
      await prefs.clear();
      return ApiReturnValue(value: true, message: 'berhasil');
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> checkIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(baseApi + 'check'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      final json = jsonDecode(response.body);
      String message = json['meta']['message'] ?? 'Error';
      if (response.statusCode != 200) {
        return ApiReturnValue(
          value: false,
          message: message,
        );
      }

      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> checkAbsent() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.get(
        Uri.parse(baseApi +
            'check?date=${DateFormat('yyyy-MM-dd').format(DateTime.now())}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      final json = jsonDecode(response.body);
      String message = json['meta']['message'] ?? 'Error';
      if (response.statusCode != 200) {
        return ApiReturnValue(
          value: false,
          message: message,
        );
      }

      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }
}

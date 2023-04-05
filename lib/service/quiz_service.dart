part of 'services.dart';

class QuizService {
  static Future<ApiReturnValue<bool>> isquizable(
      {required int quizId, http.Client? client}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      client ??= http.Client();
      final response = await client.get(
        Uri.parse(baseApi + 'quiz/isquizable/$quizId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      if (response.statusCode != 200) {
        String message = jsonDecode(response.body)['meta']['message'];
        return ApiReturnValue<bool>(
          value: false,
          message: message,
        );
      }

      return ApiReturnValue<bool>(
        value: true,
        message: null,
      );
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<List<QuizQuestionModel>>> getQuestion(
      {required int quizId, http.Client? client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await client.get(
        Uri.parse(baseApi + 'quiz/question/$quizId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      if (response.statusCode != 200) {
        String message = jsonDecode(response.body)['message'];
        return ApiReturnValue<List<QuizQuestionModel>>(
          value: null,
          message: message,
        );
      }

      List<QuizQuestionModel> value =
          (jsonDecode(response.body)['data'] as List)
              .map((e) => QuizQuestionModel.fromJson(e))
              .toList();
      return ApiReturnValue<List<QuizQuestionModel>>(
        value: value,
        message: 'berhasil',
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> answer(
      {required int questionId,
      required int quizId,
      required int quizOptionId,
      required bool value,
      http.Client? client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await client.post(
        Uri.parse(baseApi + 'quiz/answer/$questionId'),
        body: jsonEncode({
          'quiz_id': quizId,
          'quiz_option_id': quizOptionId,
          'value': value ? 1 : 0,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      if (response.statusCode != 200) {
        String message = jsonDecode(response.body)['message'];
        return ApiReturnValue<bool>(
          value: false,
          message: message,
        );
      }
      return ApiReturnValue<bool>(
        value: true,
        message: 'berhasil',
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }

  static Future<ApiReturnValue<QuizResultModel>> calculate(
      {required int quizId, http.Client? client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await client.get(
        Uri.parse(baseApi + 'quiz/calculate/$quizId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      if (response.statusCode != 200) {
        String message = jsonDecode(response.body)['meta']['message'];
        return ApiReturnValue<QuizResultModel>(
          value: null,
          message: message,
        );
      }

      QuizResultModel value = QuizResultModel.fromJson(
        jsonDecode(response.body)['data'],
      );

      return ApiReturnValue<QuizResultModel>(
        value: value,
        message: 'berhasil',
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }

  static Future<ApiReturnValue<List<QuizResultModel>>>? getresults(
      {http.Client? client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(baseApi + 'quiz/history'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      if (response.statusCode != 200) {
        String message = jsonDecode(response.body)['meta']['message'];
        return ApiReturnValue<List<QuizResultModel>>(
          value: null,
          message: message,
        );
      }
      List<QuizResultModel> value = (jsonDecode(response.body)['data'] as List)
          .map((e) => QuizResultModel.fromJson(e))
          .toList();

      return ApiReturnValue<List<QuizResultModel>>(
        value: value,
        message: 'berhasil',
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }

  static Future<ApiReturnValue<List<QuizGetScoreModel>>> getscore(
      String month) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(baseApi + 'quiz/getscore?month=$month'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final score = (data['data'] as Iterable)
            .map((e) => QuizGetScoreModel.fromJson(e))
            .toList();

        return ApiReturnValue<List<QuizGetScoreModel>>(
          value: score,
          message: 'berhasil',
        );
      }

      return ApiReturnValue(value: null, message: data['meta']['message']);
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }
}

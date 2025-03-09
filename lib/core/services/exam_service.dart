import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/services/secure_storage_service.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/end_points.dart';

@singleton
@injectable
class ExamService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));

  Future<Response> getAllSubjects() async {
    String? token = await SecureStorageService.getValue(kUserTokenKey);
    Response response = await _dio.get(
      subjectsEndPoint,
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );
    return response;
  }

  Future<Response> getAllExamsOnSubject({required String subjectId}) async {
    String? token = await SecureStorageService.getValue(kUserTokenKey);
    Response response = await _dio.get(
      '$examsEndPoint?subject=$subjectId',
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );
    return response;
  }

  Future<Response> getExamOnId({required String examId}) async {
    String? token = await SecureStorageService.getValue(kUserTokenKey);
    Response response = await _dio.get(
      '$examOnIdEndPoint/$examId',
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );
    return response;
  }

  Future<Response> getAllQuestionsOnExam({required String examId}) async {
    String? token = await SecureStorageService.getValue(kUserTokenKey);
    Response response = await _dio.get('$allQuestionsEndPoint?exam=$examId',
        options: Options(headers: {
          'token': token,
        }));
    return response;
  }

  Future<Response> checkQuestion(
      {required List<Map<String, dynamic>> answers}) async {
    String? token = await SecureStorageService.getValue(kUserTokenKey);
    Response response = await _dio.post(
      checkQuestionsEndPoint,
      data: {
        'answers': answers,
      },
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );
    return response;
  }
}

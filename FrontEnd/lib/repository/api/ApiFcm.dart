import 'package:dio/dio.dart';
import 'package:front/repository/commons.dart';

final api = ApiClient();

Future sendNotiGroup(data) async {
  final res = await api.post('/notification/group', data: data);
  print(res.runtimeType);
  return res.toString();
}
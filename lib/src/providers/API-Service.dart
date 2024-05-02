import 'dart:convert';
import 'package:coches_lista/src/models/vehicle-Model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.maxipublica.com/v3/ads-search/search';
  final String token =
      '777_9153_eyJ0eXBlIjoic2VsbGVyIiwicm9sIjoic2VsbGVyIiwidXNlcklkIjo5MTUzLCJzZWxsZXJJZCI6Nzc3LCJleHAiOjE3MTQ2NzkzNzIsImlhdCI6MTcxNDY3MjE3Mn0_TXhDQmhWbmkzWUI1VWxvREo0enZRaTFOMVdlSVlVU3pZajVENTc3d2xQUQ';
  int _offset = 0;
  int limit = 30;

  Future<Map<String, Object>> fetchVehicles() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?app=true&listadmin=true&status=active&offset=$_offset&token=$token&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> vehiclesData = jsonData['results'];
      final int total = jsonData['details']['total'];
      _offset += limit;

      List<VehicleModel> vehicles =
          vehiclesData.map((data) => VehicleModel.fromMapJson(data)).toList();

      return {'vehicles': vehicles, 'total': total};
    } else {
      print('Failed to load vehicles: ${response.body}');
      throw Exception('Failed to load vehicles');
    }
  }
}

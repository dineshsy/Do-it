import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<List> apiRequest(int N, File file) async {
  String url = "http://192.168.43.48:5000/";
  print("into post");
  var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
  var length = await file.length();
  var multipartFile = new http.MultipartFile("file", stream, length,
      filename: basename(file.path));
  var uri = Uri.parse(url);

  http.MultipartRequest request = new http.MultipartRequest('POST', uri)
    ..fields['index'] = "$N"
    ..files.add(multipartFile);

  var streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);

  var jsonRes = json.decode(response.body);

  var result = jsonRes['result'] as List;
  print(result);
  return (result);
}

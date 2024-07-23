import 'dart:convert';
import 'package:banckmarkhosteladmin/models/UserState.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/issue.dart';
import '../services/Token.dart';

const baseUrl = 'https://barogxtrade.com.ng';
// const baseUrl = 'http://127.0.0.1:8000';

Future<dynamic> studentLogin(String email, String password) async {
  Map body = {
    "email": email,
    "password": password,
  };
  var url = Uri.parse('$baseUrl/auth/student-login/');
  var res = await http.post(
    url,
    body: body,
  );
  print(res.body);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['token'];
    var box = await Hive.openBox(tokenBox);
    box.put('token', token);
    getUserdata(token);
    return email;
  } else {
    Map<String, dynamic> json = jsonDecode(res.body);
    return json['detail'] ?? 'Unknown error';
  }
}

Future<dynamic> studentReg(
    String email, String password, String username, String regNo) async {
  Map body = {
    "email": email,
    "password": password,
    "username": username,
    "reg_no": regNo,
    "password2": password,
  };
  var url = Uri.parse('$baseUrl/auth/student-register/');
  var res = await http.post(
    url,
    body: body,
  );
  print(res.body);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['token'];
    var box = await Hive.openBox(tokenBox);
    box.put('token', token);
    getUserdata(token);
    return email;
  } else {
    Map<String, dynamic> json = jsonDecode(res.body);
    return json['detail'] ?? 'Unknown error';
  }
}

Future<User?> getUserdata(String token) async {
  var url = Uri.parse('$baseUrl/auth/user-details/');
  var res = await http.get(url, headers: {
    'Authorization': 'Token $token',
  });

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    // Handle null values in JSON
    String? id = json["id"];
    String? email = json["email"];
    String? username = json["username"];
    String? regNo = json["reg_no"];
    bool? isStudent = json["is_student"];
    bool? isWarden = json["is_warden"];
    bool? hasHotel = json["has_hostel"];
    String? lastLogin = json["last_login"];
    String? tokens = json["tokens"];

    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Set values only if they are not null
    if (id != null) await prefs.setString("uid", id);
    if (email != null) await prefs.setString("email", email);
    if (username != null) await prefs.setString("username", username);
    if (regNo != null) await prefs.setString("reg_no", regNo);
    if (isStudent != null) await prefs.setBool("is_student", isStudent);
    if (isWarden != null) await prefs.setBool("is_warden", isWarden);
    if (hasHotel != null) await prefs.setBool("has_Hotel", hasHotel);
    if (lastLogin != null) await prefs.setString("last_login", lastLogin);
    if (tokens != null) await prefs.setString("tokens", tokens);
    if (hasHotel != null) await getHostel(token);

    // Create User object
    User user = User.fromJson(json);

    return user;
  } else {
    return null;
  }
}

Future<dynamic> newHostel(String roomType, String seater, String hostel,
    String roomNumber, String bed) async {
  Map body = {
    "room_type": roomType,
    "seater": seater,
    "hostel": hostel,
    "room_number": roomNumber,
    "bed": bed,
    // "user": userID,
  };
  var box = await Hive.openBox(tokenBox);
  String? token = box.get('token');
  var url = Uri.parse('$baseUrl/hostel/hostel-create/');
  var res = await http.post(url, body: body, headers: {
    'Authorization': 'Token $token',
  });

  if (res.statusCode == 201) {
    getHostel(token!);

    return roomType;
  } else {
    Map<String, dynamic> json = jsonDecode(res.body);
    return json['detail'] ?? 'Unknown error';
  }
}

Future getHostel(String token) async {
  var url = Uri.parse('$baseUrl/hostel/user-hostel-detail/');
  var res = await http.get(url, headers: {
    'Authorization': 'Token $token',
  });
  print(res.body);
  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    String? roomType = json["room_type"];
    String? seater = json["seater"];
    String? hostel = json["hostel"];
    String? roomNumber = json["room_number"];
    String? bed = json["bed"];

    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    if (roomType != null) await prefs.setString("roomType", roomType);
    if (seater != null) await prefs.setString("seater", seater);
    if (hostel != null) await prefs.setString("hostel", hostel);
    if (roomNumber != null) await prefs.setString("roomNumber", roomNumber);
    if (bed != null) await prefs.setString("bed", bed);
    print('done');

    return 'done';
  } else {
    return null;
  }
}

Future<dynamic> wardenLogin(String email, String password) async {
  Map body = {
    "email": email,
    "password": password,
  };
  var url = Uri.parse('$baseUrl/auth/warden-login/');
  var res = await http.post(
    url,
    body: body,
  );
  print(res.body);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['token'];
    var box = await Hive.openBox(tokenBox);
    box.put('token', token);
    getUserdata(token);
    return email;
  } else {
    Map<String, dynamic> json = jsonDecode(res.body);
    return json['detail'] ?? 'Unknown error';
  }
}

Future<dynamic> wardenReg(
    String email, String password, String username, String regNo) async {
  Map body = {
    "email": email,
    "password": password,
    "username": username,
    "reg_no": regNo,
    "password2": password,
  };
  var url = Uri.parse('$baseUrl/auth/warden-register/');
  var res = await http.post(
    url,
    body: body,
  );
  print(res.body);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['token'];
    var box = await Hive.openBox(tokenBox);
    box.put('token', token);
    getUserdata(token);
    return email;
  } else {
    Map<String, dynamic> json = jsonDecode(res.body);
    return json['detail'] ?? 'Unknown error';
  }
}

void logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  var box = await Hive.openBox(tokenBox);
  box.delete('token');
  await Hive.close();
}

Future<dynamic> wardenStudentReg(
    String email, String username, String regNo) async {
  Map body = {
    "email": email,
    "password": regNo,
    "username": username,
    "reg_no": regNo,
    "password2": regNo,
  };
  var url = Uri.parse('$baseUrl/auth/student-register/');
  var res = await http.post(
    url,
    body: body,
  );
  print(res.body);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['token'];
    print(token);
    var url = Uri.parse('$baseUrl/auth/user-details/');
    var res1 = await http.get(url, headers: {
      'Authorization': 'Token $token',
    });
    print(res1.body);
    var json1 = jsonDecode(res1.body);
    String? id = json1["id"];
    return id;
  } else {
    Map<String, dynamic> json = jsonDecode(res.body);
    return json['detail'] ?? 'Unknown error';
  }
}

Future<List<Issue>> fetchIssues(String token) async {
  final url = Uri.parse('$baseUrl/hostel/request-list/');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    List<dynamic> data = json.decode(response.body);
    print(data);
    return data.map((json) => Issue.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load issues');
  }
}

Future<List<Transfar>> fetchtransfar(String token) async {
  final url = Uri.parse('$baseUrl/hostel/transfar-list/');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    print(data);
    return data.map((json) => Transfar.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load issues');
  }
}

Future<List<Report>> fetchReports(String token) async {
  final url = Uri.parse('$baseUrl/hostel/report-list/');
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Report.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load reports');
  }
}

Future<List<Request>> fetchrequest(String token) async {
  final url = Uri.parse('$baseUrl/hostel/request-list/');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    print(data);
    return data.map((json) => Request.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load issues');
  }
}

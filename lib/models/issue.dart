class Issue {
  final int id;
  final int user;
  final String email;
  final String request;
  final String request_status;
  final DateTime createdAt;

  Issue({
    required this.id,
    required this.user,
    required this.email,
    required this.request,
    required this.request_status,
    required this.createdAt,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'],
      email: json['email'],
      user: json['user'],
      request: json['request'],
      request_status: json['request_status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Transfar {
  final int id;
  final int user;
  final String email;
  final String transfar;
  final String transfarStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transfar({
    required this.id,
    required this.user,
    required this.transfar,
    required this.email,
    required this.transfarStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transfar.fromJson(Map<String, dynamic> json) {
    return Transfar(
      id: json['id'],
      user: json['user'],
      email: json['email'],
      transfar: json['transfar'],
      transfarStatus: json['transfar_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'transfar': transfar,
      'email': email,
      'transfar_status': transfarStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Report {
  final int id;
  final String email;
  final String report;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.report,
    required this.email,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      email: json['email'],
      report: json['report'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'report': report,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Request {
  final int id;
  final int user;
  final String email;
  final String request;
  final String requestStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Request({
    required this.id,
    required this.user,
    required this.request,
    required this.email,
    required this.requestStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      user: json['user'],
      email: json['email'],
      request: json['request'],
      requestStatus: json['request_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      "email": email,
      'request': request,
      'request_status': requestStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

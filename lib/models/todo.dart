enum Status {
  all,
  completed,
  pending,
  inActive,
}

String convertStatusToString(Status status) {
  switch (status) {
    case Status.completed:
      return 'completed';
    case Status.pending:
      return 'pending';
    case Status.inActive:
      return 'inActive';
    default:
      return 'all';
  }
}

Status convertStringToStatus(String status) {
  switch (status) {
    case 'completed':
      return Status.completed;
    case 'pending':
      return Status.pending;
    case 'inActive':
      return Status.inActive;
    default:
      return Status.all;
  }
}

class Todo {
  int? id;
  String title;
  String description;
  Status status;

  Todo({ this.id, required this.title, required this.description, required this.status});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      title: json['title'].toString(),
      description: json['description'].toString(),
      status: convertStringToStatus(json['status']),
    );
  }

  String get statusString {
    String str = '';
    switch (status) {
      case Status.completed:
        str = 'completed';
        break;
      case Status.pending:
        str = 'pending';
        break;
      case Status.inActive:
        str = 'inActive';
        break;
      default:
        str = 'all';
        break;
    }
    return str;
  }

  Map toJson() {
    if (id != null) {
      return {
        'id': id.toString(),
        'title': title.toString(),
        'description': description.toString(),
        'status': convertStatusToString(status),
      };
    }
    return {
      'title': title.toString(),
      'description': description.toString(),
      'status': convertStatusToString(status),
    };
  }
}

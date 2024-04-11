class User {
  int id;
  String username;
  String password;
  String prenom;
  String lang;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.prenom,
      required this.lang});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'prenom': prenom,
      'lang': lang,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      prenom: map['prenom'],
      lang: map['lang'],
    );
  }
}

class TaskGroup {
  int id;
  String name;
  String description;

  TaskGroup({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory TaskGroup.fromMap(Map<String, dynamic> map) {
    return TaskGroup(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}

class Task {
  int? id;
  String? name;
  String? creationDate;
  bool? isOk;
  String? modificationDate;
  String? detail;
  int? userId;
  int? groupId;
  int? priority;
  String? status;

  Task({
    this.id,
    this.name,
    this.creationDate,
    this.isOk,
    this.modificationDate,
    this.detail,
    this.userId,
    this.groupId,
    this.priority,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'name': name,
      'creation_date': creationDate,
      'is_ok': isOk.toString(),
      'modification_date': modificationDate,
      'detail': detail,
      'user_id': userId,
      'group_id': groupId,
      'priority': priority,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      creationDate: map['creation_date'],
      isOk: map['is_ok'] == true.toString(),
      modificationDate: map['modification_date'],
      detail: map['detail'],
      userId: map['user_id'],
      groupId: map['group_id'],
      priority: map['priority'],
      status: map['status'],
    );
  }
}

class TaskSchedule {
  int id;
  int taskId;
  String startDate;
  int duration;
  String endDate;
  String startTime;
  String endTime;

  TaskSchedule({
    required this.id,
    required this.taskId,
    required this.startDate,
    required this.duration,
    required this.endDate,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'start_date': startDate,
      'duration': duration,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  factory TaskSchedule.fromMap(Map<String, dynamic> map) {
    return TaskSchedule(
      id: map['id'],
      taskId: map['task_id'],
      startDate: map['start_date'],
      duration: map['duration'],
      endDate: map['end_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }
}

class TaskScheduleDay {
  int id;
  int scheduleId;
  String dayOfWeek;
  String startTime;
  String endTime;

  TaskScheduleDay({
    required this.id,
    required this.scheduleId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'schedule_id': scheduleId,
      'day_of_week': dayOfWeek,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  factory TaskScheduleDay.fromMap(Map<String, dynamic> map) {
    return TaskScheduleDay(
      id: map['id'],
      scheduleId: map['schedule_id'],
      dayOfWeek: map['day_of_week'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }
}

class TaskReport {
  int id;
  int taskId;
  String date;
  int completed;

  TaskReport({
    required this.id,
    required this.taskId,
    required this.date,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'date': date,
      'completed': completed,
    };
  }

  factory TaskReport.fromMap(Map<String, dynamic> map) {
    return TaskReport(
      id: map['id'],
      taskId: map['task_id'],
      date: map['date'],
      completed: map['completed'],
    );
  }
}

class TaskTag {
  int id;
  int taskId;
  String tag;

  TaskTag({
    required this.id,
    required this.taskId,
    required this.tag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'tag': tag,
    };
  }

  factory TaskTag.fromMap(Map<String, dynamic> map) {
    return TaskTag(
      id: map['id'],
      taskId: map['task_id'],
      tag: map['tag'],
    );
  }
}

class TaskAttachment {
  int id;
  int taskId;
  String filePath;

  TaskAttachment({
    required this.id,
    required this.taskId,
    required this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'file_path': filePath,
    };
  }

  factory TaskAttachment.fromMap(Map<String, dynamic> map) {
    return TaskAttachment(
      id: map['id'],
      taskId: map['task_id'],
      filePath: map['file_path'],
    );
  }
}

class TaskActionHistory {
  int id;
  int taskId;
  String action;
  String actionDate;

  TaskActionHistory({
    required this.id,
    required this.taskId,
    required this.action,
    required this.actionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'action': action,
      'action_date': actionDate,
    };
  }

  factory TaskActionHistory.fromMap(Map<String, dynamic> map) {
    return TaskActionHistory(
      id: map['id'],
      taskId: map['task_id'],
      action: map['action'],
      actionDate: map['action_date'],
    );
  }
}

class TaskCollaborator {
  int id;
  int taskId;
  int userId;

  TaskCollaborator({
    required this.id,
    required this.taskId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'user_id': userId,
    };
  }

  factory TaskCollaborator.fromMap(Map<String, dynamic> map) {
    return TaskCollaborator(
      id: map['id'],
      taskId: map['task_id'],
      userId: map['user_id'],
    );
  }
}

class ExpenseCategory {
  int id;
  String name;

  ExpenseCategory({required this.id, required this.name});

  factory ExpenseCategory.fromMap(Map<String, dynamic> map) => ExpenseCategory(
        id: map['id'],
        name: map['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}

class PaymentMethod {
  int id;
  String name;

  PaymentMethod({required this.id, required this.name});

  factory PaymentMethod.fromMap(Map<String, dynamic> map) => PaymentMethod(
        id: map['id'],
        name: map['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}

class Transaction {
  int id;
  int userId;
  int categoryId;
  int paymentMethodId;
  double amount;
  String date;
  String note;

  Transaction({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.paymentMethodId,
    required this.amount,
    required this.date,
    required this.note,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) => Transaction(
        id: map['id'],
        userId: map['user_id'],
        categoryId: map['category_id'],
        paymentMethodId: map['payment_method_id'],
        amount: map['amount'],
        date: map['date'],
        note: map['note'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'category_id': categoryId,
        'payment_method_id': paymentMethodId,
        'amount': amount,
        'date': date,
        'note': note,
      };
}

class Budget {
  int id;
  int userId;
  int categoryId;
  double amount;
  String startDate;
  String endDate;

  Budget({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
  });

  factory Budget.fromMap(Map<String, dynamic> map) => Budget(
        id: map['id'],
        userId: map['user_id'],
        categoryId: map['category_id'],
        amount: map['amount'],
        startDate: map['start_date'],
        endDate: map['end_date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'category_id': categoryId,
        'amount': amount,
        'start_date': startDate,
        'end_date': endDate,
      };
}

class TaskTransaction {
  int id;
  int taskId;
  int transactionId;

  TaskTransaction({
    required this.id,
    required this.taskId,
    required this.transactionId,
  });

  factory TaskTransaction.fromMap(Map<String, dynamic> map) => TaskTransaction(
        id: map['id'],
        taskId: map['task_id'],
        transactionId: map['transaction_id'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'task_id': taskId,
        'transaction_id': transactionId,
      };
}

class TaskBudget {
  int id;
  int taskId;
  int budgetId;

  TaskBudget({
    required this.id,
    required this.taskId,
    required this.budgetId,
  });

  factory TaskBudget.fromMap(Map<String, dynamic> map) => TaskBudget(
        id: map['id'],
        taskId: map['task_id'],
        budgetId: map['budget_id'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'task_id': taskId,
        'budget_id': budgetId,
      };
}

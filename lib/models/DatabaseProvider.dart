import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/DataClass.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  static late Database _database;

  Future<Database> get database async {
    return _database;
  }

  Future<void> createDatabase() async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'todo225.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
    CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT,
    password TEXT,
    prenom TEXT,
    lang TEXT
  )
  ''');
      await db.execute('''
      CREATE TABLE task_groups (
    id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT
);
  ''');

      await db.execute('''
    CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    name TEXT,
    creation_date TEXT,
    is_ok INTEGER,
    modification_date TEXT,
    detail TEXT,
    user_id INTEGER,
    group_id INTEGER,
    priority INTEGER,
    status TEXT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(group_id) REFERENCES task_groups(id)
  )
  ''');
      await db.execute('''
    CREATE TABLE task_schedules (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    start_date TEXT,
    duration INTEGER,
    end_date TEXT,
    start_time TEXT,
    end_time TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
)
  ''');
      await db.execute('''
    CREATE TABLE task_schedule_days (
    id INTEGER PRIMARY KEY,
    schedule_id INTEGER,
    day_of_week TEXT,
    start_time TEXT,
    end_time TEXT,
    FOREIGN KEY(schedule_id) REFERENCES task_schedules(id)
)
  ''');
      await db.execute('''
    CREATE TABLE task_reports (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    date TEXT,
    completed INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
)
  ''');
      await db.execute('''
    CREATE TABLE task_tags (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    tag TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
)
  ''');
      await db.execute('''
    CREATE TABLE task_attachments (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    file_path TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
)
  ''');
      await db.execute('''
    CREATE TABLE task_actions_history (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    action TEXT,
    action_date TEXT,
    FOREIGN KEY(task_id) REFERENCES tasks(id)
)
  ''');
      await db.execute('''
    CREATE TABLE task_collaborators (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
)
  ''');
      // Insertion d'un utilisateur par défaut
      await db.rawInsert('''
  INSERT INTO users(username, password, prenom, lang)
  VALUES("test", "1234", "John Doe", "fr")
''');

// Insertion d'un groupe de tâches par défaut
      await db.rawInsert('''
  INSERT INTO task_groups(name, description)
  VALUES("Groupe de tâches par défaut", "Description du groupe de tâches par défaut")
''');

// Insertion d'une tâche par défaut
      await db.rawInsert('''
  INSERT INTO tasks(name, creation_date, is_ok, modification_date, detail, user_id, group_id, priority, status)
  VALUES("Tâche par défaut", "2024-03-31", false, "2024-03-31", "Détail de la tâche par défaut", 1, 1, 1, "En cours")
''');

// Insertion d'un planning de tâche par défaut
      await db.rawInsert('''
  INSERT INTO task_schedules(task_id, start_date, duration, end_date, start_time, end_time)
  VALUES(1, "2024-03-31", 1, "2024-04-01", "09:00", "17:00")
''');

// Insertion d'un rapport de tâche par défaut
      await db.rawInsert('''
  INSERT INTO task_reports(task_id, date, completed)
  VALUES(1, "2024-03-31", 0)
''');

// Insertion d'un tag de tâche par défaut
      await db.rawInsert('''
  INSERT INTO task_tags(task_id, tag)
  VALUES(1, "Tag de tâche par défaut")
''');

// Insertion d'une pièce jointe de tâche par défaut
      await db.rawInsert('''
  INSERT INTO task_attachments(task_id, file_path)
  VALUES(1, "/chemin/vers/la/piece_jointe")
''');

// Insertion d'un historique d'actions de tâche par défaut
      await db.rawInsert('''
  INSERT INTO task_actions_history(task_id, action, action_date)
  VALUES(1, "Action de tâche par défaut", "2024-03-31")
''');

// Insertion d'un collaborateur de tâche par défaut
      await db.rawInsert('''
  INSERT INTO task_collaborators(task_id, user_id)
  VALUES(1, 1)
''');

      print('Database created successfully'); // Journalisation
    });

    //return _database;
  }

  static Future<void> createUser(User user) async {
    final Database db = await _database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('User created successfully'); // Journalisation
  }

  static Future<User> getUser(String username, String password) async {
    final List<Map<String, dynamic>> maps = await _database.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    if (maps.isNotEmpty) {
      print('User retrieved successfully'); // Journalisation
      final user = User.fromMap(maps[0]);
      return user;
    } else {
      print('User not found'); // Journalisation
      throw Exception('User not found');
    }
  }

  static Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await _database.query('tasks');
    print(maps);
    print('Tasks retrieved successfully'); // Journalisation
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  static Future<List<Task>> getTasksByUserId(int userId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tasks',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    print(
        'Tasks retrieved successfully for user with ID: $userId'); // Journalisation
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  static Future<Task> getTasksById(int taskId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
    print(maps);
    print(
        'Tasks retrieved successfully for user with ID: $taskId'); // Journalisation
    final task = Task.fromMap(maps[0]);
    return task;
  }

  static Future<User?> getUserByUsername(String username) async {
    print('Fetching user by username: $username'); // Journalisation
    List<Map<String, dynamic>> users = await _database.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (users.isNotEmpty) {
      print('User found'); // Journalisation
      final user = User.fromMap(users[0]);
      return user;
    } else {
      print('User not found'); // Journalisation
      return null;
    }
  }

  static Future<void> addTask(Task task) async {
    try {
      await _database.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task added successfully');
    } catch (e) {
      print('Failed to add task: $e');
      throw Exception('Failed to add task');
    }
  }

  static Future<void> updateTask(Task task) async {
    try {
      await _database.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
      print('Task updated successfully');
    } catch (e) {
      print('Failed to update task: $e');
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await _database.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [taskId],
      );
      print('Task deleted successfully');
    } catch (e) {
      print('Failed to delete task: $e');
      throw Exception('Failed to delete task');
    }
  }

  static Future<void> addTaskGroup(TaskGroup taskGroup) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_groups',
        taskGroup.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task group added successfully');
    } catch (e) {
      print('Failed to add task group: $e');
      throw Exception('Failed to add task group');
    }
  }

  static Future<List<TaskGroup>> getTaskGroups() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query('task_groups');
      return List.generate(maps.length, (i) {
        return TaskGroup.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task groups: $e');
      throw Exception('Failed to get task groups');
    }
  }

  static Future<TaskGroup?> getTaskGroupById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_groups',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskGroup.fromMap(maps[0]);
      } else {
        print('Task group with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task group: $e');
      throw Exception('Failed to get task group');
    }
  }

  static Future<void> updateTaskGroup(TaskGroup taskGroup) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_groups',
        taskGroup.toMap(),
        where: 'id = ?',
        whereArgs: [taskGroup.id],
      );
      print('Task group updated successfully');
    } catch (e) {
      print('Failed to update task group: $e');
      throw Exception('Failed to update task group');
    }
  }

  static Future<void> deleteTaskGroup(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_groups',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task group deleted successfully');
    } catch (e) {
      print('Failed to delete task group: $e');
      throw Exception('Failed to delete task group');
    }
  }

  static Future<void> addTaskSchedule(TaskSchedule taskSchedule) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_schedules',
        taskSchedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task schedule added successfully');
    } catch (e) {
      print('Failed to add task schedule: $e');
      throw Exception('Failed to add task schedule');
    }
  }

  static Future<List<TaskSchedule>> getTaskSchedules() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query('task_schedules');
      return List.generate(maps.length, (i) {
        return TaskSchedule.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task schedules: $e');
      throw Exception('Failed to get task schedules');
    }
  }

  static Future<TaskSchedule?> getTaskScheduleById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_schedules',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskSchedule.fromMap(maps[0]);
      } else {
        print('Task schedule with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task schedule: $e');
      throw Exception('Failed to get task schedule');
    }
  }

  static Future<void> updateTaskSchedule(TaskSchedule taskSchedule) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_schedules',
        taskSchedule.toMap(),
        where: 'id = ?',
        whereArgs: [taskSchedule.id],
      );
      print('Task schedule updated successfully');
    } catch (e) {
      print('Failed to update task schedule: $e');
      throw Exception('Failed to update task schedule');
    }
  }

  static Future<void> deleteTaskSchedule(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_schedules',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task schedule deleted successfully');
    } catch (e) {
      print('Failed to delete task schedule: $e');
      throw Exception('Failed to delete task schedule');
    }
  }

  static Future<void> addTaskScheduleDay(
      TaskScheduleDay taskScheduleDay) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_schedule_days',
        taskScheduleDay.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task schedule day added successfully');
    } catch (e) {
      print('Failed to add task schedule day: $e');
      throw Exception('Failed to add task schedule day');
    }
  }

  static Future<List<TaskScheduleDay>> getTaskScheduleDays() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps =
          await db.query('task_schedule_days');
      return List.generate(maps.length, (i) {
        return TaskScheduleDay.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task schedule days: $e');
      throw Exception('Failed to get task schedule days');
    }
  }

  static Future<TaskScheduleDay?> getTaskScheduleDayById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_schedule_days',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskScheduleDay.fromMap(maps[0]);
      } else {
        print('Task schedule day with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task schedule day: $e');
      throw Exception('Failed to get task schedule day');
    }
  }

  static Future<void> updateTaskScheduleDay(
      TaskScheduleDay taskScheduleDay) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_schedule_days',
        taskScheduleDay.toMap(),
        where: 'id = ?',
        whereArgs: [taskScheduleDay.id],
      );
      print('Task schedule day updated successfully');
    } catch (e) {
      print('Failed to update task schedule day: $e');
      throw Exception('Failed to update task schedule day');
    }
  }

  static Future<void> deleteTaskScheduleDay(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_schedule_days',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task schedule day deleted successfully');
    } catch (e) {
      print('Failed to delete task schedule day: $e');
      throw Exception('Failed to delete task schedule day');
    }
  }

  static Future<void> addTaskReport(TaskReport taskReport) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_reports',
        taskReport.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task report added successfully');
    } catch (e) {
      print('Failed to add task report: $e');
      throw Exception('Failed to add task report');
    }
  }

  static Future<List<TaskReport>> getTaskReports() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query('task_reports');
      return List.generate(maps.length, (i) {
        return TaskReport.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task reports: $e');
      throw Exception('Failed to get task reports');
    }
  }

  static Future<TaskReport?> getTaskReportById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_reports',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskReport.fromMap(maps[0]);
      } else {
        print('Task report with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task report: $e');
      throw Exception('Failed to get task report');
    }
  }

  static Future<void> updateTaskReport(TaskReport taskReport) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_reports',
        taskReport.toMap(),
        where: 'id = ?',
        whereArgs: [taskReport.id],
      );
      print('Task report updated successfully');
    } catch (e) {
      print('Failed to update task report: $e');
      throw Exception('Failed to update task report');
    }
  }

  static Future<void> deleteTaskReport(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_reports',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task report deleted successfully');
    } catch (e) {
      print('Failed to delete task report: $e');
      throw Exception('Failed to delete task report');
    }
  }

  static Future<void> addTaskTag(TaskTag taskTag) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_tags',
        taskTag.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task tag added successfully');
    } catch (e) {
      print('Failed to add task tag: $e');
      throw Exception('Failed to add task tag');
    }
  }

  static Future<List<TaskTag>> getTaskTags() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query('task_tags');
      return List.generate(maps.length, (i) {
        return TaskTag.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task tags: $e');
      throw Exception('Failed to get task tags');
    }
  }

  static Future<TaskTag?> getTaskTagById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_tags',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskTag.fromMap(maps[0]);
      } else {
        print('Task tag with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task tag: $e');
      throw Exception('Failed to get task tag');
    }
  }

  static Future<void> updateTaskTag(TaskTag taskTag) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_tags',
        taskTag.toMap(),
        where: 'id = ?',
        whereArgs: [taskTag.id],
      );
      print('Task tag updated successfully');
    } catch (e) {
      print('Failed to update task tag: $e');
      throw Exception('Failed to update task tag');
    }
  }

  static Future<void> deleteTaskTag(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_tags',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task tag deleted successfully');
    } catch (e) {
      print('Failed to delete task tag: $e');
      throw Exception('Failed to delete task tag');
    }
  }

  static Future<void> addTaskAttachment(TaskAttachment taskAttachment) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_attachments',
        taskAttachment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task attachment added successfully');
    } catch (e) {
      print('Failed to add task attachment: $e');
      throw Exception('Failed to add task attachment');
    }
  }

  static Future<List<TaskAttachment>> getTaskAttachments() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps =
          await db.query('task_attachments');
      return List.generate(maps.length, (i) {
        return TaskAttachment.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task attachments: $e');
      throw Exception('Failed to get task attachments');
    }
  }

  static Future<TaskAttachment?> getTaskAttachmentById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_attachments',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskAttachment.fromMap(maps[0]);
      } else {
        print('Task attachment with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task attachment: $e');
      throw Exception('Failed to get task attachment');
    }
  }

  static Future<void> updateTaskAttachment(
      TaskAttachment taskAttachment) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_attachments',
        taskAttachment.toMap(),
        where: 'id = ?',
        whereArgs: [taskAttachment.id],
      );
      print('Task attachment updated successfully');
    } catch (e) {
      print('Failed to update task attachment: $e');
      throw Exception('Failed to update task attachment');
    }
  }

  static Future<void> deleteTaskAttachment(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_attachments',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task attachment deleted successfully');
    } catch (e) {
      print('Failed to delete task attachment: $e');
      throw Exception('Failed to delete task attachment');
    }
  }

  static Future<void> addTaskActionHistory(
      TaskActionHistory taskActionHistory) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_actions_history',
        taskActionHistory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task action history added successfully');
    } catch (e) {
      print('Failed to add task action history: $e');
      throw Exception('Failed to add task action history');
    }
  }

  static Future<List<TaskActionHistory>> getTaskActionHistories() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps =
          await db.query('task_actions_history');
      return List.generate(maps.length, (i) {
        return TaskActionHistory.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task action histories: $e');
      throw Exception('Failed to get task action histories');
    }
  }

  static Future<TaskActionHistory?> getTaskActionHistoryById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_actions_history',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskActionHistory.fromMap(maps[0]);
      } else {
        print('Task action history with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task action history: $e');
      throw Exception('Failed to get task action history');
    }
  }

  static Future<void> updateTaskActionHistory(
      TaskActionHistory taskActionHistory) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_actions_history',
        taskActionHistory.toMap(),
        where: 'id = ?',
        whereArgs: [taskActionHistory.id],
      );
      print('Task action history updated successfully');
    } catch (e) {
      print('Failed to update task action history: $e');
      throw Exception('Failed to update task action history');
    }
  }

  static Future<void> deleteTaskActionHistory(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_actions_history',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task action history deleted successfully');
    } catch (e) {
      print('Failed to delete task action history: $e');
      throw Exception('Failed to delete task action history');
    }
  }

  static Future<void> addTaskCollaborator(
      TaskCollaborator taskCollaborator) async {
    try {
      final Database db = await _database;
      await db.insert(
        'task_collaborators',
        taskCollaborator.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task collaborator added successfully');
    } catch (e) {
      print('Failed to add task collaborator: $e');
      throw Exception('Failed to add task collaborator');
    }
  }

  static Future<List<TaskCollaborator>> getTaskCollaborators() async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps =
          await db.query('task_collaborators');
      return List.generate(maps.length, (i) {
        return TaskCollaborator.fromMap(maps[i]);
      });
    } catch (e) {
      print('Failed to get task collaborators: $e');
      throw Exception('Failed to get task collaborators');
    }
  }

  static Future<TaskCollaborator?> getTaskCollaboratorById(int id) async {
    try {
      final Database db = await _database;
      final List<Map<String, dynamic>> maps = await db.query(
        'task_collaborators',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskCollaborator.fromMap(maps[0]);
      } else {
        print('Task collaborator with id $id not found');
        return null;
      }
    } catch (e) {
      print('Failed to get task collaborator: $e');
      throw Exception('Failed to get task collaborator');
    }
  }

  static Future<void> updateTaskCollaborator(
      TaskCollaborator taskCollaborator) async {
    try {
      final Database db = await _database;
      await db.update(
        'task_collaborators',
        taskCollaborator.toMap(),
        where: 'id = ?',
        whereArgs: [taskCollaborator.id],
      );
      print('Task collaborator updated successfully');
    } catch (e) {
      print('Failed to update task collaborator: $e');
      throw Exception('Failed to update task collaborator');
    }
  }

  static Future<void> deleteTaskCollaborator(int id) async {
    try {
      final Database db = await _database;
      await db.delete(
        'task_collaborators',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Task collaborator deleted successfully');
    } catch (e) {
      print('Failed to delete task collaborator: $e');
      throw Exception('Failed to delete task collaborator');
    }
  }
}

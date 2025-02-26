import 'package:clean_ease/features/auth/data/model/auth_hive_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// import '../../features/services/data/model/Service_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/clean_ease.db';

    Hive.init(path);

    Hive.registerAdapter(UserHiveModelAdapter());
    // Hive.registerAdapter(ServiceHiveModelAdapter());
  }

  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    await box.put(user.id, user);
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    return box.values.toList();
  }

  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null; // Return null if no user is found
    }
  }

  // Clear All Data
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  // Clear Specific User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  // Close Hive Database
  Future<void> close() async {
    await Hive.close();
  }

  // Service Queries

// Add or Register a Service
//   Future<void> addService(ServiceHiveModel service) async {
//     var box =
//         await Hive.openBox<ServiceHiveModel>(HiveTableConstant.serviceBox);
//     await box.put(service.serviceId, service);
//   }

// // Delete a Service by ID
//   Future<void> deleteService(String serviceId) async {
//     var box =
//         await Hive.openBox<ServiceHiveModel>(HiveTableConstant.serviceBox);
//     await box.delete(serviceId);
//   }

// // Get All Services
//   Future<List<ServiceHiveModel>> getAllServices() async {
//     var box =
//         await Hive.openBox<ServiceHiveModel>(HiveTableConstant.serviceBox);
//     return box.values.toList();
//   }

// // Get Service by ID
//   Future<ServiceHiveModel?> getServiceById(String serviceId) async {
//     var box =
//         await Hive.openBox<ServiceHiveModel>(HiveTableConstant.serviceBox);
//     return box.get(serviceId);
//   }
}

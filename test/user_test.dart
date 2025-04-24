// import 'package:manuk_pos/features/user/data/datasources/remote_datasource.dart';

// void main() async {
//   final userRemoteDataSource = UserRemoteDataSourceImpl();
//   final users = await userRemoteDataSource.getAllUsers();

//   for (var user in users) {
//     print('User ID: ${user.id}');
//     print('Role ID: ${user.roleId}');
//     print('Branch ID: ${user.branchId}');
//     print('Username: ${user.username}');
//     print('Name: ${user.name}');
//     print('Email: ${user.email}');
//     print('Phone: ${user.phone}');
//   }
// }

// import 'package:manuk_pos/features/user/data/datasources/remote_datasource.dart';
// import 'package:manuk_pos/features/user/domain/entities/user.dart';

// void main() async {
//   final userRemoteDataSource = UserRemoteDataSourceImpl();

//   await userRemoteDataSource.updateUserById(
//       2,
//       User(
//         id: 2,
//         roleId: 2,
//         branchId: 1,
//         username: 'staff',
//         name: 'staff User',
//         email: 'yan.budiana@gmail.com',
//         phone: '11111111111', isActive: 1, loginCount: 0, createdAt: null,
//       ));
// }

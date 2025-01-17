// // import 'package:clean_ease/features/auth/presentation/view/login_view.dart';
// // import 'package:clean_ease/features/auth/presentation/view/register_view.dart';
// // import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/home_view.dart';
// // import 'package:clean_ease/features/splash/presentation/view/splash_view.dart';
// // import 'package:clean_ease/features/splash/presentation/view_model/splash_cubit.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:get_it/get_it.dart';

// // class App extends StatelessWidget {
// //   const App({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Student Management',
// //       theme: ThemeData.light(),
// //       initialRoute: '/splash',
// //       routes: {
// //         '/splash': (context) => BlocProvider(
// //               create: (_) => GetIt.instance<SplashCubit>(),
// //               child: const SplashView(),
// //             ),
// //         '/login': (context) => LoginView(),
// //         '/register': (context) => const RegisterView(),
// //         '/home': (context) => const HomeView(),
// //       },
// //     );
// //   }
// // }

// import 'package:clean_ease/features/auth/presentation/view/login_view.dart';
// import 'package:clean_ease/features/auth/presentation/view/register_view.dart';
// import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/home_view.dart';
// import 'package:clean_ease/features/splash/presentation/view/splash_view.dart';
// import 'package:clean_ease/features/splash/presentation/view_model/splash_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Clean Ease',
//       theme: ThemeData.light(),
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (context) => BlocProvider(
//               create: (_) => GetIt.instance<SplashCubit>(),
//               child: const SplashView(),
//             ),
//         // '/login': (context) => LoginView(),
//         '/login': (context) => BlocProvider(
//               create: (_) => GetIt.instance<LoginBloc>(),
//               child: LoginView(),
//             ),
//         '/register': (context) => BlocProvider(
//               create: (_) => GetIt.instance<RegisterBloc>(),
//               child: const RegisterView(),
//             ),
//         '/home': (context) => const HomeView(),
//       },
//     );
//   }
// }

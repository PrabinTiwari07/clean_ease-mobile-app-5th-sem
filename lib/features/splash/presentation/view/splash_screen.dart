// import 'package:clean_ease/features/splash/presentation/view_model/splash_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SplashCubit>().init(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[50],
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: Image.asset('assets/images/splash.png'),
//                 ),
//                 const Text(
//                   'Student Course Management',
//                   style: TextStyle(
//                     fontSize: 25,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const CircularProgressIndicator(),
//                 const SizedBox(height: 10),
//                 const Text('version : 1.0.0')
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: MediaQuery.of(context).size.width / 4,
//             child: const Text(
//               'Developed by: Kiran Rana sir',
//               style: TextStyle(fontSize: 15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:clean_ease/features/auth/presentation/view/onboarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tantra-logo.png',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/text-logo.png',
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 17, 47, 74),
            ),
          ],
        ),
      ),
    );
  }
}

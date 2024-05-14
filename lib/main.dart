import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:user_management/config/cache_config/cache_management.dart';
import 'package:user_management/config/routes/router.dart';
import 'package:user_management/data/repository/auth_repository.dart';
import 'package:user_management/data/repository/user_repository.dart';
import 'package:user_management/modules/authentication/bloc/auth_bloc.dart';
import 'package:user_management/modules/home/bloc/user_list/user_bloc.dart';

Future<void> main() async {
  await CacheManagement.initHive();
  CacheManagement.intialiseTypeAdapter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'User Management',
        routerConfig: routesConfiguration,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            primary: const Color(0xffe1aba9),
            seedColor: const Color(0xffe1aba9),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}

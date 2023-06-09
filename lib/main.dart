import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/app_navigator.dart';
import 'package:login_bloc/auth/auth_cubit.dart';
import 'package:login_bloc/auth/auth_navigator.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/auth/login/login_view.dart';
import 'package:login_bloc/session_cubit.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) =>
              SessionCubit(authRepository: context.read<AuthRepository>()),
          child: const AppNavigator(),
        ),
      ),
    );
  }
}

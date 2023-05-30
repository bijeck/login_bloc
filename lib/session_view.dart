import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/session_cubit.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Session View'),
            TextButton(
              child: const Text('Sign Out'),
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
            ),
          ],
        ),
      ),
    );
  }
}

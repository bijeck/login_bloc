import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_cubit.dart';
import 'package:login_bloc/auth/auth_navigator.dart';
import 'package:login_bloc/loading_view.dart';
import 'package:login_bloc/session_cubit.dart';
import 'package:login_bloc/session_state.dart';
import 'package:login_bloc/session_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            //show loading view
            if (state is UnknowSessionState)
              const MaterialPage(child: LoadingView()),

            //show auth flow
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: AuthNavigator(),
                ),
              ),

            //show session flow
            if (state is Authenticated)
              const MaterialPage(child: SessionView()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_cubit.dart';
import 'package:login_bloc/auth/confirm/confirmation_view.dart';
import 'package:login_bloc/auth/login/login_view.dart';
import 'package:login_bloc/auth/sign_up/sign_up_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            //show login
            if(state == AuthState.login) MaterialPage(child: LoginView()),

            //allow push animation
            if(state == AuthState.signUp || state == AuthState.cofirmSignUp)...[

              //show sign up
              MaterialPage(child: SignUpView()),

              //show confirmation
              if(state == AuthState.cofirmSignUp) MaterialPage(child: ConfirmationView())
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}

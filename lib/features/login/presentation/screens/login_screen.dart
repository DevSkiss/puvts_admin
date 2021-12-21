import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puvts_admin/core/constants/puvts_colors.dart';
import 'package:puvts_admin/core/presentation/widgets/puvts_button.dart';
import 'package:puvts_admin/core/presentation/widgets/puvts_textfield.dart';
import 'package:puvts_admin/core/utils/dialog_util.dart';
import 'package:puvts_admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:puvts_admin/features/login/domain/bloc/login_bloc.dart';
import 'package:puvts_admin/features/login/domain/bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.hasError) {
          DialogUtils.showDialogMessage(
            context,
            title: 'PUVTS',
            message: 'Username or Password is Incorrect',
          );
        }

        if (state.isNotAdmin) {
          DialogUtils.showDialogMessage(
            context,
            title: 'PUVTS',
            message: 'Please login as a Admin. Thank you',
          );
        }

        if (!state.isLoading && !state.hasError && state.isFinished) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DashboardScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: 500,
            width: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: puvtsWhite,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PUVTS ADMIN',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Text('Email'),
                  ],
                ),
                const SizedBox(height: 12),
                PuvtsTextfield(
                  borderColor: puvtsBlue,
                  hintText: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Text('Password'),
                  ],
                ),
                const SizedBox(height: 12),
                PuvtsTextfield(
                  borderColor: puvtsBlue,
                  hintText: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                PuvtsButton(
                  icon: state.isLoading
                      ? CircularProgressIndicator(color: puvtsWhite)
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: puvtsWhite,
                        ),
                  width: double.infinity,
                  height: 50,
                  onPressed: () => context.read<LoginBloc>().login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}

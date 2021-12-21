import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:puvts_admin/features/login/domain/bloc/login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc()
      : super(LoginState(
          isFinished: false,
          hasError: false,
          isLoading: false,
        )) {
    initialized();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Logger _logger = Logger();

  void initialized() async {
    await auth.signOut();
  }

  void login({required String email, required String password}) async {
    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      isFinished: false,
      isNotAdmin: false,
    ));
    try {
      UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      var result = await firestore
          .collection('users')
          .where('user_id', isEqualTo: authResult.user?.uid)
          .get();

      if (authResult.user?.uid != '' &&
          (result.docs[0]['user_type'] == 'admin')) {
        emit(state.copyWith(
          isLoading: false,
          hasError: false,
          isFinished: true,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          hasError: false,
          isFinished: false,
          isNotAdmin: true,
        ));
      }
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}

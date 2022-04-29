import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puvts_admin/core/app/locator_injection.dart';
import 'package:puvts_admin/core/constants/puvts_colors.dart';
import 'package:puvts_admin/core/presentation/widgets/puvts_button.dart';
import 'package:puvts_admin/core/presentation/widgets/puvts_textfield.dart';
import 'package:puvts_admin/features/login/data/service/auth_service_api.dart';

class DialogUtils {
  final AuthApiService _authApiService = locator<AuthApiService>();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _plateNumberController = TextEditingController();
  static void showDialogMessage(BuildContext context,
      {String? title, String? message, void Function()? onPressed}) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              message ?? '',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: PuvtsButton(
                text: 'Okay',
                height: 40,
                onPressed: onPressed ?? Navigator.of(context).pop,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showLoading(BuildContext context,
      {String? title, String? message, void Function()? onPressed}) {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Please wait',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }

  void showDelete(
    BuildContext context, {
    required String id,
  }) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'PUVTS Admin',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Are you sure you want to delete?',
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: PuvtsButton(
                        text: 'Cancel',
                        height: 40,
                        buttonColor: Colors.grey,
                        onPressed: Navigator.of(context).pop,
                      ),
                    ),
                    Expanded(
                      child: PuvtsButton(
                        text: 'Delete',
                        height: 40,
                        buttonColor: puvtsRed,
                        onPressed: () async {
                          await _authApiService.deleteDriver(
                            id: id,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void showUpdateDialog(
    BuildContext context, {
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    void Function()? onPressed,
  }) {
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          TextEditingController firstnameController =
              TextEditingController(text: firstname);
          TextEditingController lastnameController =
              TextEditingController(text: lastname);
          TextEditingController emailController =
              TextEditingController(text: email);
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Container(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Update Driver',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PuvtsTextfield(
                    controller: firstnameController,
                    borderColor: puvtsBlue,
                    hintText: 'First name',
                  ),
                  const SizedBox(height: 12),
                  PuvtsTextfield(
                    controller: lastnameController,
                    borderColor: puvtsBlue,
                    hintText: 'Last name',
                  ),
                  const SizedBox(height: 12),
                  PuvtsTextfield(
                    controller: emailController,
                    borderColor: puvtsBlue,
                    hintText: 'Email',
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: PuvtsButton(
                      text: 'Update Driver',
                      height: 40,
                      onPressed: () async {
                        await _authApiService.updateDriver(
                          id: id,
                          firstname: firstnameController.text,
                          lastname: lastnameController.text,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showAddDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Container(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add New Driver',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PuvtsTextfield(
                controller: _firstnameController,
                borderColor: puvtsBlue,
                hintText: 'First name',
              ),
              const SizedBox(height: 12),
              PuvtsTextfield(
                controller: _lastnameController,
                borderColor: puvtsBlue,
                hintText: 'Last name',
              ),
              const SizedBox(height: 12),
              PuvtsTextfield(
                controller: _emailController,
                borderColor: puvtsBlue,
                hintText: 'Email',
              ),
              const SizedBox(height: 12),
              PuvtsTextfield(
                controller: _passwordController,
                borderColor: puvtsBlue,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 12),
              PuvtsTextfield(
                controller: _passwordController,
                borderColor: puvtsBlue,
                hintText: 'Plate Number',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: PuvtsButton(
                  text: 'Create New Driver',
                  height: 40,
                  icon: Icon(Icons.add_rounded),
                  onPressed: () async {
                    await _authApiService.createDriver(
                      plateNumber: _plateNumberController.text,
                      firstname: _firstnameController.text,
                      lastname: _lastnameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cineflix_id/presentation/providers/usecases/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/login/login.dart';
import '../../../domain/usecases/login/login_params.dart';
import '../main_page/main_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Login login = ref.watch(loginProvider);

              login(LoginParams(
                      email: 'ramdan@yopmail.com', password: '123456'))
                  .then((result) {
                if (result.isSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainPage(user: result.resultValue!),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(result.errorMessage!),
                  ));
                }
              });
            },
            child: const Text('Login')),
      ),
    );
  }
}

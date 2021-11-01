import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is SuccessState) {
              const snackBar = SnackBar(content: Text('Login Successful'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is FailureState) {
              final snackBar = SnackBar(content: Text(state.failureMsg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Material App Bar'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Correct email or password is admin@gmail.com or admin123 ",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return (state is LoadingState)
                            ? const LinearProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(DoLogin(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ));
                                },
                                child: const Text("Submit"),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

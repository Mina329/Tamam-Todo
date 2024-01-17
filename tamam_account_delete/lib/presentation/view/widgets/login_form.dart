import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.onSavedEmail,
    required this.onSavedPassword,
  });
  final GlobalKey<FormState> formKey;
  final Function(String?) onSavedEmail;
  final Function(String?) onSavedPassword;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(),
                    label: FittedBox(
                      child: Text(
                        'Email',
                      ),
                    ),
                  ),
                  validator: _buildEmailValidation,
                  onSaved: widget.onSavedEmail,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecure = !obsecure;
                        });
                      },
                      icon: FittedBox(
                        child: Icon(
                          obsecure ? Icons.visibility_off : Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    label: const FittedBox(
                      child: Text(
                        'Password',
                      ),
                    ),
                  ),
                  obscureText: obsecure,
                  validator: _buildPasswordValidation,
                  onSaved: widget.onSavedPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _buildPasswordValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Invalid Password';
    }
    return null;
  }

  String? _buildEmailValidation(value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }
}

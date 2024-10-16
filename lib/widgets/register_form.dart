import 'package:flutter/material.dart';
import 'package:flutter_lab1/controller/auth_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _NameController = TextEditingController();
  String _selectedRole = '';

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      print('Name : ${_NameController.text}');
      print('Username : ${_usernameController.text}');
      print('Password : ${_passwordController.text}');
      print('role: $_selectedRole');
      try {
        await AuthService().register(_NameController.text,
            _usernameController.text, _passwordController.text, _selectedRole);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Registration failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _NameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: <Widget>[
              ChoiceChip(
                label: const Text('user'),
                selected: _selectedRole == 'user',
                selectedColor: Colors.blueAccent,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                    color:
                        _selectedRole == 'user' ? Colors.white : Colors.black),
                onSelected: (selected) {
                  setState(() {
                    _selectedRole = 'user';
                  });
                },
              ),
              ChoiceChip(
                label: const Text('admin'),
                selected: _selectedRole == 'admin',
                selectedColor: Colors.blueAccent,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                    color:
                        _selectedRole == 'admin' ? Colors.white : Colors.black),
                onSelected: (selected) {
                  setState(() {
                    _selectedRole = 'admin';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _register,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

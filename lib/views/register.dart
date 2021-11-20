import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:donasi_mobile/providers/auth.dart';
import 'package:donasi_mobile/utils/validate.dart';
import 'package:donasi_mobile/styles/styles.dart';
import 'package:donasi_mobile/widgets/styled_flat_button.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
                        backgroundColor: Colors.white,

      ),
      // body: Center(
      //   child: Container(
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      //       child: RegisterForm(),
      //     ),
      //   ),
      // ),
       body: Center(
       child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/regis.png",
              width: 180.0,
            ),
Padding(
            
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: RegisterForm(),
          ),
          ]
        )
       )

      )
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String email;
  String referal;
  String regTipe;
  String password;
  String passwordConfirm;
  String message = '';
  String _mySelection;
   final List<String> _dropdownValues = [
     "Pilih Register Sebagai",
    "Amil",
    "Donatur"
  ]; //The list of values we want on the dropdown
String dropdownValue = 'One';

  Map response = new Map();


  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      response = await Provider.of<AuthProvider>(context)
          .register(name, regTipe, referal,  email,  password, passwordConfirm);
      if (response['success']) {
        Navigator.pop(context);
      } else {
        setState(() {
          message = response['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Register Account',
            textAlign: TextAlign.center,
            style: Styles.h1,
          ),
          SizedBox(height: 10.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Styles.error,
          ),
          SizedBox(height: 30.0),
          TextFormField(
            decoration: Styles.input.copyWith(
              hintText: 'Name',
            ),
            validator: (value) {
              name = value.trim();
              return Validate.requiredField(value, 'Name is required.');
            }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            decoration: Styles.input.copyWith(
              hintText: 'Kode Referal',
            ),
            validator: (value) {
              referal = value.trim();
              return Validate.requiredField(value, 'referal is required.');
            }
          ),
                    SizedBox(height: 15.0),

         Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            border: Border.all(
                color: Colors.black38, style: BorderStyle.solid, width: 0.80),
          ),
          child: new DropdownButton(
          // controller: tgl_keberangkatanControler,
          items: _dropdownValues
                .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                .toList(),
          onChanged: (newVal) {
            setState(() {
              regTipe = newVal;
              //   tgl_keberangkatan =  newVal;
            });
          },
          value: regTipe,
          isExpanded: false,

        ),
          ),
        
        
          SizedBox(height: 15.0),
          TextFormField(
            decoration: Styles.input.copyWith(
              hintText: 'Email',
            ),
            validator: (value) {
              email = value.trim();
              return Validate.validateEmail(value);
            }
          ),
          
          SizedBox(height: 15.0),
          TextFormField(
            obscureText: true,
            decoration: Styles.input.copyWith(
              hintText: 'Password',
            ),
            validator: (value) {
              password = value.trim();
              return Validate.requiredField(value, 'Password is required.');
            }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            obscureText: true,
            decoration: Styles.input.copyWith(
              hintText: 'Password Confirm',
            ),
            validator: (value) {
              passwordConfirm = value.trim();
              return Validate.requiredField(value, 'Password confirm is required.');
            }
          ),
          SizedBox(height: 15.0),
          StyledFlatButton(
            'Register',
            onPressed: submit,
          ),
        ],
      ),
    );
  }
}

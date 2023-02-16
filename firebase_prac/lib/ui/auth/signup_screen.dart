import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_prac/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    ).then((value){
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace){
      Utils().ToastMessage(error.toString());

      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:const Center(
            child: Text('SignUp Screen')
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key:  _formKey ,
              child:Column(
                children: [
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration:const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email)
                      ),

                      validator: (value) {
                        if (value!.isEmpty){

                          return 'Enter Email';
                        }

                        return null;
                      }
                  ),



                  const SizedBox(height: 20),

                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration:const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline)
                      ),

                      validator: (value) {
                        if (value!.isEmpty){

                          return 'Enter password';
                        }

                        return null;
                      }
                  ),
                ],
              )
          ),

          const SizedBox(height: 50),


          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 20),
            child: RoundButton(
              title: 'Sign up',
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){

                  login();
                 
                }

              },
            ),

          ),
          SizedBox(height:30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              TextButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen())
                );
              },
                  child: Text('Login'))

            ],
          ),
        ],
      ),
    );
  }
}

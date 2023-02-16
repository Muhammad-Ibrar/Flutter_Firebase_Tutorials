import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_prac/ui/auth/login_with_phone_number.dart';
import 'package:firebase_prac/ui/auth/posts/post_screen.dart';
import 'package:firebase_prac/ui/auth/signup_screen.dart';
import 'package:firebase_prac/ui/forgot_password.dart';
import 'package:firebase_prac/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/round_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

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

    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()
    ).then((value){

      setState(() {
        loading = false;
      });
      
      Utils().ToastMessage(value.user!.email.toString());

      Navigator.push(context, 
      MaterialPageRoute(builder: (context)=> PostScreen())
      );

    }).onError((error, stackTrace){

      debugPrint(error.toString());
      Utils().ToastMessage(error.toString());

      setState(() {
        loading = false;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{


        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:const Center(
              child: Text('Login Screen')
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
                title: 'Login',
                loading: loading,
                onTap: (){
                  if(_formKey.currentState!.validate()){

                    login();
                  }

                },
              ),



            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen())
                );

              },
                  child: Text('Forgot password')
              ),
            ),
            SizedBox(height:30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account?'),
               TextButton(onPressed: (){
                 Navigator.push(context,
                     MaterialPageRoute(
                         builder: (context) => SignUpScreen())
                 );

               },
                   child: Text('SignUp')),


              ],
            ),
            SizedBox(height:30),

            InkWell(
              onTap: (){

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginWithPhoneNumber())
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black
                  )
                ),

                child:const Center(
                  child: Text('Login with phone number'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

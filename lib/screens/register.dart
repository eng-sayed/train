import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train/shared/my_text_field.dart';
import 'package:flutter_train/shared/textfield.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // MyTextField(
                //   label: 'Email',
                //   controller: f1,
                //   keyboardType: TextInputType.visiblePassword,
                //   validate: (s) {
                //     if (s!.isEmpty) {
                //       return 'no';
                //     }
                //   },
                // ),
                TextField2(
                  hint: 'Enter Your Name',
                  label: "Name",
                  textInputType: TextInputType.text,
                  controller: nameController,
                  valid: (s) {
                    if (s!.isEmpty) {
                      return 'It can\'t be empty';
                    }
                  },
                ),
                TextField2(
                  hint: 'Enter Your Email',
                  label: "Email",
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  valid: (s) {
                    if (s!.isEmpty) {
                      return 'It can\'t be empty';
                    }
                  },
                ),
                TextField2(
                  label: 'Password',
                  hint: 'Enter Your Password',
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordController,
                  valid: (s) {
                    if (s!.isEmpty) {
                      return 'It can\'t be empty';
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        // يتم التحقق ان كل التكست فيلد ليس بها اخطا و ذلك باستخدام المفتاح المعرف مسبقا

                      }

                      try {
                        UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        showSnack(context,
                            userCredential.user!.emailVerified.toString());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          showSnack(context, 'The password is wrong.');
                          print('The password provided is too weak.');
                        } else if (e.code == 'user-not-found') {
                          showSnack(context, 'The account not found.');
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showSnack(context, txt) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.grey.shade500,
      content: Text(txt,
          style: TextStyle(
            color: Colors.white,
          ))));
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_api/bloc/shopLoginCubit.dart';
import 'package:shop_app_api/bloc/shopLoginState.dart';
import 'package:shop_app_api/component/cons.dart';
import 'package:shop_app_api/screeen/ShopLayout.dart';
import 'package:shop_app_api/screeen/shopRegisterScreen.dart';
import 'package:shop_app_api/shared/cache_Helper.dart';

import '../component/component.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var fromKey = GlobalKey<FormState>();
  var passwordC = TextEditingController();
  var emailC = TextEditingController();
  bool isv = true;
  bool isv2 = false;
  @override


  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {

          if(state is ShopLoginSuccessState){

            if(state.loginModel.status == true){

              print(state.loginModel.message);
              print(state.loginModel.data!.token);
        //      token =  state.loginModel.data!.token!;

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {

                token =  state.loginModel.data!.token!;

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return ShopLayout();}));
              });


            }else{
              token =  state.loginModel.data!.token!;
              print(state.loginModel.message);

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            //       Login page created
            appBar: AppBar(
              title: Center(child: Text("login" ,style: TextStyle(color: Colors.blue))),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  // SingleChildScrollView protects against overflow in the app
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFormField(context, "email"),
                        // Here call method to create a TextFormField
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "password"),

                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          // When the button is pressed, the Loading sign appears
                          condition: state is! ShopLoginLodingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailC.text,
                                    password: passwordC.text);
                              }
                            },
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              fixedSize: Size(double.maxFinite, 50),
                            ),
                          ),
                          fallback: (context) => CircularProgressIndicator(),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("dont have an account? "),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ShopRegisterScreen();
                                      //ShopRegisterScreen();
                                  }));
                                },
                                child: Text("Register Now"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context, String name) {
    return TextFormField(
      controller: name == "password" ? passwordC : emailC,
      // Here each TextField controller gives its own
      decoration: InputDecoration(
          label: Text(name),
          prefixIcon: Icon(name == "password" ? Icons.lock : Icons.email),
          // Here the icon changes according to the name of the TextField

          suffixIcon: name == "password"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isv = !isv;
                    });
                  },
                  icon: Icon(isv ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          // Change the icon according to the show of the Password
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.8),
          )),
      obscureText: name == "password" ? isv : isv2,
      // Here to show or hide the password
      onFieldSubmitted: (value){
        if (fromKey.currentState!.validate()) {
          ShopLoginCubit.get(context).userLogin(
              email: emailC.text,
              password: passwordC.text);
        }
      },
      validator: (val) {
        // validator Shows some notifications under the TextFormField
        if (val!.isEmpty) {
          // Here, if the TextFormField is empty, it gives an alert
          return "$name is Empty";
        }
      },
    );
  }
}

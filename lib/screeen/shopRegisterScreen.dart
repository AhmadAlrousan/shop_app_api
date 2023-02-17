import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/ShopRegisterCubit.dart';
import 'package:shop_app_api/bloc/ShopRegisterState.dart';
import 'package:shop_app_api/component/cons.dart';
import 'package:shop_app_api/screeen/ShopLayout.dart';
import 'package:shop_app_api/screeen/login_Screen.dart';
import 'package:shop_app_api/shared/cache_Helper.dart';



class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  var fromKey = GlobalKey<FormState>();
  var nameC = TextEditingController();
  var emailC = TextEditingController();
  var phoneC = TextEditingController();
  var passwordC = TextEditingController();


  bool isv = true;
  bool isv2 = false;
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
      create:(BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterState>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){

            if(state.loginModel.status == true){


              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token!;
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return ShopLayout();}));
              });
            }else{
       //       print(state.loginModel.message);

            }
          }
        },
        builder: (context, state) {
          return     Scaffold(
            appBar: AppBar( title: Center(child: Text("Register" ,style: TextStyle(color: Colors.blue))),
              backgroundColor: Colors.white,),
            body:   Padding(
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
                          "Register",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFormField(context, "email"),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "name"),

                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "password"),

                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "phone"),

                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          // When the button is pressed, the Loading sign appears
                          condition:
                          state is! ShopRegisterLodingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailC.text,
                                    password: passwordC.text,
                                    name: nameC.text,
                                    phone: phoneC.text
                                );
                              }
                            },

                            child: Text("Register"),
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
                            Text("do have an account? "),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return ShopLoginScreen();
                                      }));
                                },
                                child: Text("Login Now"))
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
      controller: name == "name" ? nameC : name== "email" ? emailC : name== "password" ? passwordC: phoneC,


      decoration: InputDecoration(
          label: Text(name),
          prefixIcon: Icon(name == "password" ? Icons.lock :name == "name" ? Icons.drive_file_rename_outline  :name=='email' ? Icons.email : Icons.phone),

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

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.8),
          )),

      obscureText: name == "password" ? isv : isv2,

      onFieldSubmitted: (value){
        // if (fromKey.currentState!.validate()) {
        //   ShopRegisterCubit.get(context).userRegister(
        //     email: emailC.text,
        //     password: passwordC.text,
        //     name:nameC.text,
        //     phone: phoneC.text
        //   );
        // }
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
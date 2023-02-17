import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shopLoginCubit.dart';
import 'package:shop_app_api/bloc/shop_Cubit.dart';
import 'package:shop_app_api/bloc/shop_States.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var fromKey = GlobalKey<FormState>();
  var nameC = TextEditingController();
  var emailC = TextEditingController();
  var phoneC = TextEditingController();

  bool isv = true;
  bool isv2 = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameC.text=model?.data?.name as String;
        emailC.text=model?.data?.email as String;
        phoneC.text=model?.data?.phone as String;

        return     ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
         builder: (context)=>
             Padding(
           padding: const EdgeInsets.all(20.0),
           child: Form(
             key: fromKey,
             child: Column(
               children: [
                 buildTextFormField(context , 'email'),
                 SizedBox(height: 20,),
                 buildTextFormField(context , 'name'),
                 SizedBox(height: 20,),
                 buildTextFormField(context , 'phone'),
                 SizedBox(height: 20,),
                 SizedBox(
                   width: 400,
                   height: 50,
                   child: ElevatedButton(onPressed: (){
                     if(fromKey.currentState!.validate()){
                       ShopCubit.get(context).updateUserData(
                           name: nameC.text,
                           email: emailC.text,
                           phone: phoneC.text
                       );
                     }

                   },
                       child: Text("EDIT") ,

                   ),
                 )
               ],
             ),
           ),
         ),
          fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
        );
      },


    );
  }

  TextFormField buildTextFormField(BuildContext context, String name) {
    return TextFormField(
      controller: name == "name" ? nameC : name== "email" ? emailC : phoneC,


      decoration: InputDecoration(
          label: Text(name),
          prefixIcon: Icon(name == "name" ? Icons.drive_file_rename_outline  :name=='email' ? Icons.email : Icons.phone),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.8),
          )),

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





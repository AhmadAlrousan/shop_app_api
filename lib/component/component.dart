import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

Widget buildArticaleItem(article , context)

 => Padding(
    // This is where the news ticker is built
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}',), // Here the image is taken from the api
                fit: BoxFit.cover,

              ),
            )
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text("${article['title']}" ,// Here the title is taken from the api
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,

                )),
                Text("${article['publishedAt']}" , // Here the time is taken from the api
                  style: Theme.of(context).textTheme.bodyText2,)

              ],
            ),
          ),
        ),
      ],
    ),
);

Widget articaleBuilder(list , context)=>ConditionalBuilder(
  condition: list.length>0,
  // Here ListView is built to display news
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context , index){
        return buildArticaleItem // Here buildArticaleItem has been called
          (list[index] ,context);
      },
      separatorBuilder: (context , index){
        return myDivider();
      },
      itemCount: 10),
  fallback: (context)=> Center(
    child: CircularProgressIndicator(

    ),
  ),
);
Widget myDivider()=>    Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

// void ShowToast({required String text ,required Color color })=> Fluttertoast.showToast(
//     msg: text,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: color,
//     textColor: Colors.white,
//     fontSize: 16
// );


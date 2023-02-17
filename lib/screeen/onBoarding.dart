
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_api/screeen/login_Screen.dart';
import 'package:shop_app_api/shared/cache_Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/shop1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/shop2.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/shop3.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
  ];

  bool isLast=false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return ShopLoginScreen();
      }));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed:(){
            submit();
          } ,
              child: Text("SKIP"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1 )
                    {
                      setState(() {
                        isLast=true;
                      });
                    }else
                      {
                        setState(() {
                          isLast=false;
                        });
                      }
                },
                itemBuilder: (context, index) {
                  return buildBoardingItem(boarding[index]);
                },
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 2,
                      dotWidth: 10,
                      spacing: 10,
                      activeDotColor: Colors.blue
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                      {
                      submit();

                      }else{
                      boardController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    }

                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        SizedBox(
          height: 18,
        ),
        Text(
          model.title,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 18,
        ),
        Text(
          model.body,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}

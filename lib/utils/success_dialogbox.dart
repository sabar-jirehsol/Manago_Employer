import 'package:flutter/material.dart';

class FunkyOverlay extends StatefulWidget {
  final String? imagePath;
  final String? message;
  final VoidCallback? onTap;
  final Color? text_color;
  const FunkyOverlay({Key? key, this.imagePath,this.message,this.onTap,this.text_color}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  void dispose(){
    controller!.dispose();  // Dispose the controller before calling super.dispose()
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  // color: Colors.white.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // decoration: const BoxDecoration(
                    //   borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),topLeft: Radius.circular(15)),
                    //   color: Color(0xff7A395E),
                    // ),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    child: Center(
                      child: Image.asset(widget.imagePath!,scale: 3,),
                    ),
                  ),
                  const SizedBox(height: 5,),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(widget.message!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff636363),
                          fontSize: 18,fontWeight: FontWeight.bold
                      ),),
                  ),
                  const SizedBox(height: 15,),
                  const Divider(thickness: 1.2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          widget.onTap!();

                        },
                        child:  Text('OK',
                            style: TextStyle(color:widget.text_color??Color(0xff03BF4E),fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
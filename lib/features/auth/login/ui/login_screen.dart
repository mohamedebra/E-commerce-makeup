import 'package:clippy_flutter/arc.dart';
import 'package:e_commerce_makeup/core/theming/styles.dart';
import 'package:e_commerce_makeup/features/home/ui/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/wedgits/app_text_button.dart';
import '../../../../core/wedgits/app_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<Offset> _animation;
  final GlobalKey _draggableKey = GlobalKey();
  // Initial position
  Offset _position = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _position = _animation.value;
        });
      });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final RenderBox renderBox = _draggableKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // Animate back to original position
    _animation = Tween<Offset>(
      begin: _position,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bachGroundScaffold,
      body: SingleChildScrollView(
        child: Stack(

          children: <Widget>[
            Image(image: const AssetImage('assets/images/images.jpg'),width: 400.w,fit: BoxFit.fill,height: 500.h,),

            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .359,),

                Arc(
                  edge: Edge.TOP,
                  arcType: ArcType.CONVEY,
                  height: 30,
                  child: Container(
                    width: double.infinity,
                    color: ColorsManager.bachGroundScaffold,
                    height: MediaQuery.of(context).size.height * .635,
                  ),
                ),
              ],
            ),
            // Foreground container
            Column(
              children: [
                SizedBox(height: 180.h,),

                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome Back You\'ve \nBeen Missed!',
                          style: TextStyles.font20BlueBold,
                        ),
                        SizedBox(height: 20.h),
                        // Email field
                        // AppTextButton(buttonText: 'Email Address', textStyle: TextStyles.font16BlackSemiBold, onPressed: () {  },),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Email Address',
                                style: TextStyles.font13DarkBlueMedium,
                              ),
                              const TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),

                        AppTextFormField(hintText: '', validator: (String? val ) {  },),
                        SizedBox(height: 10.h),
                        // Password field
                        // TextFormField(decoration: InputDecoration(labelText: 'Password*')),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Password',
                                style: TextStyles.font13DarkBlueMedium,
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        AppTextFormField(hintText: '', validator: (String? val ) {  },),
                        SizedBox(height: 25.h),

                        TextButton(onPressed: (){}, child:
                        Column(
                          children: [
                            Text('Forgot Password?',style: TextStyles.font13DarkBlueMedium,),
                            Container(
                              height: 1.0, // Set height for a horizontal line
                              width: 105.w, // Make it as wide as the parent
                              color: Colors.black, // Line color
                            ),

                          ],
                        )),

                        SizedBox(height: 55.h),
                        // Continue with Google and Apple
                        // TextButton(onPressed: (){}, child: Text('Forgot Password'))

                      ],

                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle sign in
                //   },
                //   child: Text('Sign In'),
                // ),


              ],
            ),

            Column(
              children: [
                SizedBox(height: 550.h,),

                SwipeButton(),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.0, // Set height for a horizontal line
                      width: 100, // Make it as wide as the parent
                      color: Colors.black, // Line color
                    ),
                    Text(' Or Continue With '),
                    Container(
                      height: 1.0, // Set height for a horizontal line
                      width: 100, // Make it as wide as the parent
                      color: Colors.black, // Line color
                    ),
                  ],
                ),

                SizedBox(height: 24.0),
                // Divider(),
                // SizedBox(height: 24.0),
                SignInButton(
                  Buttons.Google,
                  text: "Sign In With Google",
                  onPressed: () {/* Google sign-in logic */},
                ),
                SignInButton(
                  Buttons.Apple,
                  text: "Sign In With Apple",
                  onPressed: () {/* Apple sign-in logic */},
                ),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Not a member? '),
                    TextButton(
                      child: Column(
                        children: [
                          Text('Create an account',style: TextStyles.font13DarkBlueMedium,),
                          Container(
                            height: 1.0, // Set height for a horizontal line
                            width: 105.w, // Make it as wide as the parent
                            color: Colors.black, // Line color
                          ),

                        ],
                      ),
                      onPressed: () {/* Navigate to sign up screen */},
                    ),
                  ],
                ),
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 25),
            //   child: Text('Sign in To\nYour Account',style: TextStyles.font25WhiteSemiBold.copyWith(color: Colors.black.withOpacity(.9)),),
            // ),

          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       // Image.asset('assets/images/download.jpg',),
    //       const SizedBox(
    //         // width: double.infinity,
    //         child: Image(image: AssetImage('assets/images/download.jpg',),width: double.infinity,height: 200,),
    //       ),
    //
    //       Column(
    //         children: [
    //           SizedBox(height: MediaQuery.of(context).size.height * .2,),
    //
    //           Arc(
    //             edge: Edge.TOP,
    //             arcType: ArcType.CONVEY,
    //             height: 30,
    //             child: Container(
    //               width: double.infinity,
    //               color: ColorsManager.bachGroundScaffold,
    //               height: MediaQuery.of(context).size.height * .635,
    //             ),
    //           ),
    //         ],
    //       ),
    //
    //     ],
    //   ),
    // );
  }
}
class SwipeButton extends StatefulWidget {
  const SwipeButton({super.key});

  @override
  _SwipeButtonState createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  double position = 0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.primaryDelta!;
      position = position.clamp(0, MediaQuery.of(context).size.width *.1); // Clamp the dragging position
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      position = 0; // Reset position to start

    });
    if(position == 0){
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeView()));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeView()), (route) => false);

    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Container(
        width: MediaQuery.of(context).size.width *.5, // Subtracting some value to account for padding/margins
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: position), // Use position state to move the button
          child: Row(
            mainAxisSize: MainAxisSize.min, // Constrain the Row's width to its children
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: const Center(child: Icon(Icons.arrow_forward_outlined)),
              ),
              SizedBox(width: 25),
              FittedBox( // Wrap Text with FittedBox to ensure it fits within the available space
                child: Text('Sign in', style: TextStyle(color: Colors.white.withOpacity(.7)), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
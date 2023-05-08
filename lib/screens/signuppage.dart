import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newlogin/model/user_model.dart';
import 'package:newlogin/screens/homepage.dart';

    class registrationscreen extends StatefulWidget {
      const registrationscreen({Key? key}) : super(key: key);
    
      @override
      State<registrationscreen> createState() => _registrationscreenState();
    }
    
    class _registrationscreenState extends State<registrationscreen> {
      final _auth=FirebaseAuth.instance;
      final _formkey= GlobalKey<FormState>();
      final firstnameEditingController= new TextEditingController();
      final lastnameEditingController= new TextEditingController();
      final emailEditingController= new TextEditingController();
      final passwordEditingController= new TextEditingController();
      final confirmpasswordEditingController= new TextEditingController();
      final OTPEditingController= new TextEditingController();

      EmailOTP myauth=EmailOTP();
      bool _isHidden=true;
      bool _isHidden2=true;


      @override
      Widget build(BuildContext context) {
        final firstnameField = TextFormField(
          autofocus: false,
          controller: firstnameEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.name,
          validator: (value){
            RegExp regex=new RegExp(r'^.{3,}$');
            if(value!.isEmpty){
              return("First name cannot be empty");
            }
            if(!regex.hasMatch(value)){
              return("Enter valid name(min. 3 characters");
            }
            return null;
          },
          onSaved: (value)
          {
            firstnameEditingController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon:Icon(Icons.account_circle,color: Color.fromRGBO(77,0,114,1),),
              contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
              hintText: "First Name",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )

          ),
        );
        final lastnameField = TextFormField(
          autofocus: false,
          controller: lastnameEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.name,
          validator: (value){
            if(value!.isEmpty){
              return("last name cannot be empty");
            }
            return null;
          },
          onSaved: (value)
          {
            lastnameEditingController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon:Icon(Icons.account_circle,color: Color.fromRGBO(77,0,114,1),),
              contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
              hintText: "Last Name",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )

          ),
        );
        final emailField = TextFormField(
          autofocus: false,
          controller: emailEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value){
            if(value!.isEmpty){
              return("Enter your email");
            }
            if(!RegExp("^[a-zA-Z0-9+_.-]+@[bitsathy]+.[a-z]").hasMatch(value)){
              return("Please enter a valid email!");
            }
            return null;
          },
          onSaved: (value)

          {
            emailEditingController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon:Icon(Icons.mail,color: Color.fromRGBO(77,0,114,1),),
              contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
              hintText: "Email",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )

          ),
        );
        final passwordField = TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          obscureText: _isHidden,
          validator: (value){
            RegExp regex=new RegExp(r'^.{6,}$');
            if(value!.isEmpty){
              return("Password required");
            }
            if(!regex.hasMatch(value)){
              return("Please enter valid password(Min. 6 character");
            }
          },
          onSaved: (value)
          {
            passwordEditingController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon:Icon(Icons.vpn_key,color: Color.fromRGBO(77,0,114,1),),
              contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
              hintText: "Password",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              suffixIcon: InkWell(
                onTap: _toggleview,
                child: Icon(
                  _isHidden
                      ?Icons.visibility_off
                      :Icons.visibility,
                  color: Color.fromRGBO(77,0,114,1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )

          ),
        );
        final confirmpasswordField = TextFormField(
          autofocus: false,
          controller: confirmpasswordEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          obscureText: _isHidden2,
          validator: (value){
            if(confirmpasswordEditingController.text!= passwordEditingController.text){
              return "Password doesn't match";
            }
            return null;
          },
          onSaved: (value)
          {
            confirmpasswordEditingController.text=value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              prefixIcon:Icon(Icons.vpn_key,color: Color.fromRGBO(77,0,114,1),),
              contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
              hintText: "Confirm Password",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              suffixIcon: InkWell(
                onTap: _toggleview2,
                child: Icon(
                  _isHidden2
                      ?Icons.visibility_off
                      :Icons.visibility,
                  color: Color.fromRGBO(77,0,114,1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )

          ),
        );
        final otpfield = TextFormField(
          autofocus: false,
          controller: OTPEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.number,
          validator: (value){

            if(value!.isEmpty){
              return("Enter OTP");
            }

            return null;
          },
          onSaved: (value)
          {
            OTPEditingController.text=value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon:Icon(Icons.password,color: Color.fromRGBO(77,0,114,1),),
              contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
              hintText: "Enter OTP",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              suffixIcon: TextButton(
                child: Text("Send OTP",style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(8,47,72,1),),),
                onPressed: () async {
                  myauth.setConfig(
                      appEmail: "skasanjai@gmail.com",
                      appName: "MyClass",
                      userEmail: emailEditingController.text,
                      otpLength: 6,
                      otpType: OTPType.digitsOnly
                  );
                  if (await myauth.sendOTP() == true) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      content: Text("OTP has been sent"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      content: Text("Oops, OTP send failed"),
                    ));
                  };
                }
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )

          ),
        );
        final signupButton = Material(
          elevation: 0.0,
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(8,47,72,1),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20,15,20,15),
            minWidth: MediaQuery.of(context).size.width,

            onPressed:() async{
              signUp(emailEditingController.text, passwordEditingController.text);
              if (await myauth.verifyOTP(otp: OTPEditingController.text) == true) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                ));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  content: Text("Invalid OTP"),
                ));
              }
            } ,
            child: Text("Verify and SignUp",textAlign: TextAlign.center,
              style:TextStyle(fontSize: 15,fontFamily:'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,

            ),
          ),

        );
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title:
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Sign Up',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(width: 2,),
                    Icon(Icons.person_outline,color: Colors.black,)
                  ],
                ),
                SizedBox(height: 2,),
                Text('Welcome to BIT',style: TextStyle(fontSize: 12,fontFamily: 'Arimo',fontWeight: FontWeight.w100,color: Colors.black45),textAlign: TextAlign.left,)
              ]
          ),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            shadowColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child:Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formkey ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        firstnameField,
                        SizedBox(height: 20),
                        lastnameField,
                        SizedBox(height: 20),
                        emailField,
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        confirmpasswordField,
                        SizedBox(height: 20),
                        otpfield,
                        SizedBox(height: 20),
                        signupButton,
                        SizedBox(height: 10)

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      void _toggleview(){
        setState(() {
          _isHidden=!_isHidden;
        });
      }
      void _toggleview2(){
        setState(() {
          _isHidden2=!_isHidden2;
        });
      }
      void signUp(String email,String password) async
      {
        if(_formkey.currentState!.validate())
          {
              await _auth.createUserWithEmailAndPassword(email: email, password: password)
                  .then((value) => {
                    passDetailsToFirestore()
              }).catchError((e)
              {
                Fluttertoast.showToast(msg: e!.message);
              });
          }
      }
  passDetailsToFirestore() async{
        //calling firestore
    //calling user model
    //calling values
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User? user=_auth.currentUser;
    UserModel userModel=UserModel();
    userModel.email=user!.email;
    userModel.uid=user!.uid;
    userModel.firstname=firstnameEditingController.text.trim();
    userModel.lastname=lastnameEditingController.text.trim();

    await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully !!");
    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context)=>Homescreen()),
            (route) =>false);

  }
    }
    
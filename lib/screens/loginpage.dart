import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newlogin/admin/adminhomescrn.dart';
import 'package:newlogin/screens/homepage.dart';
import 'package:newlogin/screens/resetpswrd.dart';
import 'package:newlogin/screens/signuppage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInscrn extends StatefulWidget {
  const SignInscrn({Key? key}) : super(key: key);

  @override
  State<SignInscrn> createState() => _SignInscrnState();
}

class _SignInscrnState extends State<SignInscrn> {
  final _formkey= GlobalKey<FormState>();
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  bool loading = false;
  final _auth=FirebaseAuth.instance;
  bool _isHidden=true;
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      style: TextStyle(fontFamily: 'Arimo'),
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return("Please Enter your email");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[bitsathy]+.[a-z]").hasMatch(value)){
          setState(() {
            loading=false;
          });
          return("Please enter a valid email!");
        }
        return null;
      },
      onSaved: (value)
      {
        emailcontroller.text=value!;
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
      controller: passwordcontroller,

      style: TextStyle(fontFamily: 'Arimo'),
      obscureText: _isHidden,
      validator: (value){
        RegExp regex=new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          setState(() {
            loading=false;
          });
          return("Password required");
        }
        if(!regex.hasMatch(value)){
          setState(() {
            loading=false;
          });
          return("Please enter valid password (Min. 6 character)");
        }
      },
      onSaved: (value)
      {
        passwordcontroller.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key,color: Color.fromRGBO(77,0,114,1),),
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
     final forgot=InkWell(
       child:Padding(
         padding: EdgeInsets.only(left:150),
       child: Text("Forgot password?",style: TextStyle(decoration:TextDecoration.underline,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
       ),
       onTap: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>resetpswrd()));
       },
     );
    final loginButton = Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(8,47,72,1),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        child: loading? SizedBox( height:22,width: 22,child:CircularProgressIndicator(color: Colors.white,)): Text("Login",textAlign: TextAlign.center,
          style:TextStyle(fontSize: 15,fontFamily:'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
        ),
        onPressed:(){

          if((emailcontroller.text=='jashwanthkumar.ad21@bitsathy.ac.in') && (passwordcontroller.text=='123456')){
            Fluttertoast.showToast(msg: "Welcome ADMIN");
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>adminhome()));
          }
          else {

            signIn(emailcontroller.text, passwordcontroller.text);
          }
        } ,

      ),

    );
    return Scaffold(
      appBar: AppBar(title:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Login',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.black),),
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
          child:SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 200,
                      child: Image.asset("assets/bitlogo.png",
                      fit: BoxFit.contain,
                      )),
                  SizedBox(height: 25),
                  Text("Enter Your Bitsathy Account",style: TextStyle(fontSize: 17,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color:Color.fromRGBO(8,47,72,1), ),),
                  SizedBox(height: 25),
                  emailField,
                  SizedBox(height: 25),
                  passwordField,
                  SizedBox(height: 10),
                  forgot,
                  SizedBox(height: 15,),
                  loginButton,
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child:
                      Divider(color: Colors.black38,indent: 10,endIndent: 10,),),
                      Text('Or',style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black38,fontFamily: 'Arimo'),),
                      Expanded(child:
                      Divider(color: Colors.black38,indent: 5,endIndent: 5))
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?",style: TextStyle(fontFamily:'Arimo',fontWeight:FontWeight.w900)),
                      GestureDetector(onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>registrationscreen()));
                      },
                      child: Text(" SignUp",

                          style: TextStyle(color:Colors.blue[800],fontFamily:'Arimo',fontWeight: FontWeight.bold,fontSize: 14)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

        ),
        )
    );
  }
  void _toggleview(){
    setState(() {
      _isHidden=!_isHidden;
    });
  }
  void signIn(String email,String password) async
  {
    setState(() {
      loading=true;
    });
    if(_formkey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "Login successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Homescreen())),

      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
        setState(() {
          loading=false;
        });
      });
    }
  }
}

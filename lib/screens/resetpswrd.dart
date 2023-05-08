import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class resetpswrd extends StatefulWidget {
  const resetpswrd({Key? key}) : super(key: key);

  @override
  State<resetpswrd> createState() => _resetpswrdState();
}

class _resetpswrdState extends State<resetpswrd> {
  final _auth=FirebaseAuth.instance;
  final firstnameEditingController= new TextEditingController();
  final _formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstnameEditingController,
      style: TextStyle(fontFamily: 'Arimo'),
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return("Please enter your email");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[bitsathy]+.[a-z]").hasMatch(value)){
          return("Please enter a valid email!");
        }
        return null;
      },
      onSaved: (value)
      {
        firstnameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(Icons.mail,color: Color.fromRGBO(77,0,114,1),),
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Enter your email",
          hintStyle: TextStyle(fontFamily: 'Arimo'),


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
          if(_formkey.currentState!.validate()){
            _auth.sendPasswordResetEmail(email: firstnameEditingController.text);
            Fluttertoast.showToast(msg: "Reset link has been sent to your email id !!");}
        } ,
        child: Text("Send Request",textAlign: TextAlign.center,
          style:TextStyle(fontSize: 15,fontFamily:'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,

        ),
      ),

    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("RESET PASSWORD",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
        ),
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
    SizedBox(height: 20),
    firstnameField,
    SizedBox(height: 20),
    signupButton,
    ]
        )
    )
    )
        )
    )
        )
    );
  }
}

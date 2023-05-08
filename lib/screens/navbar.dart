import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newlogin/model/user_model.dart';
import 'package:newlogin/screens/loginpage.dart';
import 'package:newlogin/screens/requeststs.dart';
import 'package:newlogin/screens/userhistory.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);
  @override
  State<navbar> createState() => _navbarState();
}
class _navbarState extends State<navbar> {
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: Text("${loggedInUser.firstname} ${loggedInUser.lastname}",style: TextStyle(fontFamily: 'Arimo'),), accountEmail: Text("${loggedInUser.email}",style: TextStyle(fontFamily: 'Arimo'),)),
          ListTile(
            leading: Icon(Icons.work_history_rounded,color: Color.fromRGBO(77,0,114,1),),
            title: Text('Request status',style: TextStyle(fontFamily: 'Arimo'),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>requeststatus()));
            },
          ),
          ListTile(
            leading: Icon(Icons.history,color: Color.fromRGBO(77,0,114,1),),
            title: Text('History',style: TextStyle(fontFamily: 'Arimo'),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>historyuser()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout,color: Color.fromRGBO(77,0,114,1),),
            title: Text('Logout',style: TextStyle(fontFamily: 'Arimo'),),
            onTap: (){
              logout(context);
            },
          ),
        ],
      ),
    );
  }
    Future<void> logout(BuildContext context) async{
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignInscrn()));
    }
}
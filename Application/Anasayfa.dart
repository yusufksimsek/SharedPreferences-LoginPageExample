import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_loginuygulamasi/Application/main01.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late String spUserName;
  late String spPassword;

  Future<void> readSessionInfo() async{

    var sp = await SharedPreferences.getInstance();

    setState(() {
      spUserName = sp.getString("userName") ?? ("Invalid Username")!;
      spPassword = sp.getString("passWord") ?? ("Invalid Password")!;

    });

  }

  Future<void> Exit() async{

    var sp = await SharedPreferences.getInstance();

    sp.remove("userName");
    sp.remove("passWord");

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

  }

  @override
  void initState() {
    super.initState();
    readSessionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Main Page"),
        actions: [
          IconButton(
              onPressed: (){
                Exit();
              },
              icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Welcome, Login Successful",style: TextStyle(fontSize: 30),),
            ),
            Text("Username: $spUserName",style: TextStyle(fontSize: 30),),
            Text("Password: $spPassword",style: TextStyle(fontSize: 30),),
          ],
        ),

      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_loginuygulamasi/Application/Anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> SessionControl() async{

    var sp = await SharedPreferences.getInstance();


    String spUserName = sp.getString("userName") ?? ("Invalid Username")!;
    String spPassword = sp.getString("passWord") ?? ("Invalid Password")!;

    if(spUserName == "admin" && spPassword =="123" ){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home:  FutureBuilder<bool>(
        future: SessionControl(),
        builder: (context,snapshot){
          if(snapshot.hasData){
          bool? passPermit = snapshot.data;
          return passPermit==true ? MainPage() : LoginPage();
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var tfUsername = TextEditingController();
  var tfPassword = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> LoginControl() async{
    var un = tfUsername.text;
    var pw = tfPassword.text;

    if(un=="admin" && pw=="123"){

      var sp = await SharedPreferences.getInstance();

      sp.setString("userName", un);
      sp.setString("passWord", pw);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Error, Plesae Try Again",style: TextStyle(fontSize: 15),),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom:ekranYuksekligi/20),
                child: SizedBox(
                    width: ekranGenisligi/4,
                    height: ekranYuksekligi/6,
                    child: Image.asset("resimler/logo.png")
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(ekranYuksekligi/30),
                child: TextField(
                  controller: tfUsername,
                  decoration: InputDecoration(
                    hintText: "Username",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(ekranYuksekligi/30),
                child: TextField(
                  controller: tfPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(ekranYuksekligi/30),
                child: SizedBox(
                  width: ekranGenisligi/1.2,
                  height: ekranYuksekligi/12,
                  child: TextButton(
                    child: Text("Login",style: TextStyle(fontSize: ekranGenisligi/25,color: Colors.white,),),
                    onPressed: (){
                      LoginControl();
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.pink),

                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}

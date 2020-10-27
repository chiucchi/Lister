import 'package:flutter/material.dart';
import 'package:lister/screens/mainPage.dart';
import 'package:lister/services/user_service.dart';
import 'models/user.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 16, bottom: 10),
                child: Container(
                  width: 200.0,
                  height: 70.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "LISTER",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 290.0,
                height: 40.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Your #1 organizational app",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 16,
                    bottom: MediaQuery.of(context).size.height / 35),
                child: Container(
                  height: 240.0,
                  width: MediaQuery.of(context).size.width,
                  child: new Image.asset('assets/images/lifebalance.png'),
                ),
              ),
              Container(
                width: 250.0,
                height: 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Create tasks and\nmanage your daily time",
                        style: TextStyle(
                          fontSize: 23.0,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10,
                    left: 10.0,
                    right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 145.0,
                      height: 45.0,
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text("Log in",
                            style: TextStyle(
                                fontSize: 23.0, color: Colors.purple[900])),
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.purple[900]),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    Container(
                      width: 145.0,
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignPage()),
                          );
                        },
                        child: Text("Sign up",
                            style:
                                TextStyle(fontSize: 23.0, color: Colors.white)),
                        color: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController user_Name_controller = new TextEditingController();
  TextEditingController username_controller = new TextEditingController();
  TextEditingController userpassword_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LISTER", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: user_Name_controller,
                      decoration: InputDecoration(
                        labelText: "Your name",
                        labelStyle: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    TextFormField(
                      controller: username_controller,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    TextFormField(
                      controller: userpassword_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      width: 330.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () async {
                          var userObject = User();
                          userObject.name = user_Name_controller.text;
                          userObject.username = username_controller.text;
                          userObject.password = userpassword_controller.text;

                          var _userService = UserService();
                          var result = await _userService.saveUser(userObject);
                          if (result > 0) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage()),
                            );
                            print("user criado\n");
                          }
                        },
                        child: Text("Sign up",
                            style:
                                TextStyle(fontSize: 23.0, color: Colors.white)),
                        color: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username_controller = new TextEditingController();
  TextEditingController userpassword_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LISTER", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: username_controller,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    TextFormField(
                      controller: userpassword_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      width: 330.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () async {
                          var _userService = UserService();
                          var result = await _userService.readUser(username_controller.text,userpassword_controller.text);
                          if (result != null)
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                            print("user logou\n");
                          
                        },
                        child: Text("Log in",
                            style:
                                TextStyle(fontSize: 23.0, color: Colors.white)),
                        color: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

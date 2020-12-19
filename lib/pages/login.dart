import 'package:flutter/material.dart';
import '../pages/menus.dart';
import '../view%20models/menudata_list_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
  }


  var _formKey = GlobalKey<FormState>(); 
  
 

   Future<bool> loginUser(String phone, BuildContext context)async{

    final isValid = _formKey.currentState.validate(); 
      if (!isValid)
      { 
        return false; 
      } 
      _formKey.currentState.save(); 
    

    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber:"+91"+phone, // hardcoded the country Number
        timeout: Duration(seconds: 120),

        verificationCompleted: (PhoneAuthCredential credential)async {
          Navigator.of(context).pop();
            UserCredential result = await _auth.signInWithCredential(credential);
            User user = result.user;
          if(user != null)
          {

            Provider.of<MenuListViewModel>(context,listen:false).fetchMenuCategory();
            Navigator.push(context, MaterialPageRoute( builder: (context) => MenuPage()));
          }
          else
          {
            print("Error");
          }
          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception){
          
          print(exception);

          if(exception.code == 'invalid-phone-number')
          {
              print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, [int resendToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give The Verification Code?", style:TextStyle(fontSize:13)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      
                      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                      UserCredential result = await _auth.signInWithCredential(credential);

                      User user = result.user;
                      if(user != null){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MenuPage()
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
      codeAutoRetrievalTimeout: (String verificationId){ 
            verificationId = verificationId;     
            print(verificationId);           
            print("Timout");         
        }
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken,  idToken: googleAuth.idToken);
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user;
          if(user != null)
          {
            Provider.of<MenuListViewModel>(context,listen:false).fetchMenuCategory();
            Navigator.push(context, MaterialPageRoute( builder: (context) => MenuPage()));
          }
  }

  Widget _phoneNUmberWidget(){
    return Container(
      padding: EdgeInsets.only(top:30),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 10),
          Form(
          key: _formKey,
         child: TextFormField(
              controller: _phoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true
                  ),
                   onFieldSubmitted: (value) { 
                  //Validator 
                }, 
                validator: (value){

                  if(value.isEmpty){ 
                    return 'Please Enter a Number'; 
                  } 
                  if(value.length != 10)
                      return 'Please Enter valid Phone Number'; 
                      return null; 
                 },
                )
              ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.green
              ),
          child: Text('Login',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        onTap: () {
        _phoneNumber.text.trim();
          loginUser(_phoneNumber.text,context);
        });
  }

Widget _googleButton(){
    return GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width/1,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.blue),
          child: Text('Google', style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        onTap:(){
          signInWithGoogle();
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
          child: Container(
      height: height,
      child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _phoneNUmberWidget(),
                    SizedBox(height: 20),
                    _submitButton(context),
                      SizedBox(height: 10),
                      Center(child: Text("Or",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                      SizedBox(height: 10),
                      _googleButton()
                  ],
                ),
              ),
            ),
          ],
      ),
    ),
        ));
  }
}

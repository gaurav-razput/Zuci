import 'package:flutter/material.dart';
import 'package:zuci/Payment/rezorPay.dart';

class Coins extends StatefulWidget {
  final coins;
  final uid;
  Coins({this.coins,this.uid});
  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {

  final _formKey = new GlobalKey<FormState>();

  String _coins;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  int cal_amount(String amount){
    var rup  =int.parse(amount);
    return rup*10 ;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(18),
            width: double.infinity,
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Available Coins",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.coins}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                    child: Text(
                      "Additional free VIP duration can be accumulated",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('10 Rs - 100 coins',style: TextStyle(fontSize: 25.0),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    size.width * .03,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Amount",
                      labelStyle: TextStyle(fontSize: 16.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      prefixIcon: Icon(
                        Icons.add,
                        color: Color(0xFFC84EA1),
                        size: size.height * .03,
                      ),
                    ),
                    validator: (value) => value.isEmpty
                        ? 'Can\'t be empty'
                        : int.parse(value)>=10?null:'Amount Should be Grreater than 10',
                    onSaved: (value) => _coins = value.trim(),
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                Center(
                  child:InkWell(
                    onTap: () {
                      if(validateAndSave()){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>payment(amount: cal_amount(_coins).toString(),)));
                      }
                    },
                    child: Container(
                      height: size.height * .042,
                      width: size.width * .50,
                      child: Center(
                        child: Text(
                          'Buy',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.white10,
                        ),
                        // color: Colors.black26,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.2, 1],
                          colors: [Color(0xFFB44EB1), Color(0xFFDA4D91)],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}

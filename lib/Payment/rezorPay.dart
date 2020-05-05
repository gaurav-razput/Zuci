import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/firebase_methods.dart';

class payment extends StatefulWidget {
  final amount;
  final uid;
  payment({this.amount,this.uid});
  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  FirebaseMethods firebaseMethods=FirebaseMethods();
  Razorpay _razorpay;
  bool payment_done;

  void payment_success(){

  }
  void initState() {
    payment_done=false;
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1TtO964PhFsoKY',
      'amount': int.parse(widget.amount)*10,
      'name': 'Zuci',
      'description': 'Coins',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
    setState(() {
      payment_done=true;
      UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
      firebaseMethods.addCoin(userProvider.getUser, int.parse(widget.amount)).whenComplete((){
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Stack(
        children: <Widget>[
          payment_done?Center(
            child:Text('Payment Success')
          ):
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("You Get ${widget.amount} Coins"),
                SizedBox(height: 7.0,),
                Text("Total Payable Amount ${int.parse(widget.amount)/10} "),
                SizedBox(height: 50.0,),
                InkWell(
                  onTap: () {
                    openCheckout();
                  },
                  child: Container(
                    height: size.height * .042,
                    width: size.width * .50,
                    child: Center(
                      child: Text(
                        'Make Payment',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

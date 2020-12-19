import 'package:flutter/material.dart';
import 'package:meachine_test/pages/menus.dart';
import 'package:meachine_test/view%20models/menudata_list_view_model.dart';
import 'package:meachine_test/widgets/increment_decrement.dart';
import 'package:provider/provider.dart';

class OrderSummaryPage extends StatefulWidget {
  OrderSummaryPage();
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {


  @override
  void initState(){

    super.initState();
  }



  @override
  Widget build(BuildContext ctxt) {
    return Consumer<MenuListViewModel>(builder: (context, model, child){
      
      return new Scaffold(
          appBar: new AppBar(title: Text("Order Summary")),
          body: SingleChildScrollView(child:  Container(
              child: Column(
              children: [
                Container(
                  child: Card(
              elevation: 5.0,
              margin: new EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0, right:8.0),
              child: 
              ListView.builder(
                      physics: NeverScrollableScrollPhysics(), 
                    shrinkWrap: true,
                    itemCount: model.cartItems.length,
                    itemBuilder: (context, buildIndex){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    new Icon(Icons.adjust_outlined, color: model.cartItems[buildIndex].dishType == 1  ? Colors.red : Colors.green),
                                    Text('${model.cartItems[buildIndex].dishName}', style: TextStyle(fontWeight: FontWeight.w500))
                                  ]),
                              SizedBox(height: 5),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>
                                  [
                                    Padding( padding: const EdgeInsets.only(right: 10), child: Text( '${model.cartItems[buildIndex].dishCalories} calories', style: TextStyle( fontWeight: FontWeight.w500))),
                                    Text('INR ${model.cartItems[buildIndex].dishPrice}', style: TextStyle(fontWeight: FontWeight.w500)),
                                  ]),
                              SizedBox(height: 10),
                              SizedBox(
                                  width: 100.0,
                                  child: IncrementDecrementWidget(
                                  model.cartItems[buildIndex].itemCount,
                                  onIncrement: () 
                                  {
                                    model.increment(model.cartItems[buildIndex]);
                                  }, onDecrement: (){
                                    model.decrement(model.cartItems[buildIndex]);
                                  })
                                ),
                            ]),
                          );
                        }
                      )
                    ),
                ) ,
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Total Amount",style: TextStyle(fontWeight: FontWeight.w500,fontSize:15.0)),
                      Text("${model.totalAmout}",style: TextStyle(fontWeight: FontWeight.w500,fontSize:15.0))
                      ],
                      ),
                    ),
                new Container(
                    
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[

                  new Container(
                  width: MediaQuery.of(context).size.width/1,
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal:20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: new GestureDetector(
                   onTap:()
                   {
                    showDialog( context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return aleartshow();
                    });
                   },
                   child: new Material(
                   color: Colors.green,
                   borderRadius: new BorderRadius.circular(30),
                       child: new Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>
                       [
                         Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Place Order', style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white)),
                         ),
                       ],
                      )
                      ),
                      ),
                      ),
                    ],
                  ) ,
                )
                ],)
               )
              ),
             );
            });
  }

    Widget aleartshow (){
                return AlertDialog(
                title: Text("Order successfully placed" ,style: TextStyle(fontWeight: FontWeight.w500,fontSize:13.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () async
                    {
                      Provider.of<MenuListViewModel>(context,listen: false).removeCart();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => MenuPage(null)));
                    },
                  )
                ],
              );
            }



  
}


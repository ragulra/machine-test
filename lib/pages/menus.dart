
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/tableMeanuList.dart';
import '../pages/orderSummary.dart';
import '../view%20models/menudata_list_view_model.dart';
import '../widgets/Drawer.dart';
import '../widgets/increment_decrement.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  @override 
  _MenuPageState createState() => _MenuPageState(); 
}

class _MenuPageState extends State<MenuPage> {


  @override
  void initState()
  {
    super.initState();
  }
  
    @override
    Widget build(BuildContext ctxt) {
      return
         Consumer<MenuListViewModel>(builder: (context,model, child){ 

           return DefaultTabController(
            length: model.menuList.length,
            child: new Scaffold(
              drawer: MenuDrawer(model.user),
              appBar: new AppBar(
                
                actions:[
                  Stack(
                    children:[
                      IconButton( icon: Icon(Icons.shopping_cart),  onPressed: () => {
                        if(model.cartItems.length > 0)
                        {
                          Navigator.push(context, MaterialPageRoute( builder: (context) => OrderSummaryPage()))
                        }
                       }
                      ),
                   model.cartItems.length > 0 ?   new Positioned(
                      right: 2.0,
                      top: 10.0,
                       child: new Container(
                      height: 20,
                      width:20,
                      decoration: 
                      BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(),
                        color: Colors.redAccent,
                      ),
                      child: Center(child: Text("${model.cartItems.length}", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white))))
                     ): SizedBox()
                    ] 
                  )
                ],
                bottom: new TabBar(
                  isScrollable: true,
                    tabs: List<Widget>.generate(model.menuList.length, (int index)
                    {
                    return new Tab(
                      text: "${model.menuList[index].menuCategory}",
                    );
                   }),
                ),
            ),
        body: new TabBarView(
             children: List<Widget>.generate(model.menuList.length, (int index){
              
                return  ListView.builder(
                    itemCount: model.menuList[index].categoryDishes.length,
                    itemBuilder: (context, buildIndex) {
                      var item = model.menuList[index].categoryDishes[buildIndex];
                      return Column(
                        children: [
                          Padding(
                            padding:  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                            child: _listTime(item,model)
                          ),
                          Divider()
                        ],
                      );
                    });
             }),
          )
        )
         );
        }
       );
      
  }


  Widget _listTime(CategoryDishes pos,MenuListViewModel model){

   

    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>
                [
                new Icon(Icons.adjust_outlined , color:pos.dishType == 1 ? Colors.red: Colors.green),
                  Text('${pos.dishName}', style: TextStyle(fontWeight: FontWeight.w500))
                ]),
                SizedBox(height:5),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                  Text('INR ${pos.dishPrice}', style: TextStyle(fontWeight: FontWeight.w500)),
                  Padding(
                    padding:  const EdgeInsets.only(right:10),
                    child:Text('${pos.dishCalories} calories' , style: TextStyle(fontWeight: FontWeight.w500))
                    ),

                ]),
                SizedBox(height:10),
                Text("${pos.dishDescription}", style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height:8),                 

                SizedBox(
                width:100.0,
                child: IncrementDecrementWidget(
                        pos.itemCount,
                        onIncrement:()
                        {
                          model.increment(pos);
                        // print(double.parse((SharedManager.shared.cartItemes[index].itemPricing)).toStringAsFixed(2));
                        },
                        onDecrement:()
                        {  
                            model.decrement(pos);
                        })
                    ),
                    SizedBox(height:5), 
                    pos.addonCat.length > 0 ? Text("Customizations available",style: TextStyle(fontWeight: FontWeight.w500, color:Colors.redAccent) ) : SizedBox(),
                ],
              )),
          Expanded(
             flex: 2,
             child: Container(
                    height: 100,
                    width: 150,
                    color: Colors.white,
                    child:  FadeInImage(
                    image: NetworkImage(pos.dishImage != null && pos.dishImage != "" ? pos.dishImage : ''),
                    placeholder: AssetImage('Assets/food.jpeg'),
                ),
             ) 
          ),
        ],
      ),
    );
  }
}



// final FirebaseAuth _auth = FirebaseAuth.instance;
// User user;
// Provider.of<MovieListViewModel>(context, listen: false).fetchMovies("batman");

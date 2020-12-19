import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meachine_test/models/tableMeanuList.dart';
import 'package:meachine_test/services/webservice.dart';


class MenuListViewModel extends ChangeNotifier {

  List<TableMenuList> _menuListData =  List<TableMenuList> (); 
  List<CategoryDishes> _cartItems =  List<CategoryDishes> (); 
  dynamic _totalAmout;


  User _user; 

  User get user => _user = FirebaseAuth.instance.currentUser;

  set user(User user){
    _user = user;
    notifyListeners();
  }




  dynamic get totalAmout => _totalAmout;

  set totalAmout(dynamic totalAmout) {
    _totalAmout = totalAmout;
    notifyListeners();
  }

  Future<void> fetchMenuCategory()async {
    final results =  await Webservice().fetchMenListData();
    menuList = results.tableMenuList;
  }

  List<TableMenuList> get menuList => this._menuListData;
  
  set menuList(val){
      this._menuListData = val;
      notifyListeners();
    }

  List<CategoryDishes> get cartItems => this._cartItems;
        set cartItems(val){
        this._cartItems = val;
        notifyListeners();
    }

    increment(CategoryDishes pos){
        pos.itemCount++;
        pos.isAdded = true;
       final result = _cartItems.indexWhere((item) => item.dishId == pos.dishId);
        if(result == -1 )
        {
          _cartItems.add(pos);
        }
        else
        {
          _cartItems[result] = pos;
        }
      getTotalAmout();
      notifyListeners();
    }

    decrement(CategoryDishes pos)
    {
        final result = _cartItems.indexWhere((item) => item.dishId == pos.dishId);
          if (pos.itemCount != 0)
          {
              pos.itemCount--;
              if(pos.itemCount == 0 && result != -1)
              {
              _cartItems.removeAt(result);
              }
              else
              {
              _cartItems[result] = pos;
              }
          }
          else
          {
            pos.isAdded = false;
          }
          getTotalAmout();
        notifyListeners();
    }
    
    getTotalAmout()
    {
      totalAmout = _cartItems.fold(0, (previous, current) => previous + (current.dishPrice * current.itemCount));
    }
    removeCart(){
        totalAmout = null;
        _cartItems.clear();
        fetchMenuCategory();
    }
}

import 'package:flutter/material.dart';
import 'package:formvalidations/src/bloc/login_bloc.dart';
export 'package:formvalidations/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{
  static Provider? _instancia;

  factory Provider({Key? key, required Widget child}){
   final instancia= _instancia ??= Provider._internal(key:key ,child:child );
   return instancia;

  }
  Provider._internal({Key? key, required Widget child})
   : super(key: key, child:child);


   final loginBloc = LoginBloc();
//  
 /* Provider({Key? key, required Widget child}) 
  : super(key: key, child: child); */

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc;
  }
}
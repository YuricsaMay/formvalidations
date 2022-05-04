import 'dart:async';

class Validation{

  final valPassword= StreamTransformer<String, String>.fromHandlers(
    handleData:(password, sink){
      if(password.length>=6){
        sink.add(password);
      } else{
        sink.addError('Más de de seis caracteres por favor');
      }
    }
  ); 

  final valEmail= StreamTransformer<String, String>.fromHandlers(
    handleData:( email, sink ){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern.toString());

      if( regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Email no es correcto');
      }
    
    
    }
  );
  
}
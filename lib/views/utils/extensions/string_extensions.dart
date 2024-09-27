import 'package:fluttertoast/fluttertoast.dart';

extension StringExtensions on String {

  double toDouble() => double.parse(this);
  int toInt()=> int.parse(this);
  Uri toUri()=> Uri.parse(this);

  Future<bool?> showToast()=> Fluttertoast.showToast(msg: this);

  replaceItems( int items,{String? replace,}){
    return replaceRange(0, items, replace??'XXXXXXXX');
  }

  String? defaultValidator() {
    if (isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  String? emailValidator(){
    if (isEmpty) {
      return 'Email is Required';
    }
    if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this)) {
      return 'Please enter a valid email Address';
    }
    return null;
  }

  String? phoneValidator(){
    if(!phoneRegExp.hasMatch(this)){
      return "Please enter a valid number";
    }else{
      return null;
    }
  }

  // static var phoneREg = RegExp("^([0|\+[0-9]{1,5})?([7-9][0-9]{9})");

  static var pinRegExp = RegExp("[1-9][0-9]{5}");
  static var phoneRegExp = RegExp("[1-9][0-9]{9}");
  String? pinCodeValidator(String title){
    if(!pinRegExp.hasMatch(this)){
      return "Please enter a valid $title";
    }

    else{
      return null;
    }
  }
  String? ageValidator(){
    if(isEmpty){
      return "Please enter age";
    }else {
      return null;
    }
  }
}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../components/rounded_reusable_button.dart';
import '../../components/searchable_dropDown.dart';
import '../../controllers/registration_controller.dart';
import '../../utils/alert.dart';
import '../../utils/color_constants.dart';
//new commit
class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen_id';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends StateMVC<RegisterScreen>  {

  RegistrationController? _con;
  _RegisterScreenState() : super(RegistrationController()) {
    _con = controller as RegistrationController?;
  }

  dynamic height,width;
  bool nameError = false, emailError = false, mobileError = false, registerPasswordError=false, confirmPasswordError=false,
       companyNameError = false,
       firmTypeError = false, firmSizeError = false,gstError=false;
  String mobileText = '', emailText = '',confirmText='',gstText='';
 bool _passwordVisible = true, _confirmpasswordVisible =true;



 int? mob_maxlen=10;
 int? mob_minlen;

  @override
  void initState() {
    super.initState();
    _con!.registerLoadFirmSize(context);
    _con!.registerLoadFirmType(context);
    //_passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _con!.scaffoldKey,
      backgroundColor: const Color(0xffFfffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFfffff),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE8EBEE)
            ),
            child: const Center(
              child: Icon(Icons.arrow_back,color: Color(0xff333537),),
            ),
          ),
        ),
        title: const Text('Register',style: TextStyle(color: Color(0xff333537)),),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(

           physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Get Started',style: TextStyle(color: Color(0xff1E3852),fontSize: 22,fontWeight: FontWeight.bold),),
                ),
              ),
              const SizedBox(height: 5,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Let’s start by creating your account',style: TextStyle(color: Color(0xffF8A339),fontSize: 15),),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: TextFormField(
                  controller: _con!.signUpName,
                    keyboardType:TextInputType.visiblePassword,
                  style: const TextStyle(fontSize: 18),

                  //keyboardType: TextInputType.text,
                  decoration: const InputDecoration(

                      border: InputBorder.none,
                      hintText: 'Full Name',hintStyle: TextStyle(
                      fontSize: 14,color: Colors.grey
                  )),
                ),
              ),
              nameError ?
              errorText('Please enter your name') : const SizedBox(),

              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: TextFormField(
                  controller: _con!.signUpEmail,
                  style: const TextStyle(fontSize: 18),
                  keyboardType:TextInputType.visiblePassword,
                  //keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',hintStyle: TextStyle(
                      fontSize: 14,color: Colors.grey
                  )),
                ),
              ),
              emailError ?
              errorText(emailText) : const SizedBox(),

              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: GestureDetector(
                  onTap: (){
                    showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        countryListTheme: const CountryListThemeData(
                          bottomSheetHeight: 530,
                        ),
                        onSelect: (value){
                          setState(() {
                            _con!.countryCodes=value;

                            print( _con!.countryCodes);

                            if(_con!.countryCodes.countryCode == 'IN'){

                              mob_maxlen=10;
                              registerPasswordError=false;

                            }else{
                              mob_maxlen=12;
                              mob_minlen=6;

                            }

                          });
                        }
                    );
                  },
                  child: Row(
                    children: [

                      SizedBox(
                        // color: Colors.green,
                        width: 50,//MediaQuery.of(context).size.width*0.15,
                        height: MediaQuery.of(context).size.height*0.06,
                        child: Center(child: Text("${_con!.countryCodes.flagEmoji}+${_con!.countryCodes.phoneCode}",)),
                      ),
                      Icon(Icons.arrow_drop_down),

                      Container(
                        color: const Color(0xff1E3852),
                        width: 1,
                        height: 30,
                      ),
                      Container(
                        // color: Colors.yellow,
                        width: MediaQuery.of(context).size.width*0.6,
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length<mob_minlen!){
                              _con!.signupmobile=value;
                              setState(() {  mobileError = true;
                              mobileText = 'Mobile number  must be at least $mob_minlen digits.'; });

                            }
                            else{
                              setState(() {
                                mobileError = false;
                              });
                            }

                          },
                          controller: _con!.signUpMobile,
                          style: const TextStyle(fontSize: 18),

                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
                            LengthLimitingTextInputFormatter(mob_maxlen)

                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone number',hintStyle: TextStyle(
                              fontSize: 14,color: Colors.grey
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              mobileError ?
              errorText(mobileText) : const SizedBox(),


              _con!.countryCodes.countryCode == 'IN' ? SizedBox():
              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: TextFormField(
                  controller: _con!.signUpPassword,
                  obscureText: _passwordVisible,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.text,
                  decoration:InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',hintStyle: TextStyle(
                      fontSize: 14,color: Colors.grey,

                  ),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }, icon: _passwordVisible ?Icon(Icons.visibility_off
                  ): Icon(Icons.visibility), color: kBlueGrey//Theme.of(context).primaryColorDark,

                  )

                  ),

                ),
              ) ,
              registerPasswordError ?
              errorText("Please enter password") : const SizedBox(),



              _con!.countryCodes.countryCode == 'IN' ? SizedBox():
              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: TextFormField(
                  controller: _con!.confirmPassword,
                  obscureText:_confirmpasswordVisible ,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',hintStyle: TextStyle(
                      fontSize: 14,color: Colors.grey
                  ),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      _confirmpasswordVisible=!_confirmpasswordVisible;
                    });
                  }, icon:_confirmpasswordVisible?Icon(Icons.visibility_off):Icon(Icons.visibility),color: kBlueGrey//Theme.of(context).primaryColorDark,
                  )


                  ),

                ),
              ) ,


              confirmPasswordError ?
              errorText(confirmText) : const SizedBox(),







              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: TextFormField(
                  controller: _con!.signUpCompanyName,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.visiblePassword,
                  //keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Company’s Name',hintStyle: TextStyle(
                      fontSize: 14,color: Colors.grey
                  )),
                ),
              ),
              companyNameError ?
              errorText("Please enter company name") : const SizedBox(),

              SizedBox(height: 15,),
              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchableDD(
                  hintText: 'Firm Type',
                  //hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                  label: 'Firm Type',
                  labelStyle:TextStyle(fontSize: 14,color: Colors.grey) ,
                  items:_con!.firmTypes,
                  showClearButton: false,
                  onChanged: (String? value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (value != null) {
                      _con!.firmTypeString = value;
                      print(_con!.firmTypeString);
                    }
                    setState(() {});
                  },
                ),
              ),
              firmTypeError ?
              errorText("Please select firm type") : const SizedBox(),

              SizedBox(height: 15,),
              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchableDD(
                  hintText: 'Company Size',
                  hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                  label: 'Company Size',
                  labelStyle: TextStyle(fontSize: 14,color: Colors.grey),
                  items: _con!.firmSize,
                  showClearButton: false,
                  onChanged: (String? value) {
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (value != null) {
                      _con!.firmSizeString = value;
                      print(_con!.firmSizeString);
                    }
                    setState(() {});
                  },
                ),
              ),
              firmSizeError ?
              errorText("Please select company size") : const SizedBox(),

              Container(
                height: height*0.07,
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: kGreyColor,
                    border: Border.all(color: const Color(0xFFAAA2A2))
                ),
                child: TextFormField(
                  controller: _con!.signUpGSTNumber,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Z]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'GSTIN Number (Optional)',hintStyle: TextStyle(
                      fontSize: 14,color: Colors.grey
                  )),
                ),
              ), gstError ?
              errorText(gstText) : const SizedBox(),

              SizedBox(height:20),
              Container(
                width: width,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: RoundedReusableButton(
                  title: 'Register',
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    validate().then((v){
                      print("v==== $v");
                      if(v == true){
                        _con!.register(context);
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: RichText(
                      text: TextSpan(
                      text: 'Already a User?',
                      style: TextStyle(color: kGreyColor, fontSize: 16,fontFamily: 'Jost'),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Login',
                          style: TextStyle(
                              color: kBlueColor, fontSize: 16,fontFamily: 'Jost'),
                          recognizer: TapGestureRecognizer()..onTap=(){
                            Navigator.pop(context);
                        }
                        )
                      ]),
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }

  errorText(text){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$text',style: const TextStyle(color: Colors.red),),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  Future<bool> validate()async{
    bool emailValid =RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(_con!.signUpEmail.text);

    //RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[a-zA-Z0-9]$|^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[a-zA-Z0-9._%+-]@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(_con!.signUpEmail.text);
    bool gstValid=RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$").hasMatch(_con!.signUpGSTNumber.text);
    setState(() {
      if(_con!.signUpName.text.isEmpty){
        nameError = true;
      }else{
        nameError = false;
      }
      if(_con!.signUpMobile.text.isEmpty){
        mobileError = true;
        mobileText = 'Please enter your mobile number';
      }else if(_con!.countryCodes.countryCode == 'IN'&&_con!.signUpMobile.text.length != 10){
        mobileError = true;
        mobileText = 'Mobile number should be of 10 digits';
      }else{
        mobileError = false;
      }
      //todo i add below 2.2.24
      if(_con!.signUpPassword.text.isEmpty && _con!.countryCodes.countryCode != 'IN'){
        registerPasswordError = true;
      }else{
        registerPasswordError=false;
      }

      if(_con!.confirmPassword.text.isEmpty&& _con!.countryCodes.countryCode != 'IN'){
        confirmPasswordError = true;
        confirmText="Please enter a password; it must not be empty";
      }
      else if(_con!.confirmPassword.text !=_con!.signUpPassword.text && _con!.countryCodes.countryCode != 'IN'){
        confirmPasswordError = true;
        confirmText="Passwords do not match. Please enter the correct password in both fields.";
      }
      else{
        confirmPasswordError=false;
      }


      if(_con!.signUpEmail.text.isEmpty){
        emailError = true;
        emailText = 'Please enter your email';
      }else if(!emailValid){
        emailError = true;
        emailText = 'Please enter email in correct format';
      }else{
        emailError = false;
      }

      if(_con!.signUpCompanyName.text.isEmpty){
        companyNameError = true;
      }else{
        companyNameError = false;
      }
      if(_con!.firmTypeString.isEmpty){
        firmTypeError = true;
      }else{
        firmTypeError = false;
      }
      if(_con!.firmSizeString.isEmpty){
        firmSizeError = true;
      }else{
        firmSizeError = false;
      }

      if(_con!.signUpGSTNumber.text.isEmpty){
        gstError = false;
        //gstError = true;
        gstText = 'Please enter gst ';
      }
      else if(!gstValid&& _con!.signUpGSTNumber.text.isNotEmpty){

          print(gstValid);
          gstError = true;
          gstText = 'Please enter gst in correct format';


      }else {
      gstError = false;
      }







    });
    return nameError
        || mobileError
        || registerPasswordError
        ||confirmPasswordError
        || emailError ||
        companyNameError ||
        firmTypeError || gstError ||
        firmSizeError ? false : true;
  }

}

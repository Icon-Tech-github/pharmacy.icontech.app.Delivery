import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc/auth_cubit.dart';
import '../../bloc/home_bloc/order_cubit.dart';
import '../../data/ServerConstants.dart';
import '../../data/reposetories/auth_repo.dart';
import '../../data/reposetories/home_repo.dart';
import '../../theme.dart';
import '../../translations/locale_keys.g.dart';
import '../wedgits/default_button.dart';
import '../wedgits/loading.dart';
import 'home.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ServerConstants.showDialog1(context, state.error);
            } else if (state is AuthSuccess) {
              //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      MultiBlocProvider(
                        providers: [
                          BlocProvider<OrderCubit>(
                            create: (BuildContext context) =>
                                OrderCubit(GetHomeRepository()),
                          ),
                          BlocProvider<AuthCubit>(
                            create: (BuildContext context) =>
                                AuthCubit(AuthRepo()),
                          ),
                        ],
                        child: HomeScreen(),
                      ),
                ),
              );
            } else if (state is AuthLoading) {
              LoadingScreen.show(context);
            }
          },
          builder: (context, state) =>
              SafeArea(
                child: Form(
                  key:   context.read<AuthCubit>().formKey ,
                  child: Column(
                    //    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   //   SizedBox(height: size.height * .04,),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 9),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: size.width * .08,
                                color: AppTheme.kPrimary,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12),
                            height: 400,
                            width: 400,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/del.gif'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                               Padding(
                                padding: EdgeInsets.only(
                                    top: 32.0, right: 16.0, left: 16.0),
                                child: Text(
                                  LocaleKeys.change_pass_translate.tr(),
                                  style: TextStyle(
                                      color: AppTheme.kPrimary,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, right: 24.0, left: 24.0),
                                child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.next,
                                    // validator: validateEmail,
                                    // onSaved: (String? val) {
                                    //   email = val;
                                    // },
                                    style:  TextStyle(fontSize: 18.0,height: size.height *.0025),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor:  AppTheme.kPrimary,
                                    obscureText: !_passwordVisible,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return LocaleKeys.Required.tr();
                                      } else if (value.length < 6) {
                                        return LocaleKeys.phone_valid.tr();
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      context.read<AuthCubit>().oldPass  = val!;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      fillColor: Colors.white,
                                      hintText:  LocaleKeys.old_pass_hint.tr(),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                        child: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey),

                                      focusedBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(color: AppTheme.kPrimary, width: 2.0)),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, right: 24.0, left: 24.0),
                                child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.next,
                                    // validator: validateEmail,
                                    // onSaved: (String? val) {
                                    //   email = val;
                                    // },
                                    style:  TextStyle(fontSize: 18.0,height: size.height *.0025),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor:  AppTheme.kPrimary,
                                    obscureText: !_passwordVisible2,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return LocaleKeys.Required.tr();
                                      } else if (value.length < 6) {
                                        return LocaleKeys.phone_valid.tr();
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      context.read<AuthCubit>().newPass  = val!;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      fillColor: Colors.white,
                                      hintText:  LocaleKeys.new_pass_hint.tr(),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible2 = !_passwordVisible2;
                                          });
                                        },
                                        child: Icon(
                                          _passwordVisible2
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey),

                                      focusedBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(color: AppTheme.kPrimary, width: 2.0)),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    )),
                              ),
                              Center(
                                child: Padding(

                                  padding: EdgeInsets.only(
                                      top: 32.0, right: 16.0, left: 16.0),
                                  child: DefaultButton(
                                    width: size.width * .7,
                                    textColor: Colors.white,
                                    color: AppTheme.kPrimary,
                                    title: LocaleKeys.send.tr(),
                                    // borderColor: Colors.red,
                                    radius: 25,
                                    function: () async{
                                      if (! BlocProvider.of<AuthCubit>(context).formKey.currentState!.validate()) {
                                        return;
                                      }

                                      BlocProvider.of<AuthCubit>(context).formKey.currentState!.save();
                                      await BlocProvider.of<AuthCubit>(context).changePass(
                                      );                        },
                                    font: size.height * 0.025,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ) ),
    );
  }
}

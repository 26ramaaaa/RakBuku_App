import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xFF000AFF);
    const Color backgroundInput = Color(0xFFEFEFEF);
    const Color background = Color(0xFFC6D3E3);
    const Color colorBorder = Color(0xFFC6D3E3);

    double toolbar = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double bodyHeight = height - toolbar;

    return Scaffold(
          body:SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: bodyHeight,
                decoration: const BoxDecoration(
                  color: background,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SvgPicture.asset('assets/images/logo_rakbuku.svg'),
                      ),

                      Form(
                        key: controller.formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: 35.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  )),

                              TextFormField(
                                controller: controller.usernameController,
                                style:  GoogleFonts.abhayaLibre(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    fillColor: backgroundInput,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: textColor.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colorBorder.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: textColor.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colorBorder.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                    hintText: 'Username',
                                    hintStyle: GoogleFonts.abhayaLibre(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    )
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Pleasse input email';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              TextFormField(
                                controller: controller.emailController,
                                style:  GoogleFonts.abhayaLibre(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    fillColor: backgroundInput,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: textColor.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colorBorder.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: textColor.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colorBorder.withOpacity(0.90),
                                        ),
                                        borderRadius: BorderRadius.circular(100.100)),
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                    hintText: 'Alamat Email',
                                    hintStyle: GoogleFonts.abhayaLibre(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    )
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Pleasse input email address';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'Email address tidak sesuai';
                                  }else if (!value.endsWith('@smk.belajar.id')){
                                    return 'Email harus @smk.belajar.id';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              Obx(() =>
                                  TextFormField(
                                    controller: controller.passwordController,
                                    obscureText: controller.isPasswordHidden.value,
                                    style:  GoogleFonts.abhayaLibre(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        icon: const Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        fillColor: backgroundInput,
                                        suffixIcon: InkWell(
                                          child: Icon(
                                            controller.isPasswordHidden.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                          onTap: (){
                                            controller.isPasswordHidden.value =! controller.isPasswordHidden.value;
                                          },
                                        ),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: textColor.withOpacity(0.90),
                                            ),
                                            borderRadius: BorderRadius.circular(100.100)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: colorBorder.withOpacity(0.90),
                                            ),
                                            borderRadius: BorderRadius.circular(100.100)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: textColor.withOpacity(0.90),
                                            ),
                                            borderRadius: BorderRadius.circular(100.100)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: colorBorder.withOpacity(0.90),
                                            ),
                                            borderRadius: BorderRadius.circular(100.100)),
                                        contentPadding:
                                        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                        hintText: 'Password',
                                        hintStyle: GoogleFonts.abhayaLibre(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Pleasse input password';
                                      }

                                      return null;
                                    },
                                  ),
                              ),


                              const SizedBox(
                                height: 15,
                              ),

                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 30),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Column(
                                      children: [
                                        Obx(() => controller.loadinglogin.value?
                                  const CircularProgressIndicator(
                                  color: textColor,
                                  ):
                                        SizedBox(
                                            height: 50.0,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            50.50))),
                                                onPressed: () => controller.registerPost(),
                                                child: Text(
                                                  "Register",
                                                  style: GoogleFonts.abhayaLibre(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.black),
                                                )
                                            )
                                        )
                                ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sudah punya akun?',
                                style: GoogleFonts.abhayaLibre(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextButton(
                                onPressed: (){
                                  Get.offAllNamed(Routes.LOGIN);
                                },
                                child: Text('Login',
                                    style: GoogleFonts.abhayaLibre(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: textColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}

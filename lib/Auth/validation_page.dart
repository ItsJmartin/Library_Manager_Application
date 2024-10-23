import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management_app/Auth/landing_page.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({super.key});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///////////
              const SizedBox(
                width: 70,
                height: 70,
                child: Image(
                  image: AssetImage("assets/iconpng/library.png"),
                  color: Color(0xffffffff),
                ),
              ),
              const SizedBox(height: 10),

              ////////// login heading
              Padding(
                padding: const EdgeInsets.all(16.1),
                child: Text(
                  "Login",
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xffffffff),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.1),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    ////////// text field
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      controller: _emailController,
                      // Email Validation
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Please enter a email';
                        }
                        // Basic check for '@' and '.' in the email
                        if (!email.contains('@') || !email.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xffffffff),
                        ),
                        ////////// focused boder
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Color(0xffffffff),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ////////// text field
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      controller: _passwordController,
                      // password Validation
                      validator: (value) {
                        if (value == null ||
                            value.length < 6 ||
                            value.isEmpty) {
                          return "Please enter more than six caractors";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xffffffff),
                        ),
                        /////////// focused border
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Color(0xffffffff),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 40), //space between button and textfield
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            //   TextEditingValue email = _emailController.value;
                            //   TextEditingValue password =
                            //       _passwordController.value;
                            //  print(email);
                            //  print(password);

                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LandingPage()),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('Login Sucessful'),
                              ));
                            }
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.nunito(
                              color: const Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Not a Member?',
                          style: GoogleFonts.nunito(
                            color: const Color(0xffffffff),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Register now',
                          style: GoogleFonts.nunito(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}

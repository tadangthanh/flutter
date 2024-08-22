import 'package:flutter/material.dart';

void main() {
  runApp(const BaiTapBuoi6());
}

class BaiTapBuoi6 extends StatelessWidget {
  const BaiTapBuoi6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bai Tap Buoi 6",
      home: const BaiTapBuoi6HomePage(),
      routes: <String, WidgetBuilder>{
        "/home": (context) => const Home(),
      },
    );
  }
}

class BaiTapBuoi6HomePage extends StatefulWidget {
  const BaiTapBuoi6HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return BaiTapBuoi6State();
  }
}

class BaiTapBuoi6State extends State<BaiTapBuoi6HomePage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirm = TextEditingController();
  var isSignUp = false;
  String? email;
  String? password;

  Widget? reConfirmPassword() {
    if (isSignUp) {
      return TextField(
        controller: passwordConfirm,
        decoration: const InputDecoration(
          label: Text(
            "E-Mail",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    return null;
  }

  bool check(String email, String password) {
    if (email.length >= 3 && password.length >= 3) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xFFe9b6f7), // Màu bắt đầu từ góc trên bên trái
              Color(0xFFe5caab),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -0.1,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 45),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                  decoration: BoxDecoration(
                      color: const Color(0xffbe360b),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "MyShop",
                    style: TextStyle(
                        color: Color(0xfffffefe),
                        fontSize: 50,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(1),
                        // Màu của bóng đổ
                        spreadRadius: 2,
                        // Bán kính lan của bóng
                        blurRadius: 1,
                        // Bán kính mờ của bóng
                        offset: const Offset(2, 2), // Độ lệch của bóng (x, y)
                      )
                    ]),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        label: Text(
                          "E-Mail",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        label: Text(
                          "Password",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(child: reConfirmPassword(),),
                    Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              String email = emailController.text;
                              String password = passwordController.text;
                              if (check(email, password)) {
                                Account account = Account(email, password);
                                Navigator.pushNamed(context, "/home",
                                    arguments: account);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Lỗi'),
                                    content: const Text(
                                        'Tài khoản hoặc mật khẩu không chính xác, vui lòng thử lại'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Đóng'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                            ),
                            child: Text(
                              isSignUp ? "Sign up" : "Login",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isSignUp = !isSignUp;
                          });
                        },
                        child: const Text("SIGNUP INSTEAD"))
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class Account {
  String email;
  String password;

  Account(this.email, this.password);
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context)?.settings.arguments as Account?;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text("Chao mung ban ${param?.email}"),
        ),
      ),
    );
  }
}

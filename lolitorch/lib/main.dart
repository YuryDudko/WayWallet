import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lolitorch/registration.dart';
import 'package:lolitorch/login.dart';
import 'package:lolitorch/addWallet.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                //contentPadding: EdgeInsets.symmetric( vertical: 15 , horizontal: 40)
              ),
              obscureText: true,
            ),
            SizedBox(height: 8.0) ,
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 8.0) ,
            SizedBox(height: 60.0 , width: 135.0,
              child: ElevatedButton(
                onPressed: () async {
                  //print('popi');
                  var result = await registerUser(_usernameController.text, _passwordController.text , _emailController.text);
                  if(result == 200){
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                  }
                },
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 8.0) ,
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), 
                );
               } , 
              child: Text("Already have an account?"),
              )
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Username',
                
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                //contentPadding: EdgeInsets.symmetric( vertical: 15 , horizontal: 40)
              ),
              obscureText: true,
            ),
            
            
            SizedBox(height: 8.0),
            SizedBox(height: 60.0, width: 135.0,
              child: ElevatedButton(
                onPressed: () async {
                  var result = await loginUser(_loginController.text, _passwordController.text);
                  if(result == 200){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddWalletPage(username: _loginController.text),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 8.0,),
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()), 
                );
               } , 
              child: Text("Not registered yet?"),
              ),
          ],
        ),
      ),
    );
  }
}

class AddWalletPage extends StatefulWidget{
  final String username;

  const AddWalletPage({required this.username});

  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage>{
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  final TextEditingController _WalletNameController = TextEditingController();
  final TextEditingController _KeyPhraseController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Addition'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _WalletNameController,
              decoration: InputDecoration(
                labelText: 'Wallet Name',
                
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _KeyPhraseController,
              decoration: InputDecoration(
                labelText: 'Key Phrase',
                //contentPadding: EdgeInsets.symmetric( vertical: 15 , horizontal: 40)
              ),
              obscureText: true,
            ),
            
            
            SizedBox(height: 8.0),
            SizedBox(height: 60.0, width: 135.0,
              child: ElevatedButton(
                onPressed: () async {
                  var result = await addWallet(_WalletNameController.text, _KeyPhraseController.text , username);
                  if(result == 200){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationPage(),
                      ),
                    );
                  }
                },
                child: Text('Add Wallet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    TradePage(),
    NewsModeration(),
    SettingsPage(),
  ];
  //bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Main Page'),
      // ),
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz),
            label: 'Trade',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.face)),
            label: 'Moderate',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('1'),
              child: Icon(Icons.settings),
            ),
            label: 'Settings',
          ),
        ],
      ),
      // body: <Widget> [
      //   /// Home page
      //   Card(
      //     shadowColor: Colors.transparent,
      //     margin: const EdgeInsets.all(8.0),
      //     child: SizedBox.expand(
      //       child: Center(
      //         child: Text(
      //           'Home page',
      //           style: Theme.of(context).textTheme.displayMedium,
      //         ),
      //       ),
      //     ),
      //   ),

      //   Card(
      //     shadowColor: Colors.transparent,
      //     margin: const EdgeInsets.all(8.0),
      //     child: SizedBox.expand(
      //       child: Center(
      //         child: Text(
      //           'Trade',
      //           style: Theme.of(context).textTheme.displayMedium,
      //         ),
      //       ),
      //     ),
      //   ),

      //   const Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: Column(
      //       children: <Widget>[
      //         Card(
      //           child: ListTile(
      //             leading: Icon(Icons.stop_circle),
      //             title: Text('Ban User'),
      //             subtitle: Text('Press to ban user'),
      //           ),
      //         ),
      //         Card(
      //           child: ListTile(
      //             leading: Icon(Icons.notifications_sharp),
      //             title: Text('Unban User'),
      //             subtitle: Text('Press to unban user'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),

      //   // Dark mode switch
      //     ListTile(
      //       title: Text('Dark Mode'),
      //       trailing: Switch(
      //         value: _isDarkModeEnabled,
      //         onChanged: (value) {
      //           setState(() {
      //             _isDarkModeEnabled = value;
      //             if (_isDarkModeEnabled) {
      //               ThemeMode.dark;
      //             } else {
      //               ThemeMode.light;
      //             }
      //           });
      //         },
      //       ),
      //     ),
      // ][currentPageIndex] ,
      
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>  {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Settings Page Content',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Switch(
                value: isDark,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                  });
                },
                activeColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsModeration extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Moderation Page'),
      ),
      body: Center(
        child: Text('Moder content'),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
        centerTitle: true,
        //leadingWidth: 0,
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Напишите здесь код для перехода на предыдущую страницу или другую нужную навигацию
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal:8.0),
            child:IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), 
                );
              },
            ),
          ),
        ],
      ),
      body: 
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0 , horizontal: 16.0),
              child: TextButton.icon(
                onPressed: () {
                  // Обработчик нажатия кнопки
                  print('TextButton with Icon pressed');
                },
                icon: Icon(Icons.search), // Иконка
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Search'),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(386, 35)), // Устанавливаем минимальный размер
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)), // Устанавливаем внутренние отступы
                  backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)), // Устанавливаем цвет фона
                  foregroundColor: MaterialStateProperty.all(Colors.white), // Устанавливаем цвет текста
                  
                ),
              
               // Текст
              ),
            ),
            Row(
              children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  // Действия, выполняемые при нажатии на правую кнопку
                },
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text('WalletName'),
                icon: Icon(Icons.arrow_drop_down),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(35, 30)),
                  //visualDensity: VisualDensity(horizontal: 0), // Уменьшение горизонтального расстояния между элементами
                ),
                
              ),
              Spacer(flex: 1,),
              IconButton(
                iconSize: 18,
                icon: Icon(Icons.copy_outlined),
                onPressed: () {
                  // Действия, выполняемые при нажатии на правую кнопку
                },
              ),
              IconButton(
                iconSize: 20,
                icon: Icon(Icons.qr_code_scanner_sharp),
                onPressed: () {
                  // Действия, выполняемые при нажатии на правую кнопку
                },
              ),
              IconButton(
                iconSize: 20,
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Действия, выполняемые при нажатии на правую кнопку
                },
              ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15 ) ,
                  child: TextButton(
                      child: Text("0,00" , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 30.0 ,color: Colors.black),),
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(25.0, 20.0)), 
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            //   RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(4.0), // Установка радиуса границ
                            //     side: BorderSide(color: Colors.black),
                                
                            //   ),
                              
                            // ),
                            
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15 ),
                  child: IconButton(
                      icon: Icon(Icons.euro),
                      onPressed: () {
                        
                      },
                    ),
                  )
              ]
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularButton(context , Icons.arrow_upward, 'Send'),
                _buildCircularButton(context ,Icons.arrow_downward, 'Get'),
                _buildCircularButton(context ,Icons.credit_card, 'Bye'),
                _buildCircularButton(context ,Icons.sell, 'Sell'),
                _buildCircularButton(context ,Icons.history, 'History'),
              ],
            ),
          ],
        ),
         
    );
  }
}

Widget _buildCircularButton(BuildContext context , IconData icon, String label) {
  return Column(
    children: [
      IconButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Радиус скругления кнопки
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.2)), // Серый фон
        ),
        icon: Icon(icon),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Container(
                  height: 900, // Здесь можно задать нужную высоту
                  width: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'This is a bottom sheet',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Закрытие всплывающего окна
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        iconSize: 28.0, // Размер иконки
        color: Colors.black,
      ),
      Text(label),
    ],
  );
}

class TradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trade',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.0 , right: 15.0 ) ,
        child: Column(
          children: [
            Container(
              width: 390,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              
            ),
            SizedBox(
              height: 40,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.swap_vert),
                  iconSize: 25, 
                  onPressed: (){

                  },
                ),
              )
            ),
            Container(
              width: 390,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        )
      ),
      
    );
  }
}
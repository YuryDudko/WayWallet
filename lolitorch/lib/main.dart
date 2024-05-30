import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lolitorch/colors_custom.dart';
import 'package:lolitorch/complete_transfer.dart';
import 'package:lolitorch/registration.dart';
//import 'package:lolitorch/login.dart';
import 'package:lolitorch/addWallet.dart';
import 'package:lolitorch/fetch_crypto_cur.dart';
import 'package:lolitorch/purchase.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lolitorch/sell.dart';
import 'package:lolitorch/fetch_transaction_history.dart';
import 'package:lolitorch/fetch_news.dart';
import 'package:lolitorch/fetch_rates.dart';
import 'package:lolitorch/fetch_wallet.dart';
import 'package:lolitorch/fetch_networks.dart';
import 'package:lolitorch/exchange_crypto.dart';
import 'package:lolitorch/fetch_user_info.dart';
import 'package:lolitorch/crypto_icons.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(40, 75, 99, 1)),
        scaffoldBackgroundColor: Color.fromRGBO(217, 217, 217, 1),
        primarySwatch: primary,
      ),
      home: EnterPage(),
    );
  }
}

class EnterPage extends StatefulWidget{
  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'icons/2203530_connect_direction_path_way_icon.png',
              width: 128,
              height: 128,
            ),
            SizedBox(height: 20), // Добавляем отступ между иконкой и названием
            Text(
              'WAY WALLET',
              style: TextStyle(
                color: Color.fromRGBO(60, 110, 113, 1),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 50.0), // Увеличиваем отступ между названием и кнопками
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    foregroundColor: Color.fromRGBO(60, 110, 113, 1),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Небольшое закругление
                    ),
                    textStyle: TextStyle(fontSize: 18), // Размер текста
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Sign IN"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    foregroundColor: Color.fromRGBO(60, 110, 113, 1),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Небольшое закругление
                    ),
                    textStyle: TextStyle(fontSize: 18), // Размер текста
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text("Sign UP"),
                ),
              ],
            ),
          ],
        ),
      ),
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

  bool _isUsernameValid = false;
  bool _isPasswordValid = false;
  bool _isEmailValid = false;

  bool get _isFormValid => _isUsernameValid && _isPasswordValid && _isEmailValid;

  void _validateUsername(String value) {
    setState(() {
      _isUsernameValid = value.length >= 8;
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _isPasswordValid = value.length >= 8 && RegExp(r'[A-Z]').hasMatch(value) && RegExp(r'[!#&]').hasMatch(value);
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                errorText: _isUsernameValid ? null : 'Username must be at least 8 characters',
              ),
              onChanged: _validateUsername,
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                errorText: _isPasswordValid ? null : 'Password must be at least 8 characters, contain 1 uppercase letter and 1 special character',
              ),
              obscureText: true,
              onChanged: _validatePassword,
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                errorText: _isEmailValid ? null : 'Invalid email format',
              ),
              onChanged: _validateEmail,
            ),
            SizedBox(height: 8.0),
            SizedBox(
              height: 60.0,
              width: 135.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(60, 110, 113, 1),
                  ),
                ),
                onPressed: _isFormValid ? () async {
                  var result = await registerUser(_usernameController.text, _passwordController.text, _emailController.text);
                  if (result == 200) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  }
                } : null,
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Already have an account?", style: TextStyle(color: Color.fromRGBO(60, 110, 113, 1))),
            ),
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

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  void saveTokenToStorage(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> loginUser(String login, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.31.20:80/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'login': login,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      final hasWallet = responseBody['hasWallet'];

      saveTokenToStorage(token);
      if (hasWallet) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddWalletPage(username: login),
          ),
        );
      }
    } else {
      setState(() {
        _errorMessage = 'Incorrect username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 8.0),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 8.0),
            SizedBox(
              height: 60.0,
              width: 135.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(60, 110, 113, 1),
                  ),
                ),
                onPressed: () async {
                  await loginUser(_loginController.text, _passwordController.text);
                },
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text("Not registered yet?", style: TextStyle(color: Color.fromRGBO(60, 110, 113, 1))),
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

class _AddWalletPageState extends State<AddWalletPage> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  final TextEditingController _WalletNameController = TextEditingController();
  final TextEditingController _KeyPhraseController = TextEditingController();

  bool _isKeyPhraseValid = false;

  void _validateKeyPhrase(String value) {
    setState(() {
      _isKeyPhraseValid = RegExp(r'^[a-zA-Z]+$').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Addition', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _WalletNameController,
              decoration: InputDecoration(
                labelText: 'Wallet Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _KeyPhraseController,
              decoration: InputDecoration(
                labelText: 'Secret Phrase',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                errorText: _isKeyPhraseValid ? null : 'Secret Phrase should contain only letters',
              ),
              onChanged: _validateKeyPhrase,
            ),
            SizedBox(height: 8.0),
            SizedBox(
              height: 60.0,
              width: 135.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(60, 110, 113, 1),
                  ),
                ),
                onPressed: _isKeyPhraseValid ? () async {
                  var result = await addWallet(_WalletNameController.text, _KeyPhraseController.text,username);
                  if (result == 200) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationPage(),
                      ),
                    );
                  }
                } : null,
                child: Text('Add Wallet', style: TextStyle(color: Colors.white)),
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
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo().then((fetchedUser) {
      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    });
  }

  final List<Widget> pages = [
    HomePage(),
    TradePage(),
    NewsPage(),
    NewsModeration(),
    
  ];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    List<NavigationDestination> destinations = [
      const NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home' ,
      
      ),
      const NavigationDestination(
        icon: Icon(Icons.swap_horiz),
        label: 'Trade',
      ),
      const NavigationDestination(
        icon: Badge(child: Icon(Icons.newspaper)),
        label: 'News',
      ),
    ];

    if (user?.roleName == 'Admin') {
      destinations.insert(3, const NavigationDestination(
        icon: Badge(child: Icon(Icons.face)),
        label: 'Moderate',
      ));
    }

    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Color.fromRGBO(60, 110, 113, 1),
        indicatorColor: Color.fromRGBO(255, 255, 255, 1),
        selectedIndex: currentPageIndex,
        destinations: destinations,
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: BackButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
        },),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Wallets'),
            onTap: () {
              // Navigate to Wallets page (Not implemented here)
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Address Book'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddressBookPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.qr_code),
            title: Text('Scan QR Code'),
            onTap: () {
              // Navigate to Scan QR Code page (Not implemented here)
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsDetailPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Security'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SecurityPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        leading: BackButton(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
            },
          ),
          ListTile(
            title: Text('Terms of Service'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TermsOfServicePage()));
            },
          ),
          ListTile(
            title: Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Privacy Policy Content'),
      ),
    );
  }
}

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Terms of Service Content'),
      ),
    );
  }
}

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isPasswordEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        leading: BackButton(),
      ),
      body: ListTile(
        title: Text('Enable Password'),
        trailing: Switch(
          value: _isPasswordEnabled,
          onChanged: (value) {
            setState(() {
              _isPasswordEnabled = value;
            });
            if (value) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return CreatePasswordPage();
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CreatePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password'),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Create a password'),
            // Implement password input fields here
            // Use appropriate widgets and logic to handle password input
          ],
        ),
      ),
    );
  }
}

class SettingsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: ListTile(
        title: Text('User Information'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoPage()));
        },
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
        leading: BackButton(),
      ),
      body: FutureBuilder<User>(
        future: fetchUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load user info'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user info available'));
          }

          User user = snapshot.data!;
          return ListView(
            children: [
              ListTile(
                title: Text('Username'),
                subtitle: Text(user.username),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(user.email),
              ),
              ListTile(
                title: Text('Role'),
                subtitle: Text(user.roleName),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddressBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Book'),
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return AddWalletPageInSet();
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Address Book Content'),
      ),
    );
  }
}

class AddWalletPageInSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet'),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle wallet addition
            },
            child: Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Wallet Name'),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Address'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectAssetPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectAssetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Asset'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Select Asset Content'),
      ),
    );
  }
}

  Widget _buildGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }



class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<News>> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = fetchNoModerationNews();
  }

  void _showCreateNewsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreateNewsPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
        leading: IconButton(
          icon: Icon(Icons.add),
            onPressed: () => _showCreateNewsModal(context),
        ),
        title: Text('News'),
        centerTitle: true,
        
      ),
      body: FutureBuilder<List<News>>(
        future: _newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              News news = snapshot.data![index];
              return ListTile(
                title: Text(news.title),
                subtitle: Text(news.description),
              );
            },
          );
        },
      ),
    );
  }
}

class CreateNewsPage extends StatefulWidget {
  @override
  _CreateNewsPageState createState() => _CreateNewsPageState();
}

class _CreateNewsPageState extends State<CreateNewsPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _submitNews() async {
    try {
      await createNews(_titleController.text, _descriptionController.text);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('News created successfully')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create news')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitNews,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsModeration extends StatefulWidget {
  @override
  _NewsModerationPageState createState() => _NewsModerationPageState();
}

class _NewsModerationPageState extends State<NewsModeration> {
  late Future<List<News>> _newsList;
  News? _selectedNews;

  @override
  void initState() {
    super.initState();
    _newsList = fetchModerationNews();
  }

  void _selectNews(News news) {
    setState(() {
      _selectedNews = news;
    });
  }

  Future<void> _acceptSelectedNews() async {
    if (_selectedNews != null) {
      try {
        await acceptNews(_selectedNews!.id);
        setState(() {
          _newsList = fetchModerationNews();
          _selectedNews = null;
        });
      } catch (e) {
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text('Moderation Page'),
      ),
      body: FutureBuilder<List<News>>(
        future: _newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load moderation news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news on moderation'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    News news = snapshot.data![index];
                    return ListTile(
                      title: Text(news.title),
                      subtitle: Text(news.description),
                      selected: _selectedNews?.id == news.id,
                      onTap: () => _selectNews(news),
                    );
                  },
                ),
              ),
              if (_selectedNews != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _acceptSelectedNews,
                    child: Text('Accept News'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CryptoCurrency>> futureCryptocurrencies;
  late Future<WalletInfo> futureWalletInfo;
  late Future<List<Rate>> futureRates;

  @override
  void initState() {
    super.initState();
    futureCryptocurrencies = fetchCryptocurrencies();
    futureWalletInfo = fetchWallet(); // Use actual userId
    futureRates = fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main' , style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 255, 255, 1))),
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              child: TextButton.icon(
                onPressed: () {
                  // Handle search button press
                },
                icon: Icon(Icons.search),
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Search'),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(386, 35)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
            FutureBuilder<WalletInfo>(
              future: futureWalletInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No wallet info found.'));
                } else {
                  final walletInfo = snapshot.data!;
                  return Column(
                    children: [
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              // Handle visibility toggle
                            },
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            label: Text(walletInfo.walletName),
                            icon: Icon(Icons.arrow_drop_down),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(35, 30)),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            iconSize: 18,
                            icon: Icon(Icons.copy_outlined),
                            onPressed: () {
                              // Handle copy action
                            },
                          ),
                          IconButton(
                            iconSize: 20,
                            icon: Icon(Icons.qr_code_scanner_sharp),
                            onPressed: () {
                              // Handle QR scan action
                            },
                          ),
                          IconButton(
                            iconSize: 20,
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              // Handle notifications
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: TextButton(
                              child: Text(
                                walletInfo.walletBalance.toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {},
                              style: ButtonStyle(
                                
                                minimumSize: MaterialStateProperty.all<Size>(Size(25.0, 20.0)),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Image.asset(
                                      '/icons/1608712_usd_icon.png',
                                      width: 28,
                                      height: 28,
                                    ),
                            // child: IconButton(
                            //   icon: Icon(Icons.currency_ruble),
                            //   onPressed: () {},
                            // ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularButton(context, Icons.arrow_upward, 'Send', () {
                  _showSendModal(context);
                }),
                _buildCircularButton(context, Icons.arrow_downward, 'Get', () {
                  _showGetModal(context);
                }),
                _buildCircularButton(context, Icons.credit_card, 'Buy', () {
                  _showBuyModal(context);
                }),
                _buildCircularButton(context, Icons.sell, 'Sell', () {
                  _showSaleModal(context);
                }),
                _buildCircularButton(context, Icons.history, 'History', () {
                  _showHistoryModal(context);
                }),
              ],
            ),
            FutureBuilder<List<CryptoCurrency>>(
              future: futureCryptocurrencies,
              builder: (context, cryptoSnapshot) {
                if (cryptoSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (cryptoSnapshot.hasError) {
                  return Center(child: Text('Error: ${cryptoSnapshot.error}'));
                } else if (!cryptoSnapshot.hasData || cryptoSnapshot.data!.isEmpty) {
                  return Center(child: Text('No cryptocurrencies found.'));
                } else {
                  return FutureBuilder<List<Rate>>(
                    future: futureRates,
                    builder: (context, rateSnapshot) {
                      if (rateSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (rateSnapshot.hasError) {
                        return Center(child: Text('Error: ${rateSnapshot.error}'));
                      } else if (!rateSnapshot.hasData || rateSnapshot.data!.isEmpty) {
                        return Center(child: Text('No rates found.'));
                      } else {
                        final rates = rateSnapshot.data!;
                        return Container(
                          height: 570, // Set a fixed height for the ListView
                          child: ListView.builder(
                            itemCount: cryptoSnapshot.data!.length,
                            itemBuilder: (context, index) {
                              CryptoCurrency crypto = cryptoSnapshot.data![index];
                              Rate? rate = rates.firstWhere(
                                (r) => r.symbol == crypto.currencyCode,
                                orElse: () => Rate(
                                  coinId: 0,
                                  symbol: crypto.currencyCode,
                                  name: '',
                                  rank: 0,
                                  priceUsd: 0.0,
                                  percentChange24h: 0.0,
                                  percentChange1h: 0.0,
                                  percentChange7d: 0.0,
                                  priceBtc: 0.0,
                                ),
                              );
                              double usdValue = crypto.currencyAmount * rate.priceUsd;
                              return Container(
                                    margin: EdgeInsets.all(8.0),
                                    padding: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[crypto.currencyCode] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                        //Icon(Icons.diamond, size: 40.0),
                                        SizedBox(width: 16.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              crypto.currencyCode,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [Text('${rate.priceUsd} '),Text('${rate.percentChange24h.toStringAsFixed(2)}%', style: TextStyle(fontSize: 12, color: rate.percentChange24h >= 0 ? Colors.green : Colors.red)),]
                                            ),
                                            
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${crypto.currencyAmount}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '\$${usdValue.toStringAsFixed(2)}', // Example conversion rate
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                              // return Card(
                              //   margin: EdgeInsets.all(8.0),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(16.0),
                              //     child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Text('Code: ${crypto.currencyCode}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //         Text('Name: ${crypto.currencyName}', style: TextStyle(fontSize: 16)),
                              //         Text('Address: ${crypto.currencyAddress}', style: TextStyle(fontSize: 16)),
                              //         Text('Amount: ${crypto.currencyAmount}', style: TextStyle(fontSize: 16)),
                              //         Text('Rate: ${rate.priceUsd}', style: TextStyle(fontSize: 16)),
                              //         Text('USD Equivalent: \$${usdValue.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                              //         Text('24h Change: ${rate.percentChange24h.toStringAsFixed(2)}%', style: TextStyle(fontSize: 16, color: rate.percentChange24h >= 0 ? Colors.green : Colors.red)),
                              //       ],
                              //     ),
                              //   ),
                              // );
                              
                            },
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showHistoryModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FutureBuilder<List<TransactionHistory>>(
        future: fetchTransactionHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found.'));
          } else {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  style: ButtonStyle(foregroundColor:MaterialStatePropertyAll(Color.fromRGBO(255, 255, 255, 1))),
                  icon: Icon(Icons.close ),
                  onPressed: () {
                    Navigator.pop(context); // Close modal
                  },
                ),
                title: Text('Transaction History' , style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final transaction = snapshot.data![index];
                    return ListTile(
                      title: Text('${transaction.transactionType} ${transaction.cryptoAbbreviation}'),
                      subtitle: Text('${transaction.amount} at ${transaction.transactionDate}'),
                      trailing: Text('${transaction.equivalentAmount} USD'),
                    );
                  },
                ),
              ),
            );
          }
        },
      );
    },
  );
}

void _showBuyModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9, // Set desired height here
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              style: ButtonStyle(foregroundColor:MaterialStatePropertyAll(Color.fromRGBO(255, 255, 255, 1))),
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context); // Close modal
              },
            ),
            title: Text('Покупка' , style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Популярное',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    _buildCryptoFamousItem(context, 'BTC', 'Bitcoin'),

                    SizedBox(width: 16.0),
                    _buildCryptoFamousItem(context, 'ETH', 'Ethereum'),
                ],),
                SizedBox(height: 20,),
                Text(
                  'Криптовалюты',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildCryptoItem(context, 'BNB', 'Binance coin'),
                    SizedBox(height: 4,),
                    _buildCryptoItem(context, 'USDT', 'Thether USD'),
                    SizedBox(height: 4,),
                    _buildCryptoItem(context, 'SOL', 'Solana'),
                    SizedBox(height: 4,),
                    _buildCryptoItem(context, 'STETH', 'Lido stacked either'),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      );
    },
  );
}
Widget _buildCryptoItem(BuildContext context, String abbr, String name) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CryptoPurchaseDetailPage(cryptoAbbr: abbr, cryptoName: name),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[abbr] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 40,
                                          height: 40,
                                        ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                abbr,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(name),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildCryptoFamousItem(BuildContext context, String abbr, String name) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CryptoPurchaseDetailPage(cryptoAbbr: abbr, cryptoName: name),
        ),
      );
    },
    child: Container(
      width: 182,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[abbr] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 40,
                                          height: 40,
                                        ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                abbr,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(name),
            ],
          ),
        ],
      ),
    ),
  );
}

class CryptoPurchaseDetailPage extends StatefulWidget {
  final String cryptoAbbr;
  final String cryptoName;

  CryptoPurchaseDetailPage({required this.cryptoAbbr, required this.cryptoName});

  @override
  _CryptoPurchaseDetailPageState createState() =>
      _CryptoPurchaseDetailPageState();
}

class _CryptoPurchaseDetailPageState extends State<CryptoPurchaseDetailPage> {
  final TextEditingController _amountController = TextEditingController();
  String _convertedAmount = '0.0';
  bool _isLoading = false;
  double _conversionRate = 0.0;
  bool _isAmountValid = true;

  @override
  void initState() {
    super.initState();
    _fetchConversionRate();
  }

  Future<void> _fetchConversionRate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Rate> rates = await fetchRates();
      Rate? selectedRate = rates.firstWhere((rate) => rate.symbol == widget.cryptoAbbr);

      setState(() {
        _conversionRate = selectedRate.priceUsd;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateConversion() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      _convertedAmount = (amount / _conversionRate).toStringAsFixed(8);
      _isAmountValid = amount > 0;
    });
  }

  Future<void> _performPurchase() async {
    setState(() {
      _isLoading = true;
    });

    final purchaseRateValue = _conversionRate;
    final orderAmount = double.tryParse(_convertedAmount) ?? 0;
    final receiverAddress = await getCryptoAddressByAbbreviation(widget.cryptoAbbr);

    final statusCode = await purchaseCrypto(purchaseRateValue, orderAmount, receiverAddress, widget.cryptoAbbr);

    setState(() {
      _isLoading = false;
    });

    if (statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase successful.')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${widget.cryptoName}', style: TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount in USD',
                      errorText: _isAmountValid ? null : 'Amount must be greater than zero',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _updateConversion(),
                  ),
                  SizedBox(height: 16.0),
                  Text('Converted Amount: $_convertedAmount ${widget.cryptoAbbr}'),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _isAmountValid ? _performPurchase : null,
                    child: Text('Purchase'),
                  ),
                ],
              ),
            ),
    );
  }
}

void _showSaleModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FutureBuilder<List<CryptoCurrency>>(
        future: fetchCryptocurrencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cryptocurrencies found.'));
          } else {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context); // Close modal
                  },
                ),
                title: Text('Sale'),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Cryptocurrencies',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final crypto = snapshot.data![index];
                          return _buildCryptoItemForSale(context, crypto);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    },
  );
}

Widget _buildCryptoItemForSale(BuildContext context, CryptoCurrency crypto) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CryptoSaleDetailPage(crypto: crypto),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[crypto.currencyCode] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 40,
                                          height: 40,
                                        ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                crypto.currencyCode,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(crypto.currencyName),
            ],
          ),
        ],
      ),
    ),
  );
}

class CryptoSaleDetailPage extends StatefulWidget {
  final CryptoCurrency crypto;

  CryptoSaleDetailPage({required this.crypto});

  @override
  _CryptoSaleDetailPageState createState() => _CryptoSaleDetailPageState();
}

class _CryptoSaleDetailPageState extends State<CryptoSaleDetailPage> {
  final TextEditingController _amountController = TextEditingController();
  String _convertedAmount = '0.0';
  bool _isLoading = false;
  double _saleRate = 0.0;
  bool _isAmountValid = true;

  @override
  void initState() {
    super.initState();
    _fetchSaleRate();
  }

  Future<void> _fetchSaleRate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Rate> rates = await fetchRates();
      Rate? selectedRate = rates.firstWhere((rate) => rate.symbol == widget.crypto.currencyCode);

      setState(() {
        _saleRate = selectedRate.priceUsd;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateConversion() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      _convertedAmount = (amount * _saleRate).toStringAsFixed(2);
      _isAmountValid = amount > 0;
    });
  }

  Future<void> _performSale() async {
    setState(() {
      _isLoading = true;
    });

    final saleRateValue = _saleRate;
    final orderAmount = double.tryParse(_amountController.text) ?? 0;
    final senderAddress = await getCryptoAddressByAbbreviation(widget.crypto.currencyCode);

    final statusCode = await sellCrypto(saleRateValue, orderAmount, senderAddress, widget.crypto.currencyCode);

    setState(() {
      _isLoading = false;
    });

    if (statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sale successful.')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sale failed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Sale ${widget.crypto.currencyCode}', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount to sell',
                border: OutlineInputBorder(),
                errorText: _isAmountValid ? null : 'Amount must be greater than zero',
              ),
              onChanged: (value) => _updateConversion(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Equivalent in USD: $_convertedAmount',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (_isLoading) CircularProgressIndicator(),
            Spacer(),
            ElevatedButton(
              onPressed: _isAmountValid && !_isLoading ? _performSale : null,
              child: Text('Sell'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSendModal(BuildContext context) {
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String? selectedCurrency;
  String? selectedNetwork;
  double networkGas = 0.0;
  double availableAmount = 0.0;
  double currencyPrice = 0.0;
  double amountToSend = 0.0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FutureBuilder(
        future: Future.wait([
          fetchCryptocurrencies(),
          fetchNetworks(),
          fetchRates(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CryptoCurrency> cryptocurrencies = snapshot.data![0];
            List<Network> networks = snapshot.data![1];
            List<Rate> rates = snapshot.data![2];

            return Container(
              height: 900, // Adjust height as needed
              width: MediaQuery.of(context).size.width * 1,
              child: Scaffold(
                appBar: AppBar(
                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close modal
                    },
                  ),
                  title: Text('Send'),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      void updateAmountToSend() {
                        final enteredAmount = double.tryParse(amountController.text) ?? 0.0;
                        final transferAmountInUsd = enteredAmount * currencyPrice - networkGas;
                        amountToSend = transferAmountInUsd / currencyPrice;
                        setState(() {});
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: Colors.white, // Белый цвет фона
                              borderRadius: BorderRadius.only(bottomLeft: Radius.zero , bottomRight: Radius.zero , topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                              
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Currency',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  items: cryptocurrencies.map((crypto) {
                                    return DropdownMenuItem(
                                      child: Text(crypto.currencyName),
                                      value: crypto.currencyName,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCurrency = value;
                                      final crypto = cryptocurrencies.firstWhere((c) => c.currencyName == value);
                                      availableAmount = crypto.currencyAmount;
                                      final rate = rates.firstWhere((r) => r.name == value);
                                      currencyPrice = rate.priceUsd;
                                      updateAmountToSend();
                                    });
                                  },
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                TextFormField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    labelText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Network',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  items: networks.map((network) {
                                    return DropdownMenuItem(
                                      child: Text(network.networkName),
                                      value: network.networkName,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedNetwork = value;
                                      final network = networks.firstWhere((n) => n.networkName == value);
                                      networkGas = network.networkGas;
                                      updateAmountToSend();
                                    });
                                  },
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                TextFormField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    labelText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  onChanged: (value) {
                                    updateAmountToSend();
                                  },
                                ),
                                SizedBox(height: 16),
                                if (amountController.text.isNotEmpty && double.tryParse(amountController.text)! > availableAmount)
                                  Text(
                                    'Insufficient balance',
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow.withOpacity(0.2),
                              borderRadius: BorderRadius.only(topLeft: Radius.zero , topRight: Radius.zero , bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                            ),
                            
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Icon(Icons.warning, color: Colors.yellow),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    'Check transfer info before transaction.Send the data only after you have verified that it is correct.',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 35),
                          Container(
                            width: 400,
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white, // Белый цвет фона
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Комиссия: $networkGas USD'),
                                Text('Сумма к переводу: ${amountToSend.toStringAsFixed(8)} ${selectedCurrency ?? ''} (~${(amountToSend * currencyPrice).toStringAsFixed(2)} USD)'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final recipientAddress = addressController.text;
                              final amount = double.tryParse(amountController.text) ?? 0.0;

                              if (selectedCurrency != null &&
                                  selectedNetwork != null &&
                                  recipientAddress.isNotEmpty &&
                                  amount > 0 &&
                                  amount <= availableAmount) {
                                final statusCode = await transferMoney(recipientAddress, selectedCurrency!, selectedNetwork!, amount);
                                if (statusCode == 200) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Успешно'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green, size: 50),
                                            SizedBox(height: 20),
                                            Text('Транзакция прошла успешно'),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Готово'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  // Handle error
                                }
                              } else {
                                // Handle validation error
                              }
                            },
                            child: Center(child: Text('Перевести' , style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),) ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50), // Ширина кнопки равна ширине контейнера
                              backgroundColor: Color.fromRGBO(40, 75, 99, 1.0), // Цвет кнопки
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          }
        },
      );
    },
  );
}

void _showGetModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FutureBuilder<List<CryptoCurrency>>(
        future: fetchCryptocurrencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load cryptocurrencies'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cryptocurrencies available'));
          } else {
            List<CryptoCurrency> cryptoData = snapshot.data!;
            return Container(
              height: 900, // Set desired height here
              child: Scaffold(
                appBar: AppBar(
                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close modal
                    },
                  ),
                  title: Text('Get'),
                  centerTitle: true,
                ),
                body: ListView.builder(
                  itemCount: cryptoData.length,
                  itemBuilder: (context, index) {
                    var crypto = cryptoData[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoDetailPage(crypto: crypto),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[crypto.currencyCode] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 40,
                                          height: 40,
                                        ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  crypto.currencyCode,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(crypto.currencyName),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${crypto.currencyAmount}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${(crypto.currencyAmount * 1000).toStringAsFixed(2)}', // Example conversion rate
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      );
    },
  );
}

class CryptoDetailPage extends StatelessWidget {
  final CryptoCurrency crypto;

  CryptoDetailPage({required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Get'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.yellow.withOpacity(0.2),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.yellow),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Send only ${crypto.currencyName} (${crypto.currencyCode}) actives. Other actives will be permanently lost.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[crypto.currencyCode] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 80,
                                          height: 80,
                                        ),
            Text(
              crypto.currencyCode,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  // QR code widget will go here
                  Text('QR Code Placeholder'),
                  SizedBox(height: 16.0),
                  Text(
                    crypto.currencyAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.copy_all_rounded),
                      onPressed: () {
                        // Copy action
                      },
                    ),
                    Text('Copy'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.reply_all_rounded),
                      onPressed: () {
                        // Share action
                      },
                    ),
                    Text('Reply'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.tag_rounded),
                      onPressed: () {
                        // Specify amount action
                      },
                    ),
                    Text('SetV'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



Widget _buildCircularButton(BuildContext context , IconData icon, String label , Function() onPressed) {
  return Column(
    children: [
      IconButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Радиус скругления кнопки
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Серый фон
        ),
        icon: Icon(icon),
        onPressed: onPressed,
        iconSize: 28.0, // Размер иконки
        color: Colors.black,
      ),
      Text(label),
    ],
  );
}

class TradePage extends StatefulWidget {
  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  String? selectedCryptoFirst;
  String? selectedCryptoSecond;
  double exchangeAmountFirst = 0.0;
  double exchangeAmountSecond = 0.0;
  TextEditingController amountControllerFirst = TextEditingController();
  TextEditingController amountControllerSecond = TextEditingController();
  FocusNode _amountFocusNodeFirst = FocusNode(); // Фокус для первого поля ввода
  FocusNode _amountFocusNodeSecond = FocusNode(); // Фокус для второго поля ввода

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exchange',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1)
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.wait([fetchCryptocurrencies(), fetchRates()]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CryptoCurrency> cryptocurrencies = snapshot.data![0];
            List<Rate> rates = snapshot.data![1];

            if (selectedCryptoFirst == null && cryptocurrencies.isNotEmpty) {
              selectedCryptoFirst = cryptocurrencies[0].currencyCode;
            }

            if (selectedCryptoSecond == null && cryptocurrencies.length > 1) {
              selectedCryptoSecond = cryptocurrencies[1].currencyCode;
            }

            return Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildCryptoContainer(
                    selectedCryptoFirst,
                    exchangeAmountFirst,
                    cryptocurrencies,
                    rates,
                    onCryptoChanged: (String? newValue) {
                      setState(() {
                        selectedCryptoFirst = newValue;
                        updateExchangeAmountSecond(rates);
                      });
                    },
                    onAmountChanged: (value) {
                      exchangeAmountFirst = double.tryParse(value) ?? 0.0;
                      updateExchangeAmountSecond(rates);
                      _amountFocusNodeFirst.requestFocus();
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                        }// ваш код setState
                      );
                    }); // Вызываем setState для обновления только текущего виджета
                      
                    },
                    amountFocusNode: _amountFocusNodeFirst, // Передаем FocusNode в качестве аргумента
                  ),
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: IconButton(
                        style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 255, 255, 1))),
                        icon: Icon(Icons.swap_vert ,),
                        iconSize: 25,
                        onPressed: swapCryptos,
                      ),
                    ),
                  ),
                  buildCryptoSecondContainer(
                    selectedCryptoSecond,
                    exchangeAmountSecond,
                    cryptocurrencies,
                    rates,
                    isReadOnly: true,
                    onCryptoChanged: (String? newValue) {
                      setState(() {
                        selectedCryptoSecond = newValue;
                        updateExchangeAmountSecond(rates);
                      });
                    },
                    amountFocusNode: _amountFocusNodeSecond,
                  ),
                  SizedBox(height:8),
                  buildExchangeRateContainer(rates),
                  SizedBox(height: 20),
                  ElevatedButton(
                    
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 1)) , 
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0), // Радиус скругления кнопки
                        ),
                      ),
                    ),
                    onPressed: () async{
                      var code = await exchangeCrypto(
                        selectedCryptoFirst!,
                        exchangeAmountFirst,
                        selectedCryptoSecond!,
                        exchangeAmountSecond,
                      );
                      if (code == 200) {
                        // Операция обмена прошла успешно
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('The exchange was successful.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // закрываем диалоговое окно
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Fail'),
                              content: Text('The exchange failed.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // закрываем диалоговое окно
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Exchange'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void updateExchangeAmountSecond(List<Rate> rates) {
    Rate? rateFirst = getRate(selectedCryptoFirst, rates);
    Rate? rateSecond = getRate(selectedCryptoSecond, rates);
    if (rateFirst != null && rateSecond != null && rateFirst.priceUsd != 0) {
      exchangeAmountSecond = exchangeAmountFirst * rateFirst.priceUsd / rateSecond.priceUsd;
    } else {
      exchangeAmountSecond = 0.0;
    }
  }

  void swapCryptos() {
    setState(() {
      String? tempCrypto = selectedCryptoFirst;
      selectedCryptoFirst = selectedCryptoSecond;
      selectedCryptoSecond = tempCrypto;

      //double tempAmount = exchangeAmountFirst;
      exchangeAmountFirst = 0.0;
      exchangeAmountSecond = 0.0;
      
    });
  }

  Rate? getRate(String? symbol, List<Rate> rates) {
    return rates.firstWhere((rate) => rate.symbol == symbol, orElse: () => Rate(symbol: '', name: '', coinId: 0, rank: 0, priceUsd: 0.0, percentChange24h: 0.0, percentChange1h: 0.0, percentChange7d: 0.0, priceBtc: 0.0));
  }

  Widget buildCryptoContainer(String? crypto, double amount, List<CryptoCurrency> cryptocurrencies, List<Rate> rates, {bool isReadOnly = false, void Function(String?)? onCryptoChanged, void Function(String)? onAmountChanged,FocusNode? amountFocusNode}) {
    CryptoCurrency? selectedCurrency = cryptocurrencies.firstWhere((c) => c.currencyCode == crypto, orElse: () => CryptoCurrency(currencyCode: '', currencyName: '', currencyAmount: 0.0, currencyAddress: '', id: 0));
    double priceInUsd = rates.firstWhere((r) => r.symbol == crypto, orElse: () => Rate(symbol: '', name: '', coinId: 0, rank: 0, priceUsd: 0.0, percentChange24h: 0.0, percentChange1h: 0.0, percentChange7d: 0.0, priceBtc: 0.0)).priceUsd * amount;

    return Container(
      width: 390,
      height: 120,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[crypto] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                    
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: crypto,
                items: cryptocurrencies.map<DropdownMenuItem<String>>((CryptoCurrency currency) {
                  return DropdownMenuItem<String>(
                    value: currency.currencyCode,
                    child: Text(currency.currencyCode),
                  );
                }).toList(),
                onChanged: onCryptoChanged,
              ),
              Text(selectedCurrency.currencyName, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(width: 120,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  focusNode: amountFocusNode,
                  readOnly: isReadOnly,
                  controller: isReadOnly ? amountControllerSecond : amountControllerFirst,
                  keyboardType: TextInputType.number,
                  onChanged: onAmountChanged,
                  decoration: InputDecoration(
                    hintText: amount.toString(),
                  ),
                ),
              ),
              Text('\$${priceInUsd.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildCryptoSecondContainer(String? crypto, double amount, List<CryptoCurrency> cryptocurrencies, List<Rate> rates, {bool isReadOnly = false, void Function(String?)? onCryptoChanged, void Function(String)? onAmountChanged,FocusNode? amountFocusNode}) {
    CryptoCurrency? selectedCurrency = cryptocurrencies.firstWhere((c) => c.currencyCode == crypto, orElse: () => CryptoCurrency(currencyCode: '', currencyName: '', currencyAmount: 0.0, currencyAddress: '', id: 0));
    double priceInUsd = rates.firstWhere((r) => r.symbol == crypto, orElse: () => Rate(symbol: '', name: '', coinId: 0, rank: 0, priceUsd: 0.0, percentChange24h: 0.0, percentChange1h: 0.0, percentChange7d: 0.0, priceBtc: 0.0)).priceUsd * amount;

    return Container(
      width: 390,
      height: 120,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(bottomLeft: Radius.zero , bottomRight: Radius.zero , topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Image.asset(
                                          //'icons/8546828_bitcoin_icon.png',
                                          cryptoIcons[crypto] ?? 'icons/4511328_adoption_coin_cryptocurrency_ecosystem_tether_icon.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                    
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: crypto,
                items: cryptocurrencies.map<DropdownMenuItem<String>>((CryptoCurrency currency) {
                  return DropdownMenuItem<String>(
                    value: currency.currencyCode,
                    child: Text(currency.currencyCode),
                  );
                }).toList(),
                onChanged: onCryptoChanged,
              ),
              Text(selectedCurrency.currencyName, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(width: 120,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  focusNode: amountFocusNode,
                  readOnly: isReadOnly,
                  controller: isReadOnly ? amountControllerSecond : amountControllerFirst,
                  keyboardType: TextInputType.number,
                  onChanged: onAmountChanged,
                  decoration: InputDecoration(
                    hintText: amount.toString(),
                  ),
                ),
              ),
              Text('\$${priceInUsd.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildExchangeRateContainer(List<Rate> rates) {
    double rate = calculateExchangeRate(rates);

    return Container(
      width: 390,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(40, 75, 99, 1),
        borderRadius: BorderRadius.only(topLeft: Radius.zero , topRight: Radius.zero , bottomLeft: Radius.circular(25) , bottomRight: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Exchange Rate', style: TextStyle(fontSize: 14)),
          // SizedBox(height: 6),
          Text(
            '1 $selectedCryptoFirst = ${rate.toStringAsFixed(8)} $selectedCryptoSecond',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ],
      ),
    );
  }

  double calculateExchangeRate(List<Rate> rates) {
    Rate? rateFirst = getRate(selectedCryptoFirst, rates);
    Rate? rateSecond = getRate(selectedCryptoSecond, rates);
    if (rateFirst != null && rateSecond != null && rateFirst.priceUsd != 0) {
      return rateFirst.priceUsd / rateSecond.priceUsd;
    }
    return 0.0;
  }
}

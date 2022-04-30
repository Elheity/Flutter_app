import 'package:firebasetest/ui/screens/info.dart';
import 'package:flutter/material.dart';
import '/ui/screens/auth_screen.dart';
import '/ui/screens/home_screen.dart';
import '/ui/screens/intro_screen.dart';
import '/ui/screens/info.dart';
import '/ui/screens/products.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';
import '/ui/screens/product_details.dart';
import '/ui/screens/add_products.dart';
import '/ui/screens/main_drawer.dart';
import '/ui/screens/main_drawer2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<Products>(
        create: (_) => Products(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xfff2f9fe),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      home: IntroScreen(),
      routes: {
        'intro': (context) => IntroScreen(),
        'customer': (context) => MyHome(),
        'home': (context) => MyHomePage(),
        'login': (context) => AuthScreen(authType: AuthType.login),
        'register': (context) => AuthScreen(authType: AuthType.register),
        'info': (context) => Information(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthBase authBase = AuthBase();
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Products>(context, listen: false)
        .fetchData()
        .then((_) => _isLoading = false)
        .catchError((onError) => print(onError));

    super.initState();
  }

  Widget detailCard(id, tile, desc, price, imageUrl) {
    return Builder(
      builder: (innerContext) => FlatButton(
        onPressed: () {
          print(id);
          Navigator.push(
            innerContext,
            MaterialPageRoute(builder: (_) => ProductDetails(id)),
          ).then(
              (id) => Provider.of<Products>(context, listen: false).delete(id));
        },
        child: Column(
          children: [
            Container(
              width: 0.0,
              height: 0.0,
            ),
            SizedBox(height: 5),
            Card(
              elevation: 10,
              color: Color.fromRGBO(0, 0, 10, .4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      width: 140,
                      height: 170,
                      child: Hero(
                        tag: id,
                        child: Image.network(imageUrl, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          tile,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                        ),
                        Divider(color: Colors.white),
                        Container(
                          width: 200,
                          child: Text(
                            desc,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                        ),
                        Divider(color: Colors.white),
                        Text(
                          "\$$price",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(height: 13),
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Courses'),
        backgroundColor: Colors.black,
        actions: [
          FlatButton(
            onPressed: () async {
              await authBase.logout();
              Navigator.of(context).pushReplacementNamed('intro');
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (prodList.isEmpty
              ? Center(
                  child: Text('No Products Added.',
                      style: TextStyle(fontSize: 22)))
              : RefreshIndicator(
                  onRefresh: () async =>
                      await Provider.of<Products>(context, listen: false)
                          .fetchData(),
                  child: ListView(
                    children: prodList
                        .map(
                          (item) => detailCard(item.id, item.title,
                              item.description, item.price, item.imageUrl),
                        )
                        .toList(),
                  ),
                )),
      /*floatingActionButton: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.black,
        ),
        child: FlatButton.icon(
          label: Text("Add Product",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.white)),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddProduct())),
        ),
      ),*/
      drawer: MainDrawer(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  AuthBase authBase = AuthBase();
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Products>(context, listen: false)
        .fetchData()
        .then((_) => _isLoading = false)
        .catchError((onError) => print(onError));

    super.initState();
  }

  Widget detailCard(id, tile, desc, price, imageUrl) {
    return Builder(
      builder: (innerContext) => FlatButton(
        onPressed: () {
          print(id);
          Navigator.push(
            innerContext,
            MaterialPageRoute(builder: (_) => ProductDetails(id)),
          ).then(
              (id) => Provider.of<Products>(context, listen: false).delete(id));
        },
        child: Column(
          children: [
            Container(
              width: 0.0,
              height: 0.0,
            ),
            SizedBox(height: 5),
            Card(
              elevation: 10,
              color: Color.fromRGBO(0, 0, 10, .4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      width: 130,
                      height: 150,
                      child: Hero(
                        tag: id,
                        child: Image.network(imageUrl, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          tile,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(color: Colors.white),
                        Container(
                          width: 200,
                          child: Text(
                            desc,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                        ),
                        Divider(color: Colors.white),
                        Text(
                          "\ pound $price",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(height: 13),
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        backgroundColor: Colors.black,
        actions: [
          FlatButton(
              onPressed: () async {
                await authBase.logout();
                Navigator.of(context).pushReplacementNamed('intro');
              },
              child: Icon(Icons.outbox)),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (prodList.isEmpty
              ? Center(
                  child: Text('No Products Added.',
                      style: TextStyle(fontSize: 22)))
              : RefreshIndicator(
                  onRefresh: () async =>
                      await Provider.of<Products>(context, listen: false)
                          .fetchData(),
                  child: ListView(
                    children: prodList
                        .map(
                          (item) => detailCard(item.id, item.title,
                              item.description, item.price, item.imageUrl),
                        )
                        .toList(),
                  ),
                )),
      drawer: MainDrawer2(),
    );
  }
}

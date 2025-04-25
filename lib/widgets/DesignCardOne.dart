import 'package:flutter/material.dart';
import 'package:simprodis_flutter/widgets/menu_utama.dart';

class Designcardone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Demo());
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img/backgroundlogin.png',
                    ), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                height: 150,
                child: const Center(child: Text('Background image goes here')),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.62, 0.93),
                    end: Alignment(1.30, -0.49),
                    colors: [const Color(0xFFE6E6E6), const Color(0xFFDCF6FA)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 50.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Selamat bertugas, Wahyudi',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromRGBO(26, 131, 188, 1),
                              ),
                              softWrap: true,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Username, Wahyudi',
                              style: TextStyle(fontSize: 14.0),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/img/user.png',
                              ), // Replace with your image path
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Menu_utama(
                              color: Color.fromRGBO(26, 131, 188, 1),
                              title: 'INTAKE',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Tapped on Menu');
                              },
                            ),
                            Menu_utama(
                              color: Color.fromRGBO(26, 188, 139, 1),
                              title: 'Uji Kualitas Air Instalasi Harian',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Tapped on Menu');
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Menu_utama(
                              color: Color.fromRGBO(26, 131, 188, 1),
                              title: 'IPA',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Tapped on Menu');
                              },
                            ),
                            Menu_utama(
                              color: Color.fromRGBO(26, 188, 139, 1),
                              title: 'Uji Kualitas Air Instalasi Lengkap',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Tapped on Menu');
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Menu_utama(
                              color: Color.fromRGBO(26, 131, 188, 1),
                              title: 'Booster Pump',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Tapped on Menu');
                              },
                            ),
                            Menu_utama(
                              color: Color.fromRGBO(26, 188, 139, 1),
                              title: 'Uji Kualitas Air Pelanggan',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Tapped on Menu');
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Menu_utama(
                              color: Colors.red,
                              title: 'Padam Listrik',
                              icon: Icons.menu,
                              onTap: () {
                                // Handle menu tap
                                print('Padam Listrik');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 100, // (background container size) - (circle height / 2)
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Color(0xFFF6FBFF),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/img/logosimprobg.png',
                          ), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SIMPRO',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            'SISTEM INFORMASI MONITORING PRODUKSI',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromRGBO(26, 131, 188, 1),
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

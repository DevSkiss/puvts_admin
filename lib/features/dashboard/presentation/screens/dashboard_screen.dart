import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puvts_admin/core/app/locator_injection.dart';
import 'package:puvts_admin/core/constants/puvts_colors.dart';
import 'package:puvts_admin/core/utils/dialog_util.dart';
import 'package:puvts_admin/features/login/data/service/auth_service_api.dart';
import 'package:puvts_admin/features/login/presentation/screens/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('user_type', isEqualTo: 'driver')
      .snapshots();
  final AuthApiService _authApiService = locator<AuthApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await _authApiService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(32),
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Drivers Table',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => DialogUtils().showAddDialog(context),
                  icon: Icon(
                    Icons.add_circle_rounded,
                    size: 30,
                    color: puvtsBlue,
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: DataTable(
                        dividerThickness: 5,
                        columnSpacing: 50,
                        showBottomBorder: true,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'FIRST NAME',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'LAST NAME',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'EMAIL',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'ACTION',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        rows: snapshot.data?.docs.map((driver) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(driver.id)),
                                  DataCell(Text(driver['firstname'])),
                                  DataCell(Text(driver['lastname'])),
                                  DataCell(Text(driver['email'])),
                                  DataCell(Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                            onTap: () =>
                                                DialogUtils().showUpdateDialog(
                                                  context,
                                                  id: driver.id,
                                                  firstname:
                                                      driver['firstname'],
                                                  lastname: driver['lastname'],
                                                  email: driver['email'],
                                                  onPressed: () {},
                                                ),
                                            child: Icon(
                                              Icons.edit,
                                              color: puvtsBlue,
                                            )),
                                      ),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                            onTap: () =>
                                                DialogUtils().showDelete(
                                                  context,
                                                  id: driver.id,
                                                ),
                                            child: Icon(
                                              Icons.delete,
                                              color: puvtsRed,
                                            )),
                                      )
                                    ],
                                  ))
                                ],
                              );
                            }).toList() ??
                            []),
                  );
                }
                return Text(
                  'No Drivers',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

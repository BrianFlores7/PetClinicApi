import 'package:flutter/material.dart';
import 'add_duenno_view.dart';
import '../../controller/owner_controller.dart';
import '../Repository/list_owner_repository.dart';
import '../Model/owner_model.dart';
import 'edit_duenno.dart';

class ListOwnersView extends StatefulWidget {
  ListOwnersView({Key? key}) : super(key: key);

  @override
  State<ListOwnersView> createState() => _ListOwnersViewState();
}

class _ListOwnersViewState extends State<ListOwnersView> {
  @override
  Widget build(BuildContext context) {
    var listOwnerController = ListOwnerController(ListOwnerRepository());

    listOwnerController.fetchListOwner();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dueño"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');  
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<ListOwner>>(
        future: listOwnerController.fetchListOwner(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var listOwners = snapshot.data?[index];
                return Container(
                  height: 250,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 100),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Text("ID: ${listOwners?.idDuenio}",style:TextStyle(fontSize: 18))),
                        Expanded(flex: 1, child: Text("NOMBRE: ${listOwners?.nombre}",style:TextStyle(fontSize: 18))),
                        Expanded(flex: 1, child: Text("TELEFONO: ${listOwners?.telefono}",style:TextStyle(fontSize: 18))),
                        Expanded(flex: 1, child: Text("DIRECCIÓN: ${listOwners?.direccion}",style:TextStyle(fontSize: 18))),
                        Expanded(flex: 1, child: Text("EMAIL: ${listOwners?.email}",style:TextStyle(fontSize: 18))),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 70, right: 20),
                                width: 100,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditOwner(listOwners),
                                      ),
                                    );
                                  },
                                  child: buildCallContainer(
                                    "Edit",
                                    Colors.greenAccent,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                                width: 100,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      listOwnerController
                                          .deleteListOwner(listOwners!)
                                          .then((value) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(milliseconds: 700),
                                            content: Text("${value}"),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                  child: buildCallContainer(
                                    "delete",
                                    Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 0.5, height: 0.5);
              },
              itemCount: snapshot.data?.length ?? 0);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOwner(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text("${title}")),
    );
  }
}

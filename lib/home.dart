import 'package:first_app/bloc/app_bloc.dart';
import 'package:first_app/bloc/app_states.dart';
import 'package:first_app/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './mycard.dart';
import './user_class.dart';
import 'bloc/app_events.dart';

const List<String> list = <String>['id', 'name', 'company'];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  String sort = 'id';
  String search_string = "";

  void update_search_string(String value) {
    setState(() {
      search_string = value;
    });
  }

  void update_sort(String value1) {
    setState(() {
      sort = value1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
          RepositoryProvider.of<UserRepository>(context),
          "https://jsonplaceholder.typicode.com/users",
          0)
        ..add(LoadUserEvent()),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            centerTitle: false,
            title: const Text("Contact"),
            backgroundColor: Color.fromARGB(255, 48, 48, 48),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 82, 82, 82),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  width: 120,
                  height: 80,
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                  child: Row(
                    children: [
                      SearchBar(update_search_string),
                      const Icon(Icons.search,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 82, 82, 82),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  width: 110,
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: Dropdown(update_sort),
                ),
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 0, 117, 212),
                  Color.fromARGB(255, 157, 0, 209)
                ],
              ),
            ),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is UserLoadedState) {
                  List<user> userValues1 = state.users;
                  List<user> userValues2 = [...userValues1];

                  RegExp exp = RegExp(search_string);
                  userValues2.retainWhere((u) {
                    return u.name.toString().toLowerCase().contains(exp);
                  });

                  switch (sort) {
                    case 'id':
                      userValues2.sort((a, b) => (a.id).compareTo(b.id));
                      break;
                    case 'name':
                      userValues2.sort((a, b) => (a.name).compareTo(b.name));
                      break;
                    default:
                      userValues2
                          .sort((a, b) => (a.company).compareTo(b.company));
                      break;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              ...(userValues2).map(
                                (element) {
                                  return MyWidget(user_: element);
                                },
                              ).toList(),
                              Center(
                                child: userValues2.isEmpty
                                    ? const Text(
                                        "No Result Found",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      )
                                    : const Text(""),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Text('error');
              },
            ),
          )),
    );
  }
}

class Dropdown extends StatefulWidget {
  final Function update_sort;

  const Dropdown(this.update_sort, {super.key});

  @override
  State<Dropdown> createState() => _DropdownState(update_sort);
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = list.first;
  final Function update_sort;

  _DropdownState(this.update_sort);
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      dropdownColor: Color(0xff2d2d2d),
      icon: const Icon(Icons.sort, color: Color.fromARGB(255, 255, 255, 255)),
      elevation: 16,
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          update_sort(value);
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function search_text_handler;

  const SearchBar(this.search_text_handler);

  @override
  // ignore: no_logic_in_create_state
  State<SearchBar> createState() => _SearchBarState(search_text_handler);
}

class _SearchBarState extends State<SearchBar> {
  final Function search_text_handler;

  _SearchBarState(this.search_text_handler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 80,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: TextField(
        onChanged: (val) {
          search_text_handler(val.toLowerCase());
        },
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
          ),
          hintText: ' search',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          focusColor: Color.fromARGB(255, 255, 255, 255),
        ),
        autocorrect: true,
        cursorColor: const Color.fromARGB(255, 255, 255, 255),
        style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
      ),
    );
  }
}

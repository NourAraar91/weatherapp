import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';
import 'package:weatherapp/ui/widgets/navbar_widget.dart';
import 'package:weatherapp/ui/widgets/search_bar_text_field_widget.dart';

class WorldCitiesPage extends StatefulWidget {
  WorldCitiesPage({Key key, this.items, this.onSelectItem}) : super(key: key);
  final List<String> items;
  final Function(int, String) onSelectItem;

  @override
  _WorldCitiesPageState createState() => _WorldCitiesPageState();
}

class _WorldCitiesPageState extends State<WorldCitiesPage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> itemsList;
  List<String> searchList = [];
  var isSearching = false;
  var count = 0;

  @override
  void initState() {
    itemsList = widget.items;
    count = itemsList.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: 'Cities',
        hideNavBar: true,
        backButtonColor: Colors.black,
        showBackButton: true,
      ),
      body: InkWell(
        onTap: () {
          focusNode.unfocus();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              SearchBarTextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (query) {
                  searchFor(query);
                },
              ),
              Expanded(child: listText())
            ],
          ),
        ),
      ),
    );
  }

  searchFor(String query) {
    var tempItem = itemsList;
    if (query.isNotEmpty) {
      isSearching = true;
      List<String> dummyListData = [];
      tempItem.forEach((user) {
        if (user.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(user);
        }
      });

      setState(() {
        searchList.clear();
        searchList.addAll(dummyListData);
      });

      return;
    } else {
      isSearching = false;
      setState(() {
        searchList.clear();
        searchList.addAll(itemsList);
      });
    }
  }

  listText() {
    var items = List<String>();
    if (isSearching) {
      items = searchList;
    } else {
      items = itemsList;
    }
    items.sort();
    return SideHeaderListView(
      // Set how many items the list has
      itemCount: items.length,

      // Set the height of the item widgets. For now this has to be a fixed height
      itemExtend: 75.0,

      // Set the header builder, this needs to return the widget for the side header
      headerBuilder: (BuildContext context, int index) {
        if (items.length > 0) {
          return new HeaderWidget(index: items[index][0]);
        }
        return Container();
      },

      // Set the item builder, this is everything in the row without the header
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: InkWell(
              onTap: () {
                widget.onSelectItem(index, items[index]);
              },
              child: ListItem(title: items[index])),
        );
      },

      // HasSameHeader will be used to know whether the header has to be shown for a position
      hasSameHeader: (int a, int b) {
        if (items.length > 0) {
          return items[a][0].toLowerCase() == items[b][0].toLowerCase();
        } else {
          return false;
        }
      },
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String index;
  const HeaderWidget({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          index.toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  const ListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

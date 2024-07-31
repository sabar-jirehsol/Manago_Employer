import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class SearchBar extends StatefulWidget {
  final List<String>? searchSuggestions;
  final Function(String)? onCitySelected;

  const SearchBar({Key? key, this.searchSuggestions, this.onCitySelected})
      : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textController = TextEditingController();

  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchResults = widget.searchSuggestions!
          .where((suggestion) => suggestion
              .toLowerCase()
              .contains(_textController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 50,
          child: Center(
            child: TextField(
              controller: _textController,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                suffixIcon: Icon(Icons.search),
                prefixIcon: Icon(Icons.location_pin),
              ),
            ),
          ),
        ),
        if (_textController.text.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: kGreyColor.withOpacity(0.1),
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                  onTap: () {
                    _textController.text = _searchResults[index];
                    setState(() {
                      _searchResults = [];
                    });
                    widget.onCitySelected!(_searchResults[index]);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

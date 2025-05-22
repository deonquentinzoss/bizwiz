import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final List<String> searchHistory;
  final VoidCallback onClearHistory;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    required this.searchHistory,
    required this.onClearHistory,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  bool _showHistory = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _showHistory = _focusNode.hasFocus && _searchController.text.isEmpty;
    });
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      widget.onSearch(query);
      setState(() {
        _showHistory = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search companies...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _showHistory = true;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onSubmitted: _onSearch,
          onChanged: (value) {
            setState(() {
              _showHistory = value.isEmpty;
            });
          },
        ),
        if (_showHistory && widget.searchHistory.isNotEmpty)
          Positioned(
            top: 48, // Position below the search bar
            left: 0,
            right: 0,
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          'Recent Searches',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: widget.onClearHistory,
                          icon: const Icon(Icons.clear_all),
                          label: const Text('Clear History'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ...widget.searchHistory.map((query) {
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(query),
                      onTap: () {
                        _searchController.text = query;
                        _onSearch(query);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

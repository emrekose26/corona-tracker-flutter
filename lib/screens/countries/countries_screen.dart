import 'package:coronatracker/bloc/countries/bloc.dart';
import 'package:coronatracker/data/model/countries/countries_model.dart';
import 'package:coronatracker/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Countries extends StatefulWidget {
  static const routeName = '/countries';
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  CountriesBloc countriesBloc;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  List<Country> _countryList = [];
  List<Country> _filteredList = [];

  @override
  void initState() {
    super.initState();
    countriesBloc = BlocProvider.of<CountriesBloc>(context);
    countriesBloc.add(FetchCountryCasesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          actions: _buildActions(),
          title: _isSearching
              ? _buildSearchField()
              : Text('Ülkelere Göre Rakamlar',
                  style: TextStyle(color: Colors.black)),
        ),
        body: Container(
          child: BlocListener<CountriesBloc, CountriesState>(
            listener: (context, state) {
              if (state is ErrorCountryCasesState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: BlocBuilder<CountriesBloc, CountriesState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is InitialCountriesState) {
                  return _buildLoading();
                } else if (state is LoadingCountryCasesState) {
                  return _buildLoading();
                } else if (state is LoadedCountryCasesState) {
                  _countryList = state.countriesResponse.countryList;
                  _filteredList = state.countriesResponse.countryList;
                  return _buildList(state.countriesResponse.countryList);
                } else if (state is ErrorCountryCasesState) {
                  return _buildErrorUi(state.message);
                }
              },
            ),
          ),
        ));
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Ülkeye göre filtrele...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      _filteredList = _countryList
          .where((country) => country.country.toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Widget _buildList(List<Country> countryList) {
    return RefreshIndicator(
      onRefresh: () async {
        countriesBloc.add(FetchCountryCasesEvent());
      },
      child: ListView.builder(
        itemCount: _filteredList.length,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            onTap: () {},
            title: Text(_filteredList[index].country,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(_filteredList[index].countryInfo.flag)),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Text("Vaka: " + Helper.formatNumber(_filteredList[index].cases),
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Text("Ölüm: " + Helper.formatNumber(_filteredList[index].deaths),
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Text(
                        "İyileşen: " + Helper.formatNumber(_filteredList[index].recovered),
                        style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

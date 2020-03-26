import 'package:coronatracker/bloc/countries/bloc.dart';
import 'package:coronatracker/data/model/countries/countries_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Countries extends StatefulWidget {
  static const routeName = '/countries';
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  CountriesBloc countriesBloc;

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
          title: Text('Ülkelere Göre Rakamlar',
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
                  return _buildList(state.countriesResponse.countryList);
                } else if (state is ErrorCountryCasesState) {
                  return _buildErrorUi(state.message);
                }
              },
            ),
          ),
        ));
  }

  Widget _buildList(List<Country> countryList) {
    return ListView.builder(
        itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                onTap: () {},
                title: Text(countryList[index].country,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(countryList[index].countryInfo.flag)),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Text(
                            "Vaka: " + countryList[index].cases.toString(),
                            style: TextStyle(color: Colors.orange))),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Text(
                            "Ölüm: " + countryList[index].deaths.toString(),
                            style: TextStyle(color: Colors.red))),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Text(
                            "İyileşen: " +
                                countryList[index].recovered.toString(),
                            style: TextStyle(color: Colors.lightGreen))),
                  ],
                ),
              ),
            ),
        itemCount: countryList.length);
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

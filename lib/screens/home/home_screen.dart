import 'package:coronatracker/bloc/all/all_bloc.dart';
import 'package:coronatracker/bloc/all/all_event.dart';
import 'package:coronatracker/bloc/all/all_state.dart';
import 'package:coronatracker/data/model/all/all_cases_model.dart';
import 'package:coronatracker/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AllBloc allBloc;

  @override
  void initState() {
    super.initState();
    allBloc = BlocProvider.of<AllBloc>(context);
    allBloc.add(FetchAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Corona Tracker', style: TextStyle(color: Colors.blueGrey)),
      ),
      body: Container(
        child: BlocListener<AllBloc, AllState>(
          listener: (context, state) {
            if(state is ErrorAllState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<AllBloc, AllState>(
            // ignore: missing_return
            builder: (context, state) {
              if(state is InitialAllState) {
                return _buildLoading();
              } else if(state is LoadingAllState) {
                return _buildLoading();
              } else if (state is LoadedAllState) {
                return _buildBody(state.response);
              } else if (state is ErrorAllState) {
                return _buildErrorUi(state.message);
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.search,
          color: Colors.blueGrey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 40.0,
        ),
      ),
    );
  }

  Widget _buildBody(AllCasesResponse allCases) {
    return Column(
      children: <Widget>[
        _chartWidget(),
        Row(
          children: <Widget>[
            Flexible(flex: 1, child: _allCasesCardWidget(allCases.cases)),
            Flexible(flex: 1, child: _deathsCardWidget(allCases.deaths))
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(flex: 1, child: _recoveredCardWidget(allCases.recovered)),
            Flexible(flex: 1, child: _activePatientsCardWidget(allCases.cases - allCases.recovered))
          ],
        )
      ],
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

  Widget _chartWidget() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Covid-19',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _allCasesCardWidget(int cases) {
    return MainCard(title: 'Tüm vakalar',img_path: 'virus.png',number: cases);
  }

  Widget _deathsCardWidget(int deaths) {
    return MainCard(title: 'Ölü sayısı',img_path: 'death.png',number: deaths);
  }

  Widget _recoveredCardWidget(int recovered) {
    return MainCard(title: 'Kurtarılan vakalar',img_path: 'recovered.png',number: recovered);
  }

  Widget _activePatientsCardWidget(int patient) {
    return MainCard(title: 'Hasta sayısı',img_path: 'patient.png',number: patient);
  }

}

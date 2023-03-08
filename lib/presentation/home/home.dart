import 'package:call_nfc/app/dependency_injection.dart';
import 'package:call_nfc/presentation/home/home_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _homeViewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _homeViewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.finish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder<String>(
              stream: _homeViewModel.outputReadNfc,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final cardNfc = snapshot.data;
                  return cardNfc != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(cardNfc.toString()),
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () =>
                                      _homeViewModel.callTo(cardNfc),
                                  child: Text('Llamar')),
                            )
                          ],
                        )
                      :   const Text('waiting hasData');
                } else if (snapshot.hasError) {
                  return const Text('hasError');
                } else {
                  return const Text('waiting else');
                }
              }),
        ),
      ),
    );
  }
}

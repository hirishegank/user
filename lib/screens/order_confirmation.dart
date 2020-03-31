import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderConfirmPage extends StatelessWidget {
  const OrderConfirmPage({Key key, @required this.isPast}) : super(key: key);
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Name'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/img/customizeFoodSample.png',
                    colorBlendMode: BlendMode.saturation,
                    color: isPast ? Colors.black : Colors.transparent,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The most delicious & flavorful Kari Virunthu',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Text('By Cooked Shan'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Ingredients',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'Ingredients rice, chicken, pudina, coriander leaves, onions, ginger garlic paste, chilli powder, turmeric powder, chicken masala, coriander powder, garam masala, biriyani leaves, curd, lemon',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isPast
                      ? Image.asset('assets/img/expQr.png')
                      : QrImage(
                          data: 'the code',
                          version: QrVersions.auto,
                          gapless: false,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please scan this qr code to confirm your food delivery.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

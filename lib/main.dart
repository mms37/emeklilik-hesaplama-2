import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Emeklilik Yaşı Hesaplama'),
        ),
        body: Center(
          child: RetirementAgeCalculator(),
        ),
      ),
    );
  }
}

enum Gender { Male, Female }

class RetirementAgeCalculator extends StatefulWidget {
  @override
  _RetirementAgeCalculatorState createState() => _RetirementAgeCalculatorState();
}

class _RetirementAgeCalculatorState extends State<RetirementAgeCalculator> {
  Gender selectedGender = Gender.Male;
  TextEditingController ageController = TextEditingController();
  TextEditingController totalWorkDaysController = TextEditingController();
  TextEditingController totalContributionDaysController = TextEditingController();
  String result = '';

  void _calculateRetirementAge() {
    int retirementAge;
    int age = int.tryParse(ageController.text) ?? 0;
    int totalWorkDays = int.tryParse(totalWorkDaysController.text) ?? 0;
    int totalContributionDays = int.tryParse(totalContributionDaysController.text) ?? 0;

    if (selectedGender == Gender.Male && totalContributionDays >= 7200 && totalWorkDays >= 25 * 365) {
      retirementAge = 60;
    } else if (selectedGender == Gender.Female && totalContributionDays >= 7200 && totalWorkDays >= 20 * 365) {
      retirementAge = 58;
    } else {
      setState(() {
        result = 'Emekli olmak için yeterli şartları sağlamıyorsunuz.';
      });
      return;
    }

    int yearsRemaining = retirementAge - age;
    int remainingWorkDays = (yearsRemaining * 365) - totalWorkDays;
    int remainingContributionDays = 7200 - totalContributionDays;

    setState(() {
      result = 'Emekli olmak için $yearsRemaining yılınız var.\n'
          'Kalan Çalışma Günü: $remainingWorkDays\n'
          'Kalan Prim Günü: $remainingContributionDays';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Cinsiyetinizi Seçin:',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: Gender.Male,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            Text('Erkek'),
            Radio(
              value: Gender.Female,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            Text('Kadın'),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Yaşınızı girin',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            controller: totalWorkDaysController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Toplam Çalışma Gününüzü girin (yıl bazında)',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            controller: totalContributionDaysController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Toplam Prim Gününüzü girin',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _calculateRetirementAge();
          },
          child: Text('Emeklilik Yaşı Hesapla'),
        ),
        SizedBox(height: 20),
        Text(
          result,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

//State shifting
class _PasswordGeneratorState extends State<PasswordGenerator> {
  List char = [];
  var symbols = "!@#\$%^&*";
  var password = [];
  bool? hasNumbers = true;
  bool? hasSymbols = true;
  bool? hasUppercase = true;
  bool? hasLowercase = true;
  double length = 8;

//password generator method
  void generatePassword() {
    char = [];

    if (hasNumbers!) {
      List.generate(10, (index) => char.add(String.fromCharCode(index + 48)));
    }
    if (hasSymbols!) {
      List.generate(8, (index) => char.add(symbols[index]));
    }
    if (hasUppercase!) {
      List.generate(26, (index) => char.add(String.fromCharCode(index + 65)));
    }
    if (hasLowercase!) {
      List.generate(26, (index) => char.add(String.fromCharCode(index + 97)));
    }
    if (char.isNotEmpty) {
      char.shuffle();

      password = [];
      final random = math.Random();
      for (int i = 0; i < length; i++) {
        password.add(char[random.nextInt(char.length - 1)]);
      }
      password.shuffle();
      setState(() {});
    } else {
      password = [];
      setState(() {});
    }
  }

//State initiation
  @override
  void initState() {
    generatePassword();
    super.initState();
  }

//Home Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            password.isEmpty
                ? const Text(
                    'Please select atleast one option',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  )
                : FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            password.join(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          tooltip: 'Copy Password',
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: password.join()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Password Copied'),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckBoxs(
                        checkBoxText: 'A-Z',
                        index: 3,
                        value: hasUppercase,
                        onChanged: (value) {
                          setState(() {
                            hasUppercase = value;
                          });
                        },
                      ),
                      CheckBoxs(
                        checkBoxText: '0-9',
                        index: 3,
                        value: hasNumbers,
                        onChanged: (value) {
                          setState(() {
                            hasNumbers = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckBoxs(
                      checkBoxText: 'a-z',
                      index: 4,
                      value: hasLowercase,
                      onChanged: (value) {
                        setState(() {
                          hasLowercase = value;
                        });
                      },
                    ),
                    CheckBoxs(
                      checkBoxText: '!@#\$%^&*',
                      index: 4,
                      value: hasSymbols,
                      onChanged: (value) {
                        setState(() {
                          hasSymbols = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Align(
              widthFactor: 2.5,
              child: Text(
                'Length: ${length.toInt()}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              width: 400,
              child: Slider(
                label: length.toString(),
                value: length,
                min: 8,
                max: 15,
                divisions: 7,
                onChanged: (value) {
                  setState(() {
                    length = value;
                  });
                },
                onChangeEnd: (value) => generatePassword(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => generatePassword(),
              child: const Text(
                'GENERATE',
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 130, 0, 0)),
            const Center(
              child: Text(
                ' #Password_Generator',
                style: TextStyle(
                  letterSpacing: 9,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//stateless CheckBox Class
class CheckBoxs extends StatelessWidget {
  final String checkBoxText;
  final int index;
  final bool? value;
  final Function(bool?)? onChanged;
  const CheckBoxs({
    required this.checkBoxText,
    required this.index,
    required this.value,
    required this.onChanged,
    super.key,
  });

//CheckBox Widget
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          shape: const OvalBorder(),
        ),
        const SizedBox(width: 5),
        Text(
          checkBoxText,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}



//Author:@lavanyan.fr
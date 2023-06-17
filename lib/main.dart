import 'package:calculadora_cientifica/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  
  var userQuestion = '';
  var userAnswer = '';
  
  final myTextStlye = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);
  
  final List<String> buttons =
  [ 'C', 'Del', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(height: 50,),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(userQuestion, style: const TextStyle(fontSize: 20),)),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(userAnswer, style: const TextStyle(fontSize: 20),))
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
              itemCount: buttons.length,
              itemBuilder: (BuildContext context,int index) {
                
                
                //Boton de Limpiar
                if (index == 0) {
                  return MyButtons(
                    buttonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
                    buttonTapped: (){
                      setState(() {
                      userQuestion = '';
                      });
                    }
                  );
                  
                //Botón de borrar
                } else if (index == 1){
                  return MyButtons(
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonTapped: (){
                      setState(() {
                      userQuestion = userQuestion.substring(0, userQuestion.length-1);
                      });
                    }
                  );
                  
                  //Boton de Igual
                } else if (index == buttons.length-1){
                  return MyButtons(
                    buttonText: buttons[index],
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    buttonTapped: (){
                      setState(() {
                      equalPressed();
                      });
                    }
                  );
                  
                //Resto de Botones
                } else {
                  return MyButtons(
                    buttonText: buttons[index],
                    color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                    textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                    buttonTapped: (){
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                  );
                }
              })
            ),
        ],
      ),
    );
  }
  
  bool isOperator(String x){
    if(x =='%' || x == '/' || x =='x' || x =='-' || x =='+' || x =='='){
      return true;
    }
    return false;
  }
  
  void equalPressed (){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    
    userAnswer = eval.toString();
  }
}

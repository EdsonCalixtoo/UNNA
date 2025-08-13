import 'package:flutter/material.dart';
import 'package:unna/utils/colors.dart';

class BotaoSimples extends StatelessWidget {
  final Function executarAcao;
  final String textoBotao;
  final Icon? iconeBotao;
  final double? width;

  const BotaoSimples({
    super.key,
    required this.executarAcao,
    required this.textoBotao,
    this.iconeBotao,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () {
          executarAcao();
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                corPrimariaClara,
                corPrimaria,
              ],
            ),
            borderRadius: BorderRadius.circular(80),
          ),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 88,
              minHeight: 36,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 55,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (iconeBotao != null)
                  Container(
                    child: iconeBotao,
                  ),
                if (iconeBotao != null)
                  SizedBox(
                    width: 8,
                  ),
                Text(
                  textoBotao,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:unna/utils/colors.dart';

class BotaoCortado extends StatelessWidget {
  final Function executarAcao;
  final String textoBotao;
  final Icon? iconeBotao;

  const BotaoCortado({
    super.key,
    required this.executarAcao,
    required this.textoBotao,
    this.iconeBotao,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(90),
        topRight: Radius.circular(90),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(90),
              topRight: Radius.circular(90),
            ),
          ),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () {
          executarAcao();
        },
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                corPrimaria,
                corPrimaria,
                corPrimariaClara,
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(90),
              topRight: Radius.circular(90),
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 88,
              minHeight: 36,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 2),
            height: 59,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (iconeBotao != null)
                  Container(
                    child: iconeBotao,
                  ),
                if (iconeBotao != null)
                  SizedBox(
                    width: 10,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

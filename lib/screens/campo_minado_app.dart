import 'dart:math';

import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/model/campo.dart';
import 'package:campo_minado/model/explosao_exception.dart';
import 'package:campo_minado/model/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu;
  Tabuleiro _tabuleiro;

  void _reiniciar() {
    setState(() {
      _venceu = null;
    _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarmarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      campo.alternarMarcado();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro =
          Tabuleiro(qtdeBombas: Random().nextInt(51), colunas: qtdeColunas, linhas: qtdeLinhas);
    }

    return _tabuleiro;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return TabuleiroWidget(
                  tabuleiro: _getTabuleiro(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  ),
                  onAbrir: _abrir,
                  onAlternarMarcacao: _alternarmarcacao);
            },
          ),
        ),
      ),
    );
  }
}

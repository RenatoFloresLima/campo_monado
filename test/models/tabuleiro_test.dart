import 'package:campo_minado/model/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  
  test('Ganhar Jogo', (){

    Tabuleiro tabuleiro = Tabuleiro(colunas: 2, linhas: 2, qtdeBombas: 0);

    tabuleiro.campos[0].minar();
    tabuleiro.campos[3].minar();

    tabuleiro.campos[0].alternarMarcado();
    tabuleiro.campos[1].abrir();
    tabuleiro.campos[2].abrir();
    tabuleiro.campos[3].alternarMarcado();

    expect(tabuleiro.resolvido, isTrue);
    
  });
}
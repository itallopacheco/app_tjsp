import 'package:flutter/material.dart';

/// Widget que simula uma lista de cartões (cards) com dados fictícios.
class MockedCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de itens fictícios
    List<CardItem> mockedItems = [
      CardItem(
        title: 'Mapa precatório - 2023',
        subtitle: 'Nos termos do Art. 85, da Resolução CNJ nº 303.',
        date: '01/01/2023',
      ),
      CardItem(
        title: 'Mapa precatório - 2022',
        subtitle: 'Nos termos do Art. 85, da Resolução CNJ nº 303.',
        date: '02/01/2022',
      ),
      CardItem(
        title: 'Mapa precatório - 2021',
        subtitle: 'Nos termos do Art. 85, da Resolução CNJ nº 303.',
        date: '03/01/2021',
      ),
    ];

    // Retorna a lista de cartões utilizando a classe CardList
    return CardList(items: mockedItems);
  }
}

/// Widget que exibe uma lista de cartões (cards) com base em uma lista de itens.
class CardList extends StatelessWidget {
  final List<CardItem> items;

  // Construtor que recebe a lista de itens
  CardList({required this.items});

  @override
  Widget build(BuildContext context) {
    // Cria uma coluna de cartões com base nos itens fornecidos
    return Column(
      children: items.map((item) {
        return Card(
          child: ListTile(
            title: Text(item.title),
            subtitle: Text(item.subtitle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.date),
                SizedBox(width: 10),
                Icon(Icons.download),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Classe que representa um item de cartão (card) com título, subtítulo e data.
class CardItem {
  final String title;
  final String subtitle;
  final String date;

  // Construtor que exige título, subtítulo e data
  CardItem({required this.title, required this.subtitle, required this.date});
}

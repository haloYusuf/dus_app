import 'package:dus_app/config/constant.dart';
import 'package:dus_app/models/item_transaction.dart';
import 'package:dus_app/models/item_type.dart';
import 'package:dus_app/services/data.dart';
import 'package:flutter/material.dart';

class AddTypePage extends StatefulWidget {
  final String id;
  final List<ItemTransaction> item;
  const AddTypePage({
    super.key,
    required this.id,
    required this.item,
  });

  @override
  State<AddTypePage> createState() => _AddTypePageState();
}

class _AddTypePageState extends State<AddTypePage> {
  List<ItemType> dataType = [
    ItemType(
      img: 'plastic.png',
      title: 'Plastik',
      example: 'Contoh: Kresek',
      price: 1000,
    ),
    ItemType(
      img: 'paper.png',
      title: 'Kertas',
      example: 'Contoh: Buku, koran, kardus',
      price: 1000,
    ),
    ItemType(
      img: 'bottle.png',
      title: 'Botol',
      example: 'Contoh: Botol Mineral',
      price: 5000,
    ),
  ];

  int _selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.colorLightWhite,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 24,
            color: Constant.colorBlack,
          ),
        ),
        title: const Center(
          child: Text(
            'Pilih Jenis',
            style: TextStyle(
              fontSize: 20,
              fontWeight: Constant.fontBold,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            runSpacing: 10,
            children: [
              for (final (index, model) in dataType.indexed)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedItem == index) {
                        _selectedItem = -1;
                      } else {
                        _selectedItem = index;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedItem == index
                          ? Constant.colorBlack.withOpacity(0.25)
                          : Constant.colorWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Constant.colorBlack.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          '${Constant.iconPath}/${model.img}',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: Constant.fontBold,
                                ),
                              ),
                              Text(
                                model.example,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Rp${model.price}/kg',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: Constant.fontSemiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                '${Constant.iconPath}/information.png',
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  'Harga yang tertera hanyalah estimasi, harga akhir akan ditentukan oleh pendaur ulang pada saat pengecekan langsung',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            widget.item.add(
              ItemTransaction(
                name: dataType[_selectedItem].img,
                type: dataType[_selectedItem].title,
                weight: 1,
                pricePerKg: dataType[_selectedItem].price,
              ),
            );
            if (_selectedItem > -1) {
              DataSampah.updateData(id: widget.id, dataEdit: {
                'items': widget.item.map((e) => e.toMap()).toList(),
              });
            }
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            backgroundColor: Constant.colorDarkPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Pilih',
            style: TextStyle(
              fontSize: 16,
              fontWeight: Constant.fontSemiBold,
              color: Constant.colorWhite,
            ),
          ),
        ),
      ),
    );
  }
}

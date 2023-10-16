import 'package:flutter/material.dart';

class RadioButtons extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(dynamic) setTriggerType;
  final dynamic value;
  final String title;

  const RadioButtons(
      {Key? key,
      required this.data,
      required this.setTriggerType,
      required this.value,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 5),
          Column(
            children: data.map((item) {
              return GestureDetector(
                onTap: () => setTriggerType(item['value']),
                child: Container(
                  decoration: BoxDecoration(
                    color: item['value'] == value
                        ? Colors.lightBlue
                        : Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  margin: const EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item['label']),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

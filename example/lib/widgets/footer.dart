import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final VoidCallback clearAllScans;
  final List<DecodedData> decodedDataList;
  final bool isOpen;
  final VoidCallback closeCapture;
  final VoidCallback openCapture;
  final bool useSocketCam;
  final ValueChanged<bool> setUseSocketCam;

  const FooterWidget({
    Key? key,
    required this.clearAllScans,
    required this.decodedDataList,
    required this.isOpen,
    required this.closeCapture,
    required this.openCapture,
    required this.useSocketCam,
    required this.setUseSocketCam,
  }) : super(key: key);

  void toggleView() {
    setUseSocketCam(!useSocketCam);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDD7E4),
      ),
      constraints: const BoxConstraints(
        minHeight: 100, // Set the minimum height here (100 in this example)
      ),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center, // To simulate 'alignItems: 'center''
      width: double.infinity, // To simulate 'width: '100%''
      height: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Scanned Data',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 100),
              child: decodedDataList.isNotEmpty
                  ? ListView.builder(
                      itemCount: decodedDataList.length,
                      itemBuilder: (context, index) {
                        final item = decodedDataList[index];
                        return Text(
                            "- ${item.name.toUpperCase()} (${item.data.length}) ${item.data}");
                      },
                    )
                  : const Center(
                      child: Text('No scans yet.'),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: clearAllScans,
                child: const Text('Clear'),
              ),
              ElevatedButton(
                onPressed: isOpen ? closeCapture : openCapture,
                child: Text(
                    isOpen ? 'Close Capture Client' : 'Open Capture Client'),
              ),
              ElevatedButton(
                onPressed: toggleView,
                child: Text(useSocketCam ? 'Back to Main' : 'Socket Cam'),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

// Define the styles
final footerStyles = {
  'scannedDataContainer': {
    'maxHeight': 100.0,
  },
  'buttonStyle': {
    'backgroundColor': Colors.blue,
  },
  'buttonGroup': {
    'position': 'absolute',
    'bottom': 0.0,
  },
  'viewSwitchStyle': {
    'textAlign': TextAlign.center,
  },
};

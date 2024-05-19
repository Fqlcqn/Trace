import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T R A C E',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const StartingPage(),
    );
  }
}


class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
  'https://i.pinimg.com/564x/49/86/9e/49869ea6002cd8b96ddf77bc5633c3cc.jpg', // Network image URL
  height: 150, // Adjust height as needed
  width: 150, // Adjust width as needed
  errorBuilder: (context, error, stackTrace) {
    print('Image loading error: $error');
    // Display placeholder or error message
    return Icon(Icons.error);
  },
),
            const SizedBox(height: 20),
            const Text(
              'T R A C E',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'T R A C E')),
                );
              },
              child: const Text('Get Started', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class LightBlueFolderWidget extends StatefulWidget {
  @override
  _LightBlueFolderWidgetState createState() => _LightBlueFolderWidgetState();
}

class _LightBlueFolderWidgetState extends State<LightBlueFolderWidget> {
  double positionX = 0;
  double positionY = 0;
  String folderName = ''; // New variable to hold folder name

  void _onDoubleTap() {
    // Navigate to a new page dedicated to the folder
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FolderDetailPage(folderName: folderName)), // Pass folderName to FolderDetailPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: positionX,
      top: positionY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            positionX += details.delta.dx;
            positionY += details.delta.dy;
          });
        },
        onDoubleTap: _onDoubleTap, // Handle double tap event
        child: Container(
          width: 250, // Adjust size as needed
          height: 250, // Adjust size as needed
          color: Colors.lightBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    folderName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter folder name',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.folder, size: 100, color: Colors.white), // Example icon, adjust as needed
            ],
          ),
        ),
      ),
    );
  }
}

class FolderDetailPage extends StatelessWidget {
  final String folderName;

  const FolderDetailPage({Key? key, required this.folderName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$folderName'), 
      ),
      body: Center(
        child: Text(' ' + folderName),
      ),
    );
  }
}




class _MyHomePageState extends State<MyHomePage> {

  void _showPinkButton() {
  // Implement the functionality for the pink button here
  // For example, you can navigate to a new page or perform any other action
  // when this button is pressed.
  print('Downloads/img_prompt');
}

  List<Widget> stickyNotes = [];
  List<Widget> additionalWidgets = []; // Store additional widgets
  int noteCounter = 0; // Unique identifier for each note
  final GlobalKey _deleteKey = GlobalKey(); // Key for the delete zone

  void _showStickyNote() {
    final screenSize = MediaQuery.of(context).size;
    final initialWidth = 200.0;
    final initialHeight = 150.0;

    setState(() {
      stickyNotes.add(
        ResizableDraggableWidget(
          key: ValueKey(noteCounter), // Unique key for each note
          initialWidth: initialWidth,
          initialHeight: initialHeight,
          initialTop: (screenSize.height - initialHeight) / 2,
          initialLeft: (screenSize.width - initialWidth) / 2,
          minWidth: 100,
          minHeight: 100,
          onDelete: () {
            setState(() {
              stickyNotes.removeWhere((note) => (note.key as ValueKey).value == noteCounter);
            });
          },
          deleteKey: _deleteKey, // Pass the delete zone key to the widget
        ),
      );
      noteCounter++; // Increment the note identifier
    });
  }

  void _showLightBlueFolder() {
    setState(() {
      additionalWidgets.add(
        Positioned(
          left: 0,
          top: 0,
          child: LightBlueFolderWidget(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ...stickyNotes,
          ...additionalWidgets, // Add additional widgets
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
  padding: const EdgeInsets.only(bottom: 0.0),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
        children: [
          FloatingActionButton(
            onPressed: _showStickyNote,
            tooltip: 'Add Evidence',
            backgroundColor: Colors.yellow, // Change background color to yellow
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          const SizedBox(width: 16), // Add spacing between buttons
          FloatingActionButton(
            onPressed: _showLightBlueFolder, // Show light blue folder
            backgroundColor: Colors.lightBlue, // Light blue background color
            tooltip: 'Create new Project',
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.black, // Black plus icon color
            ),
          ),
          const SizedBox(width: 16), // Add spacing between buttons
          FloatingActionButton(
            onPressed: _showPinkButton,
            backgroundColor: Colors.pinkAccent, // Light pink background color
            tooltip: 'Add Images',
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white, // White plus icon color
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width, // Stretch the width to the window's width
            height: 30, // Set the height to 30 pixels
            child: Container(
              key: _deleteKey,
              color: Colors.red, // Correctly setting the color to red
            ),
          ),
          const Text(
            'Drag notes here to delete',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ],
  ),
),
    );
  }
}

class ResizableDraggableWidget extends StatefulWidget {
  final double initialTop;
  final double initialLeft;
  final double initialWidth;
  final double initialHeight;
  final double minWidth;
  final double minHeight;
  final VoidCallback onDelete;
  final GlobalKey deleteKey; // Key for the delete zone

  const ResizableDraggableWidget({
    Key? key,
    required this.initialTop,
    required this.initialLeft,
    required this.initialWidth,
    required this.initialHeight,
    required this.minWidth,
    required this.minHeight,
    required this.onDelete,
    required this.deleteKey,
  }) : super(key: key);

  @override 
  _ResizableDraggableWidgetState createState() => _ResizableDraggableWidgetState();
}

class _ResizableDraggableWidgetState extends State<ResizableDraggableWidget> {
  late double top;
  late double left;
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    top = widget.initialTop;
    left = widget.initialLeft;
    width = widget.initialWidth;
    height = widget.initialHeight;
  }

  bool _isOverlappingDeleteZone() {
    final RenderBox renderBoxNote = context.findRenderObject() as RenderBox;
    final RenderBox renderBoxDelete = widget.deleteKey.currentContext!.findRenderObject() as RenderBox;

    final noteOffset = renderBoxNote.localToGlobal(Offset.zero);
    final deleteOffset = renderBoxDelete.localToGlobal(Offset.zero);

    final noteRect = Rect.fromLTWH(noteOffset.dx, noteOffset.dy, width, height);
    final deleteRect = Rect.fromLTWH(deleteOffset.dx, deleteOffset.dy, renderBoxDelete.size.width, renderBoxDelete.size.height);

    return noteRect.overlaps(deleteRect);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            top += details.delta.dy;
            left += details.delta.dx;
          });

          if (_isOverlappingDeleteZone()) {
            widget.onDelete();
          }
        },
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(color: Colors.black),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter evidence here',
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          expands: true,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: GestureDetector(
                        onTap: widget.onDelete,
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    width = (width + details.delta.dx).clamp(widget.minWidth, double.infinity);
                    height = (height + details.delta.dy).clamp(widget.minHeight, double.infinity);
                  });
                },
                child: const Icon(Icons.drag_handle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

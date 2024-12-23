import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubeScreen(),
    );
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  // Initial state of the cube (6 faces, each with 4 squares)
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
    [Colors.green, Colors.green, Colors.green, Colors.green], // Right
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
    [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
  ];

  void rotateTop() {
    setState(() {
      // Rotate the top face itself (clockwise)
      List<Color> temp = [
        faces[4][0],
        faces[4][1],
        faces[4][2],
        faces[4][3]
      ];
      faces[4][0] = temp[2];
      faces[4][1] = temp[0];
      faces[4][2] = temp[3];
      faces[4][3] = temp[1];

      // Update adjacent faces (front, left, back, right)
      List<Color> tempRow = [faces[0][0], faces[0][1]];
      faces[0][0] = faces[1][0];
      faces[0][1] = faces[1][1];
      faces[1][0] = faces[3][0];
      faces[1][1] = faces[3][1];
      faces[3][0] = faces[2][0];
      faces[3][1] = faces[2][1];
      faces[2][0] = tempRow[0];
      faces[2][1] = tempRow[1];
    });
  }

  void rotateBottom() {
    setState(() {
      // Rotate the bottom face itself (clockwise)
      List<Color> temp = [
        faces[5][0],
        faces[5][1],
        faces[5][2],
        faces[5][3]
      ];
      faces[5][0] = temp[2];
      faces[5][1] = temp[0];
      faces[5][2] = temp[3];
      faces[5][3] = temp[1];

      // Update adjacent faces (front, right, back, left)
      List<Color> tempRow = [faces[0][2], faces[0][3]];
      faces[0][2] = faces[2][2];
      faces[0][3] = faces[2][3];
      faces[2][2] = faces[3][2];
      faces[2][3] = faces[3][3];
      faces[3][2] = faces[1][2];
      faces[3][3] = faces[1][3];
      faces[1][2] = tempRow[0];
      faces[1][3] = tempRow[1];
    });
  }

  void rotateLeft() {
    setState(() {
      // Rotate the left face itself (clockwise)
      List<Color> temp = [
        faces[1][0],
        faces[1][1],
        faces[1][2],
        faces[1][3]
      ];
      faces[1][0] = temp[2];
      faces[1][1] = temp[0];
      faces[1][2] = temp[3];
      faces[1][3] = temp[1];

      // Update adjacent faces (top, front, bottom, back)
      List<Color> tempCol = [faces[4][0], faces[4][2]];
      faces[4][0] = faces[3][3];
      faces[4][2] = faces[3][1];
      faces[3][3] = faces[5][2];
      faces[3][1] = faces[5][0];
      faces[5][2] = faces[0][0];
      faces[5][0] = faces[0][2];
      faces[0][0] = tempCol[0];
      faces[0][2] = tempCol[1];
    });
  }

  void rotateRight() {
    setState(() {
      // Rotate the right face itself (clockwise)
      List<Color> temp = [
        faces[2][0],
        faces[2][1],
        faces[2][2],
        faces[2][3]
      ];
      faces[2][0] = temp[2];
      faces[2][1] = temp[0];
      faces[2][2] = temp[3];
      faces[2][3] = temp[1];

      // Update adjacent faces (top, back, bottom, front)
      List<Color> tempCol = [faces[4][1], faces[4][3]];
      faces[4][1] = faces[0][1];
      faces[4][3] = faces[0][3];
      faces[0][1] = faces[5][3];
      faces[0][3] = faces[5][1];
      faces[5][3] = faces[3][0];
      faces[5][1] = faces[3][2];
      faces[3][0] = tempCol[1];
      faces[3][2] = tempCol[0];
    });
  }

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Ensures 2x2 grid
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4, // 2x2 grid has 4 tiles
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rotate Top Button
            ElevatedButton(
              onPressed: rotateTop,
              child: const Text('Rotate Top'),
            ),
            const SizedBox(height: 20),
            // Cube faces and Rotate Left/Right Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rotate Left Button
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: rotateLeft,
                      child: const Text('Rotate Left'),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(height: 100, width: 100, child: buildFace(faces[1])),
                    const Text('Left Face'),
                  ],
                ),
                const SizedBox(width: 20),
                // Middle cube faces (Top, Front, Right, Bottom)
                Column(
                  children: [
                    SizedBox(height: 100, width: 100, child: buildFace(faces[4])),
                    const Text('Top Face'),
                    const SizedBox(height: 20),
                    SizedBox(height: 100, width: 100, child: buildFace(faces[0])),
                    const Text('Front Face'),
                    const SizedBox(height: 20),
                    SizedBox(height: 100, width: 100, child: buildFace(faces[5])),
                    const Text('Bottom Face'),
                  ],
                ),
                const SizedBox(width: 20),
                // Rotate Right Button
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: rotateRight,
                      child: const Text('Rotate Right'),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(height: 100, width: 100, child: buildFace(faces[2])),
                    const Text('Right Face'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Back Face
            Column(
              children: [
                SizedBox(height: 100, width: 100, child: buildFace(faces[3])),
                const Text('Back Face'),
              ],
            ),
            const SizedBox(height: 20),
            // Rotate Bottom Button
            ElevatedButton(
              onPressed: rotateBottom,
              child: const Text('Rotate Bottom'),
            ),
          ],
        ),
      ),
    );
  }
}

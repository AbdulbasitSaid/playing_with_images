import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<CarosalImage> images;
  late CarosalImage displayImage;
  @override
  void initState() {
    images = [
      CarosalImage(
          url:
              'https://images.unsplash.com/photo-1657299141984-dd9196274cde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          id: 'i001'),
      CarosalImage(
          url:
              'https://images.unsplash.com/photo-1659536540455-161b929e650c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
          id: 'i002'),
      CarosalImage(
          url:
              'https://images.unsplash.com/photo-1657299170111-371dabe2e60d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
          id: 'i003'),
    ];
    displayImage = images[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
              height: mHeight,
              width: mWidth,
              color: Colors.blue,
              child: Image(
                key: Key(displayImage.id),
                image: NetworkImage(
                  displayImage.url,
                ),
                fit: BoxFit.cover,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                // color: Colors.pink,
                width: MediaQuery.of(context).size.width * .8,
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            displayImage = images[index];
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: displayImage.id == images[index].id
                                  ? Border.all(
                                      width: 2,
                                      color: Colors.red,
                                    )
                                  : null),
                          child: Image.network(
                            images[index].url,
                            key: Key(images[index].id),
                          ),
                        ),
                      )),
                  separatorBuilder: ((context, index) => const SizedBox(
                        width: 16,
                      )),
                  itemCount: images.length,
                ),
              )),
        ]),
      ),
    );
  }
}

class CarosalImage {
  String id, url;
  CarosalImage({
    required this.url,
    required this.id,
  });
}

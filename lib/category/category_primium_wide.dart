import 'package:flutter/material.dart';

class CategoryWideBody extends StatelessWidget {
  const CategoryWideBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const CategoryWideBodySfw(),
    );
  }
}

class CategoryWideBodySfw extends StatefulWidget {
  const CategoryWideBodySfw({super.key});

  @override
  State createState() => _CategoryWideBodySfw();
}

class _CategoryWideBodySfw extends State<CategoryWideBodySfw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'GRIP 프리미엄 pro',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 300,
              child: buildList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 300,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(width: 2.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        color: Colors.grey,
                        child: Image.asset('assets/images/movie/$position.jpg', fit: BoxFit.fill,),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '000영상',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                width: double.infinity,
                                child: const Text(
                                  '상품 설명 제목입니다.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}

import 'package:dars_5_2/core/constants/graphql_mutations.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// ignore: must_be_immutable
class EditProductScreen extends StatefulWidget {
  dynamic product;
  EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryIdController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.product['title'];
    priceController.text = widget.product['price'].toString();
    descriptionController.text = widget.product['description'];
    categoryIdController.text = widget.product['categoryId'].toString();
    imageController.text = widget.product['images'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter title"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter price"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter description"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: categoryIdController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter categoryId"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter image url"),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  final client = GraphQLProvider.of(context).value;

                  client.mutate(MutationOptions(
                      document: gql(editProduct),
                      variables: {
                        'id': widget.product['id'],
                        'title': titleController.text,
                        'price': double.parse(priceController.text),
                        'description': descriptionController.text,
                        // 'categoryId': double.parse(categoryIdController.text),
                        // "images": [imageController.text],
                      },
                      onCompleted: (dynamic resultData) {
                        print(resultData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${widget.product['title']} mahsulot o'zgartitildi"),
                          ),
                        );
                        Navigator.pop(context);
                      }));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(
                  "Edit Product",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

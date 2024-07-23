import 'package:dars_5_2/core/constants/graphql_mutations.dart';
import 'package:dars_5_2/core/constants/graphql_queries.dart';
import 'package:dars_5_2/ui/screens/add_product_screen.dart';
import 'package:dars_5_2/ui/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // String formatUrl (String url){
  //   return url.s
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Main Screen"),
      ),
      body: Query(
        options: QueryOptions(document: gql(fetchProducts)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List products = result.data!['products'];
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product['images'][0]
                      .substring(2, product['images'][0].length - 2)),
                ),
                title: Text("${product['title']} ${index + 1}"),
                subtitle: Text(product['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // print(product['images']);
                        print(product['id']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProductScreen(
                                      product: product,
                                    )));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        print(product['id']);
                        final client = GraphQLProvider.of(context).value;

                        client.mutate(MutationOptions(
                            document: gql(deleteProduct),
                            variables: {
                              'id': product['id'],
                            },
                            onCompleted: (dynamic resutltData) {
                              print(resutltData);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Mahsulot ochirildi"),
                                ),
                              );
                              // Navigator.pop(context);
                            }));
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

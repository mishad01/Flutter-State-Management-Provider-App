import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_provider_supabase/model/category_model.dart';
import 'package:recipe_app_provider_supabase/provider/meal_category_provider.dart';

class TestCategoryScreen extends StatefulWidget {
  const TestCategoryScreen({Key? key}) : super(key: key);

  @override
  State<TestCategoryScreen> createState() => _TestCategoryScreenState();
}

class _TestCategoryScreenState extends State<TestCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MealCategoryProvider>(context, listen: false).getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Categories'),
      ),
      body: Consumer<MealCategoryProvider>(
        builder: (context, provider, _) {
          if (provider.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!provider.isSuccess) {
            return const Center(child: Text('Failed to load categories.'));
          }

          if (provider.categoryList.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }

          return ListView.builder(
            itemCount: provider.categoryList.length,
            itemBuilder: (context, index) {
              CategoryModel category = provider.categoryList[index];
              return ListTile(
                leading: Image.network(
                  category.strCategoryThumb ?? '',
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                ),
                title: Text(category.strCategory ?? 'No name'),
                subtitle: Text(
                  category.strCategoryDescription ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

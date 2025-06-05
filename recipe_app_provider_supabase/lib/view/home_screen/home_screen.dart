import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app_provider_supabase/utils/app_colors.dart';
import 'package:recipe_app_provider_supabase/view/home_screen/widgets/recipe_card.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlide = 0;

  final List<String> carouselImages = [
    'https://via.placeholder.com/300x150/FF6B6B/FFFFFF?text=Delicious+Recipes',
    'https://via.placeholder.com/300x150/4ECDC4/FFFFFF?text=Quick+Meals',
    'https://via.placeholder.com/300x150/45B7D1/FFFFFF?text=Healthy+Food',
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Breakfast', 'icon': Iconsax.coffee},
    {'name': 'Lunch', 'icon': Iconsax.cake},
    {'name': 'Dinner', 'icon': Iconsax.cup},
    {'name': 'Snacks', 'icon': Iconsax.emoji_happy},
    {'name': 'Dessert', 'icon': Iconsax.heart},
  ];

  final List<Map<String, dynamic>> quickRecipes = [
    {
      'title': 'Avocado Toast',
      'image': 'https://via.placeholder.com/150x100/95E1D3/FFFFFF?text=Avocado',
      'calories': '250',
      'time': '5 min'
    },
    {
      'title': 'Pasta Carbonara',
      'image': 'https://via.placeholder.com/150x100/F38BA8/FFFFFF?text=Pasta',
      'calories': '420',
      'time': '15 min'
    },
    {
      'title': 'Greek Salad',
      'image': 'https://via.placeholder.com/150x100/A8DADC/FFFFFF?text=Salad',
      'calories': '180',
      'time': '10 min'
    },
    {
      'title': 'Grilled Chicken',
      'image': 'https://via.placeholder.com/150x100/F1FAEE/000000?text=Chicken',
      'calories': '320',
      'time': '20 min'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: appBar(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: Icon(Iconsax.search_normal),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            slider(),
            SizedBox(height: 2.h),
            // Categories section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            // Categories option row wise rounded small
            categoryOptionCard(),
            SizedBox(height: 3.h),
            // Quick and Easy text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick & Easy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            // Cards with image, title, calories and total time
            recipeCard(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  SizedBox recipeCard() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickRecipes.length,
        itemBuilder: (context, index) {
          final recipe = quickRecipes[index];
          return RecipeCard(recipe: recipe);
        },
      ),
    );
  }

  Container bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            activeIcon: Icon(Iconsax.home5),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal),
            activeIcon: Icon(Iconsax.search_normal_1),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            activeIcon: Icon(Iconsax.heart_tick),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle),
            activeIcon: Icon(Iconsax.profile_tick),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // Home is selected by default
        onTap: (index) {
          // Handle navigation here
          // You can use Navigator.push or your preferred navigation method
          print('Tapped index: $index');
        },
      ),
    );
  }

  SingleChildScrollView categoryOptionCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Container(
            margin: EdgeInsets.only(right: 12),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category['icon'],
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  category['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.cloud_sunny),
              SizedBox(width: 10),
              Text("Good Morning"),
            ],
          ),
          Text(
            "Alena Sabyan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.shopping_cart),
        ),
      ],
    );
  }

  Column slider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 172,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                currentSlide = index;
              });
            },
          ),
          items: carouselImages.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),

        // Carousel indicators
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            carouselImages.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: currentSlide == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentSlide == index ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

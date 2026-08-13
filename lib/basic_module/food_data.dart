class Food {
  final int id;
  final String title;
  final String des;
  final String image;
  final double rate;

  Food(this.id, this.title, this.des, this.image, this.rate);
}

// Food ideas inspired by the Pinterest food search page.
final List<Food> foods = [
  Food(
    1,
    'Avocado Toast',
    'Creamy avocado, poached egg, and fresh herbs.',
    'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?w=800',
    4.8,
  ),
  Food(
    2,
    'Fresh Salad Bowl',
    'Colorful greens with vegetables and a light dressing.',
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
    4.7,
  ),
  Food(
    3,
    'Pasta Carbonara',
    'Classic pasta with creamy sauce and crispy bacon.',
    'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=800',
    4.9,
  ),
  Food(
    4,
    'Berry Pancakes',
    'Fluffy pancakes topped with berries and maple syrup.',
    'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=800',
    4.6,
  ),
  Food(
    5,
    'Sushi Platter',
    'Fresh sushi rolls served with soy sauce and wasabi.',
    'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=800',
    4.8,
  ),
  Food(
    6,
    'Cheese Burger',
    'Juicy beef patty with cheese, lettuce, and tomato.',
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
    4.7,
  ),
];

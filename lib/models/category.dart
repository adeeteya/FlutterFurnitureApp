class Category {
  String name;
  String iconPath;
  Category(this.name, this.iconPath);
}

List<Category> categoryList = [
  Category('Popular', 'assets/icons/popular_icon.svg'),
  Category('Chair', 'assets/icons/chair_icon.svg'),
  Category('Table', 'assets/icons/table_icon.svg'),
  Category('Armchair', 'assets/icons/armchair_icon.svg'),
  Category('Bed', 'assets/icons/bed_icon.svg'),
  Category('Lamp', 'assets/icons/lamp_icon.svg')
];

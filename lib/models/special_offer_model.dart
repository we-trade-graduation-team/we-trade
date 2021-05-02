class SpecialOffer {
  SpecialOffer({
    required this.id,
    required this.numOfBrands,
    required this.image,
    required this.category,
  });

  final int id, numOfBrands;
  final String image, category;
}

List<SpecialOffer> demoSpecialOffers = [
  SpecialOffer(
    id: 1,
    numOfBrands: 18,
    image:
        'https://images.unsplash.com/photo-1523371683773-affcb4a2e39e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80',
    category: 'Smartphone',
  ),
  SpecialOffer(
    id: 2,
    numOfBrands: 24,
    image:
        'https://images.unsplash.com/photo-1515343480029-43cdfe6b6aae?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1100&q=80',
    category: 'Laptop',
  ),
  SpecialOffer(
    id: 3,
    numOfBrands: 14,
    image:
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    category: 'Watch',
  ),
];

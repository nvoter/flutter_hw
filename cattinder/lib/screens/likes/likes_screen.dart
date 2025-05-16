import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../likes/likes_presenter.dart';
import '../likes/contracts/likes_view.dart';
import '../detail/detail_screen.dart';
import '../../models/liked_cat.dart';
import '../../models/cat.dart';
import '../../utils/dependencies_manager.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  LikesScreenState createState() => LikesScreenState();
}

class LikesScreenState extends State<LikesScreen> implements LikesView {
  late final LikesPresenter _presenter;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchString = '';

  @override
  void initState() {
    super.initState();
    _presenter = getIt<LikesPresenter>(param1: this);
    _presenter.initialize();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchString = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Likes',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Breed',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.cardColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder<List<LikedCat>>(
        valueListenable: _presenter.likesNotifier,
        builder: (context, cats, _) {
          final filteredCats =
              cats
                  .where(
                    (cat) => cat.cat.breed.name.toLowerCase().contains(
                      _searchString,
                    ),
                  )
                  .toList();
          if (filteredCats.isEmpty) {
            return Center(
              child: Text(
                "Cats not found :(",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: filteredCats.length,
            itemBuilder: (context, index) {
              final cat = filteredCats[index];
              return Dismissible(
                key: Key(cat.cat.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) => _presenter.removeLike(cat),
                child: GestureDetector(
                  onTap: () => _presenter.navigateToDetail(cat),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: CachedNetworkImage(
                              imageUrl: cat.cat.imageUrl,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (context, url, error) => Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.cover,
                                  ),
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cat.cat.breed.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            theme.textTheme.titleLarge?.color,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        'dd MMMM yyyy',
                                      ).format(cat.likeDate),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color:
                                            theme.textTheme.titleLarge?.color,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () => handleRemoving(cat),
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void handleRemoving(LikedCat cat) {
    _presenter.removeLike(cat);
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void navigateToDetail(Cat cat) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(cat: cat)),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

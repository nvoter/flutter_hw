import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/cat.dart';
import '../detail/detail_screen.dart';
import 'components/like_dislike_button.dart';
import 'home_presenter.dart';
import 'contracts/home_view.dart';
import '../../utils/dependencies_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin
    implements HomeView {
  late final HomePresenter _presenter;
  double _dragPosition = 0.0;
  bool _isSwipingLeft = false;
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;
  bool _isUpdating = false;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _presenter = getIt<HomePresenter>(param1: this);
    _presenter.initialize().then((_) {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    });
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_fadeAnimationController)..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cat Tinder',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.whatshot, color: theme.colorScheme.onPrimary),
                const SizedBox(width: 5),
                ValueListenableBuilder<int>(
                  valueListenable: _presenter.likesCountNotifier,
                  builder:
                      (context, likesCount, _) => Text(
                        '$likesCount',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            ValueListenableBuilder<Cat?>(
              valueListenable: _presenter,
              builder: (context, cat, _) {
                if (cat == null && !_isInitializing) {
                  return const CircularProgressIndicator(color: Colors.purple);
                }
                return GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_isUpdating) return;
                    setState(() {
                      _dragPosition += details.delta.dx;
                      _isSwipingLeft = _dragPosition < 0;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_isUpdating) return;
                    if (_dragPosition.abs() > 100) {
                      _handleSwipe(_dragPosition > 0);
                    } else {
                      setState(() => _dragPosition = 0.0);
                    }
                  },
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform(
                      transform:
                          Matrix4.identity()
                            ..translate(_dragPosition, 0)
                            ..rotateZ(_dragPosition / 300),
                      alignment:
                          _isSwipingLeft
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:
                                cat == null
                                    ? null
                                    : () => _presenter.navigateToDetail(cat),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 400,
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: cat?.imageUrl ?? '',
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget:
                                            (
                                              context,
                                              url,
                                              error,
                                            ) => Image.asset(
                                              'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.cardColor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              bottom: Radius.circular(20),
                                            ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          cat?.breed.name ?? "",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                theme
                                                    .textTheme
                                                    .titleLarge
                                                    ?.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LikeDislikeButton(
                                icon: Icons.close,
                                color: Colors.red,
                                backgroundColor: theme.cardColor,
                                onPressed: () => _handleSwipe(false),
                              ),
                              LikeDislikeButton(
                                icon: Icons.favorite,
                                color: Colors.purple,
                                backgroundColor: theme.cardColor,
                                onPressed: () => _handleSwipe(true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (_isUpdating || _isInitializing)
              Positioned.fill(
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.purple),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showNetworkError(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).cardColor,
            title: const Text(
              'Network error. Please, check network connection',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK', style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),
    );
  }

  Future<void> _handleSwipe(bool isLike) async {
    if (_isUpdating) return;
    _isUpdating = true;
    try {
      if (isLike) {
        _presenter.likeCat();
      } else {
        _presenter.dislikeCat();
      }
      await _fadeAnimationController.forward();
      setState(() => _dragPosition = 0.0);
      await _presenter.loadNextCat();
    } finally {
      _fadeAnimationController.reset();
      _isUpdating = false;
    }
  }

  @override
  void showCat(Cat cat) {
    setState(() {});
  }

  @override
  void showError(String message) {
    if (message.toLowerCase().contains('load')) {
      _showNetworkError(message);
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void updateLikesCount(int likesCount) {
    setState(() {});
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
    _fadeAnimationController.dispose();
    super.dispose();
  }
}

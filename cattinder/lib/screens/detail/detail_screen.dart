import 'package:flutter/material.dart';
import '../../models/cat.dart';
import 'detail_presenter.dart';
import './contracts/detail_view.dart';
import '../../utils/dependencies_manager.dart';

class DetailScreen extends StatefulWidget {
  final Cat cat;

  const DetailScreen({super.key, required this.cat});

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> implements DetailView {
  late final DetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = getIt<DetailPresenter>(param1: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cat.breed.name,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      widget.cat.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.cat.breed.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  Divider(color: theme.dividerColor, indent: 16, endIndent: 16),
                  _buildInfoSection(
                    'Temperament',
                    widget.cat.breed.temperament,
                    theme,
                  ),
                  Divider(color: theme.dividerColor, indent: 16, endIndent: 16),
                  _buildInfoSection('Origin', widget.cat.breed.origin, theme),
                  Divider(color: theme.dividerColor, indent: 16, endIndent: 16),
                  _buildInfoSection(
                    'Life Span',
                    widget.cat.breed.lifeSpan,
                    theme,
                  ),
                  Divider(color: theme.dividerColor, indent: 16, endIndent: 16),
                  _buildInfoSection(
                    'Dog Friendly',
                    '${widget.cat.breed.dogFriendly}/5',
                    theme,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (widget.cat.breed.wikipediaUrl.isNotEmpty)
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    _presenter.openWikipedia(widget.cat.breed.wikipediaUrl);
                  },
                  child: Text(
                    'Learn More on Wikipedia',
                    style: TextStyle(color: theme.colorScheme.onPrimary),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

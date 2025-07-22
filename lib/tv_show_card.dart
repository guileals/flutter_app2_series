import 'package:flutter/material.dart';
import 'package:flutter_app2_series/rating_widget.dart';
import 'package:flutter_app2_series/tv_show_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TvShowCard extends StatelessWidget {
  const TvShowCard({
    super.key,
    required this.tvShow,
    required this.index,
    // required this.removeTvShow,
  });

  final TvShow tvShow;
  final int index;
  // final Function(TvShow) removeTvShow;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primary,
          child: Text(
            (index + 1).toString(),
            style: GoogleFonts.lobster(
              color: colorScheme.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          tvShow.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          tvShow.stream,
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        trailing: ratingWidget(number: tvShow.rating),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tvShow.title),
                  IconButton.outlined(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, size: 32),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text('Streaming: ${tvShow.stream}'),
                  Text('Rating: ${tvShow.rating}'),
                  Text(tvShow.summary),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    context.read<TvShowModel>().removeTvShow(tvShow, context);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: Text(
                    'REMOVER',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final index = context.read<TvShowModel>().tvShows.indexOf(
                      tvShow,
                    );
                    Navigator.of(context).pop();
                    context.go('/edit/$index');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: Text(
                    'EDITAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

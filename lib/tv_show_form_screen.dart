import 'package:flutter/material.dart';
import 'package:flutter_app2_series/star_rating.dart';
import 'package:flutter_app2_series/tv_show_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TvShowFormScreen extends StatefulWidget {
  const TvShowFormScreen({super.key, this.tvShow});

  final TvShow? tvShow;

  @override
  State<TvShowFormScreen> createState() => _TvShowFormScreenState();
}

class _TvShowFormScreenState extends State<TvShowFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _streamController = TextEditingController();
  final _summaryController = TextEditingController();
  var _rating = 0;

  @override
  void initState() {
    super.initState();
    if (widget.tvShow != null) {
      _titleController.text = widget.tvShow!.title;
      _streamController.text = widget.tvShow!.stream;
      _summaryController.text = widget.tvShow!.summary;
      _rating = widget.tvShow!.rating;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _streamController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isEditing = widget.tvShow != null;

    void submit() {
      if (_formKey.currentState!.validate()) {
        final newTvShow = TvShow(
          title: _titleController.text,
          stream: _streamController.text,
          summary: _summaryController.text,
          rating: _rating,
        );

        isEditing
            ? context.read<TvShowModel>().editTvShow(
                widget.tvShow!,
                newTvShow,
                context,
              )
            : context.read<TvShowModel>().addTvShow(newTvShow, context);

        context.go('/');
      }
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            isEditing ? 'Editar Série' : 'Adicionar Série',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Título é obrigatório!';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _streamController,
                  decoration: InputDecoration(
                    labelText: 'Stream',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Stream é obrigatório!';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  controller: _summaryController,
                  decoration: InputDecoration(
                    labelText: 'Resumo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Resumo é obrigatório!';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nota: ', style: TextStyle(fontSize: 16)),
                      StarRating(
                        value: _rating,
                        onRatingChanged: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(
                    isEditing ? 'EDITAR' : 'ADICIONAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

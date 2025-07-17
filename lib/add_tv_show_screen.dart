import 'package:flutter/material.dart';
import 'package:flutter_app2_series/star_rating.dart';
import 'package:flutter_app2_series/tv_show_model.dart';
import 'package:provider/provider.dart';

class AddTvShowScreen extends StatefulWidget {
  const AddTvShowScreen({super.key, required this.switchScreen});

  // final Function(TvShow) addTvShow;
  final Function(int) switchScreen;

  @override
  State<AddTvShowScreen> createState() => _AddTvShowScreenState();
}

class _AddTvShowScreenState extends State<AddTvShowScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _streamController = TextEditingController();
  final _summaryController = TextEditingController();
  var _rating = 0;

  @override
  Widget build(BuildContext context) {

    void submit() {
      if(_formKey.currentState!.validate()) {
        final newTvShow = TvShow(
          title: _titleController.text,
          stream: _streamController.text,
          summary: _summaryController.text,
          rating: _rating
        );

        // TO DO: Adicione o newTvShow a List!
        // Provider.of<TvShowModel>(context, listen: false).addTvShow(newTvShow);
        context.read<TvShowModel>().addTvShow(newTvShow, context);
        widget.switchScreen(0);
      }
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Adicionar Série',
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
                    foregroundColor: Theme.of(context).colorScheme.onPrimary
                  ),
                  child: Text(
                    'ADICIONAR',
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

import 'package:flutter/material.dart';
import '../model/moviedetail.dart';

class MoviedetailDialog extends StatefulWidget {
  final Moviedetail? moviedetail;
  final Function(String name, String director) onClickedDone;

  const MoviedetailDialog({
    Key? key,
    this.moviedetail,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _MoviedetailDialogState createState() => _MoviedetailDialogState();
}

class _MoviedetailDialogState extends State<MoviedetailDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final directorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.moviedetail != null) {
      final moviedetail = widget.moviedetail!;

      nameController.text = moviedetail.name;
      directorController.text = moviedetail.director;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    directorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.moviedetail != null;
    final title = isEditing ? 'Edit Movie' : 'Add Movie';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              buildName(),
              SizedBox(
                height: 8,
              ),
              buildDirector(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Movie Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDirector() => TextFormField(
        controller: directorController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Director Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final director = directorController.text;

          widget.onClickedDone(name, director);

          Navigator.of(context).pop();
        }
      },
    );
  }
}

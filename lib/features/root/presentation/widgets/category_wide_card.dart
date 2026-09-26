import 'package:flutter/material.dart';

final class CategoryWideCard extends StatelessWidget {
  final String _title, _image;

  const new({
    super.key,
    required this._title,
    required this._image
  });

  @override
  Stack build(BuildContext context)
  => Stack(
    alignment: .center,
    children: <Widget>[
      Container(
        height: 80.0,
        foregroundDecoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Colors.black,
              Colors.transparent
            ],
            stops: <double>[
              0.0,
              1.0
            ],
            begin: .centerLeft,
            end: .center
          ),
          borderRadius: .circular(12.0),
      
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_image),
            fit: .cover
          ),
          borderRadius: .circular(12.0),
        ),
        alignment: .bottomCenter,
      ),
      Padding(
        padding: const .symmetric(horizontal: 12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
              _title.toUpperCase(),
                style: const TextStyle(
                  fontWeight: .w900,
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            ),
            IconButton(
              onPressed: (){},
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary
              ),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0)
            )
          ],
        ),
      ),
    ],
  );
}
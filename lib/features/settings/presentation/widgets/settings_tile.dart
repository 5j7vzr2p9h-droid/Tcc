import 'package:flutter/material.dart';

final class const SettingsTile({
  super.key,
  required final IconData _iconData,
  required final String _title,
  required final String _subtitle,
  required final VoidCallback _onTap
}) extends StatelessWidget {

  @override
  ListTile build(BuildContext context)
  => ListTile(
    onTap: _onTap,
    leading: Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(25),
        borderRadius: const .all(.circular(12.0))
      ),
      child: Icon(
        _iconData,
        color: Theme.of(context).colorScheme.primary
      ),
    ),
    title: Text(_title),
    subtitle: Text(_subtitle),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 16.0,
      color: Colors.grey
    ),
  );
}

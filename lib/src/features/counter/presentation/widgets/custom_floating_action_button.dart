import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    required this.heroTag,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String heroTag;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Hero(
        tag: heroTag,
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: Ink(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colorScheme.primary, colorScheme.primaryContainer],
              ),
              boxShadow: [BoxShadow(color: colorScheme.primary.withAlpha(89))],
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: SizedBox(
                height: 56,
                width: 56,
                child: Center(child: Icon(icon, color: colorScheme.onPrimary)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

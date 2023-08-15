import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.onTap, // Add a visibility flag
  }) : super(key: key);

  final VoidCallback onTap; // Store whether the button should be visible

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Ink(
        height: 50,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.green.shade700),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: const Center(
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

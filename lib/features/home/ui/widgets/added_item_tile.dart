import 'package:flutter/material.dart';

class AddedItemTile extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;
  final Color accentGreen;

  const AddedItemTile({super.key, required this.name, required this.onRemove, required this.accentGreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(color: accentGreen, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Icon(Icons.delete, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class StepSlideWidget extends StatelessWidget {
  final int currentStep;

  const StepSlideWidget({required this.currentStep, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 59,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFA3A3A3), width: 1.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                _buildLine(1),
                _buildNode(1),
                _buildLine(2),
                _buildNode(2),
                _buildLine(3),
                _buildNode(3),
                _buildLine(4),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNode(int step) {
    bool isActive = step == currentStep;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 31,
          height: 28,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF005E5E) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
            boxShadow: isActive
                ? [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 1),
        Text('$step', style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLine(int step) {
    bool isFull = step < currentStep;
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.only(bottom: 25),
        color: isFull ? const Color(0xFF008080) : Colors.black,
      ),
    );
  }
}

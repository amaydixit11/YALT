import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class EnergySelector extends StatelessWidget {
  final int selectedEnergy;
  final Function(int) onEnergySelected;

  const EnergySelector({
    super.key,
    required this.selectedEnergy,
    required this.onEnergySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Energy Level',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            final energyValue = index + 1;
            final isSelected = selectedEnergy == energyValue;
            
            return GestureDetector(
              onTap: () => onEnergySelected(energyValue),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getEnergyIcon(energyValue),
                      size: isSelected ? 28 : 24,
                      color: isSelected 
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey,
                    ),
                    Text(
                      energyValue.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected 
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate(target: isSelected ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1));
          }),
        ),
      ],
    );
  }

  IconData _getEnergyIcon(int energy) {
    switch (energy) {
      case 1:
        return Icons.battery_0_bar;
      case 2:
        return Icons.battery_2_bar;
      case 3:
        return Icons.battery_4_bar;
      case 4:
        return Icons.battery_6_bar;
      case 5:
        return Icons.battery_full;
      default:
        return Icons.battery_unknown;
    }
  }
}
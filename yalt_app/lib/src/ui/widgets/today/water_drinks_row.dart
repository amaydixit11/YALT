// lib/src/ui/widgets/today/water_drinks_row.dart
import 'package:flutter/material.dart';
import '../common/section_wrapper.dart';

class WaterDrinksRow extends StatefulWidget {
  const WaterDrinksRow({super.key});

  @override
  State<WaterDrinksRow> createState() => _WaterDrinksRowState();
}

class _WaterDrinksRowState extends State<WaterDrinksRow> {
  int waterIntake = 0; // ml
  int coldDrinkCount = 0;
  final int dailyWaterGoal = 2000; // ml

  void _addWater(int ml) {
    setState(() {
      waterIntake += ml;
    });
  }

  void _addColdDrink() {
    setState(() {
      coldDrinkCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: WaterSection(
            waterIntake: waterIntake,
            dailyGoal: dailyWaterGoal,
            onWaterAdded: _addWater,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ColdDrinksSection(
            drinkCount: coldDrinkCount,
            onDrinkAdded: _addColdDrink,
          ),
        ),
      ],
    );
  }
}

class WaterSection extends StatelessWidget {
  final int waterIntake;
  final int dailyGoal;
  final Function(int) onWaterAdded;

  const WaterSection({
    super.key,
    required this.waterIntake,
    required this.dailyGoal,
    required this.onWaterAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: WaterTracker(
        waterIntake: waterIntake,
        dailyGoal: dailyGoal,
        onWaterAdded: onWaterAdded,
      ),
    );
  }
}

class WaterTracker extends StatelessWidget {
  final int waterIntake;
  final int dailyGoal;
  final Function(int) onWaterAdded;

  const WaterTracker({
    super.key,
    required this.waterIntake,
    required this.dailyGoal,
    required this.onWaterAdded,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (waterIntake / dailyGoal).clamp(0.0, 1.0);
    final isGoalAchieved = progress >= 1.0;
    
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.water_drop_rounded,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Water',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    Text(
                      'Stay hydrated',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isGoalAchieved)
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green.shade600,
                  size: 14,
                ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Water amount display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                waterIntake.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isGoalAchieved ? Colors.green.shade700 : Colors.blue.shade700,
                ),
              ),
              Text(
                'ml',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                ' / ${dailyGoal}ml',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 6),
          
          // Progress bar with percentage
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isGoalAchieved 
                          ? [Colors.green.shade400, Colors.green.shade600]
                          : [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Progress percentage
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '${(progress * 100).round()}%',
              style: TextStyle(
                fontSize: 8,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Add water buttons
          Row(
            children: [
              Expanded(
                child: WaterButton(
                  label: '100ml',
                  icon: Icons.local_cafe_rounded,
                  onPressed: () => onWaterAdded(100),
                  isSmall: true,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: WaterButton(
                  label: '250ml',
                  icon: Icons.water_rounded,
                  onPressed: () => onWaterAdded(250),
                  isSmall: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WaterButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSmall;

  const WaterButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade700,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: Colors.blue.shade200, width: 0.5),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(icon, size: 10),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ColdDrinksSection extends StatelessWidget {
  final int drinkCount;
  final VoidCallback onDrinkAdded;

  const ColdDrinksSection({
    super.key,
    required this.drinkCount,
    required this.onDrinkAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade50, Colors.orange.shade50],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ColdDrinksTracker(
        drinkCount: drinkCount,
        onDrinkAdded: onDrinkAdded,
      ),
    );
  }
}

class ColdDrinksTracker extends StatelessWidget {
  final int drinkCount;
  final VoidCallback onDrinkAdded;
  
  const ColdDrinksTracker({
    super.key,
    required this.drinkCount,
    required this.onDrinkAdded,
  });

  final List<String> coldDrinks = const [
    'Coke', 'Pepsi', 'Thumbs Up', 'Sprite', 'Mountain Dew', 'Fanta',
    'Mirinda', 'Sting', 'Goli Soda', 'Limca', 'Others'
  ];

  Color get _healthColor {
    if (drinkCount == 0) return Colors.green;
    if (drinkCount <= 2) return Colors.orange;
    return Colors.red;
  }

  String get _healthText {
    if (drinkCount == 0) return 'Great!';
    if (drinkCount <= 2) return 'Moderate';
    return 'Too much';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade600,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.local_drink_rounded,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cold Drinks',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    Text(
                      'Track intake',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.orange.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: _healthColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _healthColor.withOpacity(0.2), width: 0.5),
                ),
                child: Text(
                  _healthText,
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    color: _healthColor,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Drink count display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                drinkCount.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _healthColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 2),
              Text(
                drinkCount == 1 ? 'drink' : 'drinks',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          
          Text(
            'today',
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey.shade500,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Quick add buttons row
          Row(
            children: [
              Expanded(
                child: _QuickAddButton(
                  label: 'Coke',
                  icon: Icons.local_drink,
                  onPressed: () => _addQuickDrink(context, 'Coke'),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _QuickAddButton(
                  label: 'More',
                  icon: Icons.add_circle_outline,
                  onPressed: () => _showColdDrinksDialog(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addQuickDrink(BuildContext context, String drink) {
    onDrinkAdded();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $drink'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.orange.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showColdDrinksDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ColdDrinksDialog(
        drinks: coldDrinks,
        onDrinkSelected: (drink) {
          onDrinkAdded();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added $drink'),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.orange.shade600,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        },
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuickAddButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange.shade700,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: Colors.orange.shade200, width: 0.5),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(icon, size: 10),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ColdDrinksDialog extends StatelessWidget {
  final List<String> drinks;
  final Function(String) onDrinkSelected;

  const ColdDrinksDialog({
    super.key,
    required this.drinks,
    required this.onDrinkSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade50, Colors.orange.shade100],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_drink_rounded, 
                  color: Colors.orange.shade700,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Select Drink',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 18, color: Colors.grey.shade600),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
          
          // Drinks grid
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.5,
                ),
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  final drink = drinks[index];
                  return Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onDrinkSelected(drink);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange.shade50, Colors.orange.shade100],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.orange.shade200,
                            width: 0.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            drink,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange.shade800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
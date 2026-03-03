import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleScreen(),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  static const double hourHeight = 80;
  static const double dayWidth = 100;
  static const double hourLabelWidth = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Horario",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Encabezado días
            SizedBox(
              width: hourLabelWidth + (7 * dayWidth),
              child: Row(
                children: [
                  const SizedBox(width: hourLabelWidth),
                  ...["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"]
                      .map(
                        (day) => SizedBox(
                          width: dayWidth,
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: hourLabelWidth + (7 * dayWidth),
                      height: hourHeight * 12,
                      child: Stack(
                        children: [
                          _buildGrid(),
                          _buildClasses(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Horas
        Column(
          children: List.generate(12, (index) {
            final hour = 7 + index;
            return SizedBox(
              height: hourHeight,
              width: hourLabelWidth,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "$hour:00",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          }),
        ),

        // Columnas de días
        ...List.generate(7, (day) {
          return Column(
            children: List.generate(12, (hour) {
              return Container(
                width: dayWidth,
                height: hourHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildClasses() {
    return Stack(
      children: [
        // Lunes
        _buildClassBlock(
          day: 1,
          startHour: 8,
          duration: 2,
          title: "Admin de Redes",
          color: Colors.blue.shade900,
        ),

        // Martes
        _buildClassBlock(
          day: 2,
          startHour: 12,
          duration: 2,
          title: "Taller de investigación",
          color: Colors.blue.shade400,
        ),
        _buildClassBlock(
          day: 2,
          startHour: 14,
          duration: 3,
          title: "Programación móvil",
          color: Colors.blue.shade800,
        ),

        // Miércoles
        _buildClassBlock(
          day: 3,
          startHour: 9,
          duration: 2,
          title: "Backend",
          color: Colors.blue.shade700,
        ),
        _buildClassBlock(
          day: 3,
          startHour: 13,
          duration: 3,
          title: "Gestión SW",
          color: Colors.blue.shade800,
        ),

        // Jueves
        _buildClassBlock(
          day: 4,
          startHour: 12,
          duration: 2,
          title: "Taller de investigación",
          color: Colors.blue.shade400,
        ),
        _buildClassBlock(
          day: 4,
          startHour: 14,
          duration: 2,
          title: "Programación móvil",
          color: Colors.blue.shade800,
        ),

        // Viernes
        _buildClassBlock(
          day: 5,
          startHour: 7,
          duration: 2,
          title: "Admin de Redes",
          color: Colors.blue.shade900,
        ),
        _buildClassBlock(
          day: 5,
          startHour: 10,
          duration: 3,
          title: "Backend",
          color: Colors.blue.shade700,
        ),
        _buildClassBlock(
          day: 5,
          startHour: 13,
          duration: 2,
          title: "Gestión SW",
          color: Colors.blue.shade800,
        ),
      ],
    );
  }

  Widget _buildClassBlock({
    required int day,
    required int startHour,
    required int duration,
    required String title,
    required Color color,
  }) {
    final top = (startHour - 7) * hourHeight;
    final left = hourLabelWidth + (day * dayWidth);

    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: dayWidth,
        height: duration * hourHeight,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
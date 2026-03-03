import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleScreen(),
    );
  }
}

class ClassInfo {
  final String title;
  final String teacher;
  final String group;
  final String classroom;
  final int day;
  final int startHour;
  final int duration;
  final Color color;

  const ClassInfo({
    required this.title,
    required this.teacher,
    required this.group,
    required this.classroom,
    required this.day,
    required this.startHour,
    required this.duration,
    required this.color,
  });
}

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});

  static const double hourHeight = 80;
  static const double dayWidth = 100;
  static const double hourLabelWidth = 60;

  // Datos de prueba para las clases
  final List<ClassInfo> classes = [
    // Lunes

  // ADMIN DE REDES
  ClassInfo(
    day: 1, // Lunes
    startHour: 8,
    duration: 2,
    title: "Admin de Redes",
    color: Colors.blue.shade900,
    teacher: "José Antonio Espinosa AT",
    group: "8SA",
    classroom: "H2",
  ),
  ClassInfo(
    day: 5, // Viernes
    startHour: 7,
    duration: 2,
    title: "Admin de Redes",
    color: Colors.blue.shade900,
    teacher: "José Antonio Espinosa AT",
    group: "8SA",
    classroom: "H12",
  ),

  // TALLER DE INVESTIGACIÓN
  ClassInfo(
    day: 2, // Martes
    startHour: 12,
    duration: 2,
    title: "Taller de Inv. I",
    color: Colors.blue.shade400,
    teacher: "Pedro Alfonso Guadalupe",
    group: "8SA",
    classroom: "H6",
  ),
  ClassInfo(
    day: 4, // Jueves
    startHour: 12,
    duration: 2,
    title: "Taller de Inv. I",
    color: Colors.blue.shade400,
    teacher: "Pedro Alfonso Guadalupe",
    group: "8SA",
    classroom: "H6",
  ),

  // BACKEND
  ClassInfo(
    day: 3, // Miércoles
    startHour: 9,
    duration: 2,
    title: "Des Back-End",
    color: Colors.blue.shade700,
    teacher: "Rodrigo Fidel Gaxiola So",
    group: "8SC",
    classroom: "H8",
  ),
  ClassInfo(
    day: 5, // Viernes
    startHour: 10,
    duration: 3,
    title: "Des Back-End",
    color: Colors.blue.shade700,
    teacher: "Rodrigo Fidel Gaxiola So",
    group: "8SC",
    classroom: "H10",
  ),

  // PROGRAMACIÓN MÓVIL
  ClassInfo(
    day: 2, // Martes
    startHour: 14,
    duration: 3,
    title: "Prog. Aplic. Mov.",
    color: Colors.blue.shade800,
    teacher: "Sara Nelly Moreno Cime",
    group: "8SC",
    classroom: "H2",
  ),
  ClassInfo(
    day: 4, // Jueves
    startHour: 14,
    duration: 2,
    title: "Prog. Aplic. Mov.",
    color: Colors.blue.shade800,
    teacher: "Sara Nelly Moreno Cime",
    group: "8SC",
    classroom: "H8",
  ),

  // GESTIÓN ÁGIL
  ClassInfo(
    day: 3, // Miércoles
    startHour: 13,
    duration: 3,
    title: "Gest. Ágil Proy. Sofw.",
    color: Colors.blue.shade800,
    teacher: "Mario Renán Moreno Sabid",
    group: "8SC",
    classroom: "H11",
  ),
  ClassInfo(
    day: 5, // Viernes
    startHour: 13,
    duration: 2,
    title: "Gest. Ágil Proy. Sofw.",
    color: Colors.blue.shade800,
    teacher: "Mario Renán Moreno Sabid",
    group: "8SC",
    classroom: "H11",
  ),
];

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
                          _buildClasses(context),
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

  Widget _buildClasses(BuildContext context) {
    return Stack(
      children:
          classes.map((classInfo) => _buildClassBlock(context, classInfo)).toList(),
    );
  }

  Widget _buildClassBlock(BuildContext context, ClassInfo classInfo) {
    final top = (classInfo.startHour - 7) * hourHeight;
    final left = hourLabelWidth + (classInfo.day * dayWidth);

    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () => _showClassDetails(context, classInfo),
        child: Container(
          width: dayWidth,
          height: classInfo.duration * hourHeight,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: classInfo.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              classInfo.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _showClassDetails(BuildContext context, ClassInfo classInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(classInfo.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Docente: ${classInfo.teacher}"),
              Text("Grupo: ${classInfo.group}"),
              Text("Salón: ${classInfo.classroom}"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
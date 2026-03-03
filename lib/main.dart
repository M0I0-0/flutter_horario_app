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
    ClassInfo(
      day: 1,
      startHour: 8,
      duration: 2,
      title: "Admin de Redes",
      color: Colors.blue.shade900,
      teacher: "Juan Pérez",
      group: "IS-8A",
      classroom: "Lab. Redes",
    ),

    // Martes
    ClassInfo(
      day: 2,
      startHour: 12,
      duration: 2,
      title: "Taller de investigación",
      color: Colors.blue.shade400,
      teacher: "María García",
      group: "IS-8A",
      classroom: "Salón 201",
    ),
    ClassInfo(
      day: 2,
      startHour: 14,
      duration: 3,
      title: "Programación móvil",
      color: Colors.blue.shade800,
      teacher: "Carlos Rodríguez",
      group: "IS-8A",
      classroom: "Lab. Cómputo",
    ),

    // Miércoles
    ClassInfo(
      day: 3,
      startHour: 9,
      duration: 2,
      title: "Backend",
      color: Colors.blue.shade700,
      teacher: "Ana Martínez",
      group: "IS-8A",
      classroom: "Lab. Cómputo",
    ),
    ClassInfo(
      day: 3,
      startHour: 13,
      duration: 3,
      title: "Gestión SW",
      color: Colors.blue.shade800,
      teacher: "Luis Hernández",
      group: "IS-8A",
      classroom: "Salón 303",
    ),

    // Jueves
    ClassInfo(
      day: 4,
      startHour: 12,
      duration: 2,
      title: "Taller de investigación",
      color: Colors.blue.shade400,
      teacher: "María García",
      group: "IS-8A",
      classroom: "Salón 201",
    ),
    ClassInfo(
      day: 4,
      startHour: 14,
      duration: 2,
      title: "Programación móvil",
      color: Colors.blue.shade800,
      teacher: "Carlos Rodríguez",
      group: "IS-8A",
      classroom: "Lab. Cómputo",
    ),

    // Viernes
    ClassInfo(
      day: 5,
      startHour: 7,
      duration: 2,
      title: "Admin de Redes",
      color: Colors.blue.shade900,
      teacher: "Juan Pérez",
      group: "IS-8A",
      classroom: "Lab. Redes",
    ),
    ClassInfo(
      day: 5,
      startHour: 10,
      duration: 3,
      title: "Backend",
      color: Colors.blue.shade700,
      teacher: "Ana Martínez",
      group: "IS-8A",
      classroom: "Lab. Cómputo",
    ),
    ClassInfo(
      day: 5,
      startHour: 13,
      duration: 2,
      title: "Gestión SW",
      color: Colors.blue.shade800,
      teacher: "Luis Hernández",
      group: "IS-8A",
      classroom: "Salón 303",
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
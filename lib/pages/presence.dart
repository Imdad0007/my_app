import 'package:flutter/material.dart';
import 'package:app/composants/dropdown_field.dart';
import 'package:app/pages/class_list.dart';
import 'package:app/composants/colors.dart';
import 'package:app/composants/button.dart';

class Presence extends StatefulWidget {
  const Presence({super.key});

  @override
  State<Presence> createState() => _PresenceState();
}

class _PresenceState extends State<Presence> {
  String? selectedNiveau;
  String? selectedFiliere;
  String? selectedCours;
  TimeOfDay? heureDebut;
  TimeOfDay? heureFin;

  bool get _isFormValid =>
      selectedNiveau != null &&
      selectedFiliere != null &&
      selectedCours != null &&
      heureDebut != null &&
      heureFin != null;

  // Formate l'heure manuellement pour éviter le "AM/PM"
  String _formatTime(TimeOfDay? time) {
    if (time == null) return "00:00";
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return "$hours:$minutes";
  }

  Future<void> _selectTime(BuildContext context, bool isDebut) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isDebut
          ? const TimeOfDay(hour: 7, minute: 0)
          : const TimeOfDay(hour: 12, minute: 0),
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      helpText: isDebut ? 'HEURE DE DÉBUT' : 'HEURE DE FIN',
    );

    if (picked != null) {
      setState(() {
        if (isDebut) {
          heureDebut = picked;
        } else {
          heureFin = picked;
        }
      });
    }
  }

  void _resetFields() {
    setState(() {
      selectedNiveau = null;
      selectedFiliere = null;
      selectedCours = null;
      heureDebut = null;
      heureFin = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final verticalSpacing = constraints.maxHeight * 0.03;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'PRÉSENCE',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 2),

                      DropdownField(
                        label: "NIVEAU",
                        value: selectedNiveau,
                        items: const ['Niveau 1', 'Niveau 2', 'Niveau 3'],
                        onChanged: (val) =>
                            setState(() => selectedNiveau = val),
                      ),
                      SizedBox(height: verticalSpacing),

                      DropdownField(
                        label: "FILIÈRE",
                        value: selectedFiliere,
                        items: const ['Informatique', 'Gestion', 'Marketing'],
                        onChanged: (val) =>
                            setState(() => selectedFiliere = val),
                      ),
                      SizedBox(height: verticalSpacing),

                      DropdownField(
                        label: "COURS",
                        value: selectedCours,
                        items: const [
                          'Flutter Dart',
                          'Base de données',
                          'Algorithmique',
                        ],
                        onChanged: (val) => setState(() => selectedCours = val),
                      ),

                      if (selectedCours != null) ...[
                        SizedBox(height: verticalSpacing),
                        _buildTimeSection(),
                      ],

                      SizedBox(height: verticalSpacing * 2),

                      Button(
                        label: "Continuer",
                        onPressed: _isFormValid
                            ? () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ClassList(),
                                  ),
                                );
                                _resetFields();

                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeSection() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey, width: 3)),
      ),
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _timePickerItem('Heure Début', heureDebut, true),
          const SizedBox(height: 15),
          _timePickerItem('Heure Fin', heureFin, false),
        ],
      ),
    );
  }

  Widget _timePickerItem(String label, TimeOfDay? time, bool isDebut) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectTime(context, isDebut),
          borderRadius: BorderRadius.circular(35),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.clearGrey,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time != null ? _formatTime(time) : "Entrer l'heure",
                  style: const TextStyle(fontSize: 16, color: AppColors.black),
                ),
                const Icon(Icons.access_time, color: AppColors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

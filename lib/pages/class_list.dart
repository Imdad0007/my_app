import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app/composants/colors.dart';
import 'package:app/composants/button.dart';

class ClassList extends StatefulWidget {
  const ClassList({super.key});

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  final List<Map<String, dynamic>> students = [
    {
      "nom": "DAH-NDOLOSSE",
      "prenom": "Bongo Jean François-Xavier",
      "isAbsent": false,
    },
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
    {"nom": "ALI", "prenom": "Bongo", "isAbsent": false},
  ];

  bool showConfirmDialog = false;

  void toggleDialog() {
    setState(() {
      showConfirmDialog = !showConfirmDialog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Stack(
          children: [
            // --- COUCHE 1 : Contenu Principal ---
            Column(
              children: [
                // const SizedBox(height: 8),
                _header(),
                _tableHead(),
                Expanded(
                  child: Container(
                    color: AppColors.white,
                    child: ListView.separated(
                      itemCount: students.length + 1,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        if (index < students.length) {
                          return _studentRow(index);
                        } else {
                          return _registerButton();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),

            // --- COUCHE 2 : Le Dialogue (Overlay) ---
            if (showConfirmDialog) _confirm(),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS DE LA LISTE ---

  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        border: Border(bottom: BorderSide(color: AppColors.grey, width: 1.5)),
      ),
      child: Row(
        children: const [
          Text(
            " Niveau ",
            style: TextStyle(color: AppColors.grey, fontSize: 16),
          ),
          Icon(Icons.chevron_right, size: 20, color: AppColors.white),
          Text(
            " Filière ",
            style: TextStyle(color: AppColors.grey, fontSize: 16),
          ),
          Icon(Icons.chevron_right, size: 20, color: AppColors.white),
          Text(
            " Cours ",
            style: TextStyle(color: AppColors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _tableHead() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(gradient: AppColors.primaryGradient),

      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              "NOM",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "PRÉNOMS",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "STATUT",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _studentRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              students[index]['nom'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              students[index]['prenom'],
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: students[index]['isAbsent'],
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() => students[index]['isAbsent'] = val);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ), // Empêche le bouton d'être trop large
          child: SizedBox(
            width: double.infinity,
            child: Button(label: "Enregistrer", onPressed: toggleDialog),
          ),
        ),
      ),
    );
  }

  // --- WIDGET DU DIALOGUE FLOTTANT  ---

  Widget _confirm() {
    return SizedBox.expand(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // L'effet de flou
        child: Container(
          color: AppColors.black.withAlpha(51), // Teinte sombre légère
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white.withAlpha(76), // Fond semi-transparent
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.white.withAlpha(51)),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: toggleDialog,
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: AppColors.black,
                        size: 35,
                      ),
                    ),
                  ),

                  if (!students.any((student) => student['isAbsent'] == true))
                    const Center(
                      child: Text(
                        "AUCUNE ABSENCE",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  else
                    const Center(
                      child: Text(
                        "LES ABSENTS :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                  Expanded(
                    child: ListView(
                      children: students
                          .where((s) => s['isAbsent'])
                          .map(
                            (s) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "- ${s['nom']}  ${s['prenom']}",
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _dialogButton("Confirmer", Icons.check, () {
                        // ACTION CONFIRMER
                      }),
                      _dialogButton("Annuler", Icons.cancel, () {
                        toggleDialog(); // ACTION ANNULER
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dialogButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 74, 138, 202),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

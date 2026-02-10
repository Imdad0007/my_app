import 'package:flutter/material.dart';
import 'package:app/composants/colors.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> historiques = [
    {
      "surveillant": "Basile Le Grand",
      "date": "10 Février 2026",
      "seance": "Flutter Dart",
      "heure": "(07:00 - 09:00)",
      "classe": "Niveau 3 - Informatique",
      "absents": ["ALI Bongo", "DAH-NDOLOSSE Jean"],
    },
    {
      "surveillant": "Basile Le Grand",
      "date": "08 Février 2026",
      "seance": "Base de données",
      "heure": "(10:00 - 12:00)",
      "classe": "Niveau 2 - Gestion",
      "absents": [],
    },
  ];

  String _searchTerm = "";

  @override
  Widget build(BuildContext context) {
    final filteredHistorique = historiques.where((h) {
      return h['surveillant'].toLowerCase().contains(
            _searchTerm.toLowerCase(),
          ) ||
          h['seance'].toLowerCase().contains(_searchTerm.toLowerCase()) ||
          h['classe'].toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Champ de recherche
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Rechercher...",
                  prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: AppColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Liste des historiques
              Expanded(
                child: filteredHistorique.isEmpty
                    ? const Center(
                        child: Text(
                          "Aucun historique trouvé",
                          style: TextStyle(color: AppColors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredHistorique.length,
                        itemBuilder: (context, index) {
                          final h = filteredHistorique[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Ligne supérieure : Nom surveillant + "Voir plus"
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        h['surveillant'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _showAbsents(context, h['absents']);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Text(
                                            "Voir plus >",
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // Date
                                  Text("📅 ${h['date']}"),
                                  const SizedBox(height: 8),

                                  // Nom de l'ECUE
                                  Text("📚 ${h['seance']}"),
                                  const SizedBox(height: 8),

                                  // Heure
                                  Text("⏰ ${h['heure']}"),
                                  const SizedBox(height: 8),

                                  // Classe (niveau - filière)
                                  Text("🎓 ${h['classe']}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAbsents(BuildContext context, List absents) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Liste des absents"),
        content: absents.isEmpty
            ? const Text("Aucun absent")
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: absents.map<Widget>((a) => Text("- $a")).toList(),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fermer"),
          ),
        ],
      ),
    );
  }
}

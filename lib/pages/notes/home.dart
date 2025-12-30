import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';
import 'package:notes/data/models/notes/project.dart';
import 'package:notes/data/models/notes/task.dart';
import 'package:notes/widgets/notes/project_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Project> items = [];

  @override
  void initState() {
    super.initState();
    items = generateProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Projects(${items.length})",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Container(
            width: 350,
            height: 250,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.card,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ProjectItem(project: items[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

List<Project> generateProjects() {
  return [
    Project(
      id: 1,
      title: "Application Mobile E-commerce",
      description:
          "Développement d'une application de vente en ligne avec panier et paiement intégré",
      tasks: [
        Task(
          id: 1,
          title: "Design de l'interface utilisateur",
          due_date: DateTime(2025, 1, 15),
        ),
        Task(
          id: 2,
          title: "Intégration de l'API de paiement",
          due_date: DateTime(2025, 1, 20),
        ),
        Task(
          id: 3,
          title: "Tests utilisateurs",
          due_date: DateTime(2025, 1, 25),
        ),
      ],
    ),
    Project(
      id: 2,
      title: "Site Web Portfolio",
      description:
          "Création d'un site portfolio personnel avec galerie de projets",
      tasks: [
        Task(
          id: 4,
          title: "Choix du design et des couleurs",
          due_date: DateTime(2025, 1, 10),
        ),
        Task(
          id: 5,
          title: "Développement des pages",
          due_date: DateTime(2025, 1, 18),
        ),
        Task(
          id: 6,
          title: "Déploiement en ligne",
          due_date: DateTime(2025, 1, 22),
        ),
      ],
    ),
    Project(
      id: 3,
      title: "Système de Gestion Scolaire",
      description:
          "Application pour gérer les notes, absences et emplois du temps des élèves",
      tasks: [
        Task(
          id: 7,
          title: "Analyse des besoins",
          due_date: DateTime(2025, 1, 12),
        ),
        Task(
          id: 8,
          title: "Création de la base de données",
          due_date: DateTime(2025, 1, 17),
        ),
        Task(
          id: 9,
          title: "Module de gestion des notes",
          due_date: DateTime(2025, 1, 24),
        ),
        Task(
          id: 10,
          title: "Module de gestion des absences",
          due_date: DateTime(2025, 1, 28),
        ),
      ],
    ),
    Project(
      id: 4,
      title: "Chatbot IA",
      description:
          "Bot conversationnel intelligent pour service client automatisé",
      tasks: [
        Task(
          id: 11,
          title: "Formation du modèle",
          due_date: DateTime(2025, 1, 14),
        ),
        Task(
          id: 12,
          title: "Intégration avec l'API",
          due_date: DateTime(2025, 1, 19),
        ),
      ],
    ),
    Project(
      id: 5,
      title: "Application de Fitness",
      description:
          "App de suivi d'entraînement et de nutrition avec objectifs personnalisés",
      tasks: [
        Task(
          id: 13,
          title: "Système de tracking des exercices",
          due_date: DateTime(2025, 1, 16),
        ),
        Task(
          id: 14,
          title: "Base de données nutritionnelle",
          due_date: DateTime(2025, 1, 21),
        ),
        Task(
          id: 15,
          title: "Graphiques de progression",
          due_date: DateTime(2025, 1, 26),
        ),
      ],
    ),
  ];
}

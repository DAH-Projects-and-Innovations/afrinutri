# 🌍 AfriNutri — Assistant Nutritionnel Intelligent pour l'Afrique

> Application mobile Flutter couplée à un backend FastAPI qui analyse des repas par photo,
> estime leur valeur nutritionnelle et fournit des recommandations personnalisées
> via un agent conversationnel (texte et vocal).

---

## 📌 Vue d'ensemble

AfriNutri permet à un utilisateur de **prendre une photo de son repas** et d'obtenir instantanément :
- L'identification du plat africain (thiéboudiene, mafé, kedjenou, alloco...)
- Les valeurs nutritionnelles estimées (calories, protéines, glucides, lipides)
- Des recommandations personnalisées via un assistant conversationnel IA

---

## 🏗️ Architecture du projet

```
afrinutri/                          ← Monorepo unique
│
├── apps/
│   ├── mobile/                     ← Application Flutter (Android / iOS)
│   │   └── lib/
│   │       ├── core/               ← Config, router, thème
│   │       ├── features/           ← auth, home, food_analysis, meals,
│   │       │                          tracking, assistant
│   │       └── shared/             ← Widgets, modèles, utils communs
│   │
│   └── api/                        ← Backend FastAPI (Python)
│       └── app/
│           ├── api/v1/             ← Routes : auth, users, meals,
│           │                          food_analysis, assistant
│           ├── core/               ← Config, sécurité, logging
│           ├── db/                 ← Modèles SQLAlchemy, repositories
│           ├── schemas/            ← Modèles Pydantic
│           ├── services/           ← Logique métier
│           └── integrations/       ← LLM, stockage S3, speech
│
├── ml/
│   ├── food_recognition/
│   │   ├── inference/              ← predictor.py — charge le .pt
│   │   ├── training/               ← scripts d'entraînement
│   │   ├── evaluation/             ← métriques, benchmarks
│   │   └── configs/                ← hyperparamètres
│   └── nutrition/                  ← estimation.py, valeurs nutritionnelles
│
├── data/
│   ├── raw/                        ← Images brutes (non versionnées)
│   ├── processed/                  ← Images nettoyées (non versionnées)
│   └── annotations/                ← Labels et métadonnées
│
├── models/                         ← README uniquement — .pt hors Git
├── scripts/                        ← download_model.py, seed_database.py
├── docs/                           ← Architecture, API, ML, database
├── .github/workflows/              ← CI/CD GitHub Actions
│
├── docker-compose.yml              ← api + postgres + minio
├── .env.example                    ← Template des variables d'environnement
└── README.md
```

---

## 🔗 Liens avec les autres repos du projet

AfriNutri est le **3ème volet** du projet. Il s'appuie sur les deux premiers :

| Repo | Rôle |
|---|---|
| `nutri-ia-data-collection` | Collecte, nettoyage, augmentation des images et génération des embeddings |
| `nutri-ia-model-training` | Entraînement et évaluation du modèle de classification |
| **`afrinutri`** (ce repo) | Application mobile + backend FastAPI + intégration du modèle `.pt` |

---

## 🛠️ Stack technologique

| Couche | Technologie | Rôle |
|---|---|---|
| Mobile | Flutter + Dart | Application Android / iOS |
| API | FastAPI (Python) | API REST, authentification, logique métier |
| Base de données | PostgreSQL | Utilisateurs, repas, analyses, suivi |
| ORM / migrations | SQLAlchemy 2 + Alembic | Modèles DB et migrations versionnées |
| Stockage images | S3 / MinIO | Photos de repas, URLs signées |
| Vision IA | PyTorch + modèle `.pt` | Reconnaissance des plats africains |
| LLM | OpenAI API / Mistral | Assistant conversationnel contextualisé |
| STT | Whisper | Voix → texte |
| TTS | Google Cloud TTS / Azure | Texte → voix |
| Cache / jobs | Redis + Celery | Tâches lourdes asynchrones |
| Authentification | JWT + OAuth2 | Sécurité des accès |
| Conteneurs | Docker + Docker Compose | Environnement dev et déploiement |
| CI/CD | GitHub Actions | Tests automatisés + déploiement |

---

## 🚀 Installation

### Prérequis

- Python 3.11+
- [uv](https://docs.astral.sh/uv/) — gestionnaire de paquets
- Flutter 3.x
- Docker + Docker Compose

### Backend Python

```bash
# Cloner le repo
git clone https://github.com/TON_ORG/afrinutri.git
cd afrinutri

# Installer les dépendances Python
uv sync

# Copier le template d'environnement
cp .env.example .env
# Remplir .env avec tes valeurs

# Télécharger le modèle .pt
python scripts/download_model.py
```

### Lancer avec Docker

```bash
docker-compose up --build
```

L'API sera disponible sur `http://localhost:8000`
La documentation Swagger sur `http://localhost:8000/docs`

---

## 🍽️ Flux applicatif

```
Utilisateur (Flutter)
      │  Photo du repas
      ▼
FastAPI (backend)
      │
      ├──► S3 / MinIO        ← stockage de la photo
      │
      ├──► PyTorch (.pt)     ← reconnaissance du plat
      │         ↓
      │    "Thiéboudiene — 94% de confiance"
      │
      ├──► PostgreSQL        ← valeurs nutritionnelles du plat
      │         ↓
      │    "450 kcal · 28g protéines · 55g glucides"
      │
      └──► LLM (OpenAI)      ← recommandations personnalisées
                ↓
         "Riche en protéines grâce au poisson.
          Évite de trop saler. Ajoute des légumes verts."
```

---

## ⚠️ Le modèle `.pt`

> **Le fichier `.pt` n'est jamais commité dans Git.**

Il est stocké sur S3 / Hugging Face Hub et téléchargé automatiquement au démarrage :

```bash
python scripts/download_model.py
```

Le code qui le charge se trouve dans `ml/food_recognition/inference/predictor.py`.

---

## 📦 Périmètre du MVP

Le MVP se concentre sur 5 blocs fonctionnels :

- ✅ **Authentification** — inscription, connexion, profil utilisateur
- ✅ **Analyse alimentaire** — photo → reconnaissance `.pt` → score de confiance
- ✅ **Repas** — enregistrement, historique, détail nutritionnel
- ✅ **Dashboard** — calories, protéines, glucides, lipides, évolution
- ✅ **Assistant** — chat texte avec contexte utilisateur et nutritionnel

---

## 🌿 Organisation des branches

```
main          ← code stable uniquement
develop       ← intégration continue
feature/auth
feature/food-analysis
feature/assistant
feature/recommendations
feature/tracking
feature/voice
```

---

## 🔒 Sécurité

- JWT + OAuth2, hashing des mots de passe (Argon2 / bcrypt)
- HTTPS, CORS strict, rate limiting
- Validation stricte des entrées (Pydantic)
- S3 privé avec URLs signées pour les images
- Aucune clé réelle dans le repo — `.env.example` documente les variables

---

## 🤝 Contribuer

Voir `CONTRIBUTING.md` pour les conventions de code, de commits et de pull requests.

---

*Projet AfriNutri — Data Afrique Hub (DAH) Innovation Department*
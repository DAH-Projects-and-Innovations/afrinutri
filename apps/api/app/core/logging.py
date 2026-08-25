import logging
import sys


def setup_logging() -> logging.Logger:
    "Configure le système de logs de l'application"

    # Créer le logger principal
    logger = logging.getLogger("afrinutri")
    logger.setLevel(logging.DEBUG)

    # Format des messages de log
    formatter = logging.Formatter(
        fmt="%(asctime)s - %(levelname)s - %(name)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S"
    )

    # Afficher les logs dans le terminal 
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)

    # Sauvegarder les logs dans un fichier 
    file_handler = logging.FileHandler("afrinutri.log")
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)

    # Ajouter les deux handlers au logger
    logger.addHandler(console_handler)
    logger.addHandler(file_handler)

    return logger


# Instance globale utilisée dans tout le projet
logger = setup_logging()
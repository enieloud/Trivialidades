# Trivialidades
Ejercicio para iOS

## Breve Documentación

### Carpeta Model:
- **Model.swift:** modela las estructuras correspondientes a la API *Open Trivia Database*
- **Readers.swift:** accede asíncronamente a la API *Open Trivia Database*
- **Game.swift:** Implementa las reglas del juego. Provee propiedades públicas y completion handlers para que la view pueda acceder a los datos

### Trivialidades:
- **AppDelegate.swift:** posee una única instancia al Game (mencionado arriba)
- **Main.Storyboard:** único storyboard usado en este proyecto
- **CategoryTableViewController.swift:** TableViewController que permite elegir el género de las preguntas (cine, ciencia, etc.)
- **DifficultyTableViewController.swift:** TableViewController que permite elegir la dificultad (Easy, Medium, Hard)
- **GameTypeTableViewController.swift:** TableViewController que permite elegir tipo (Multiple Choice or Yes/No)
- **GameViewController.swift:** ViewController que va mostrando las preguntas iterativamente, y se comunica con el model (Game.swift), acumulando el score y número de pregunta.
- **FinalScoreViewController.swift:** Controller que muestra el score final

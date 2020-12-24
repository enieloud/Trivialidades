# Trivialidades
Ejercicio en iOS. Implementa un trivia basado en (Open Trivia Database)[https://opentdb.com/]

## Breve Documentación

### Carpeta Model:
- **Model.swift:** modela las estructuras correspondientes a la API *Open Trivia Database*
- **Readers.swift:** accede asíncronamente a la API *Open Trivia Database*
- **Game.swift:** Implementa las reglas del juego. Acumulando el score y llevando la cuenta del número de pregunta por la que va juego. Provee propiedades públicas y completion handlers para que la view pueda acceder a los datos.

### Trivialidades:
- **AppDelegate.swift:** posee una única instancia al Game (mencionado arriba)
- **Main.Storyboard:** único storyboard usado en este proyecto
- **CategoryTableViewController.swift:** TableViewController que permite elegir el género de las preguntas (cine, ciencia, etc.)
- **DifficultyTableViewController.swift:** TableViewController que permite elegir la dificultad (Easy, Medium, Hard)
- **GameTypeTableViewController.swift:** TableViewController que permite elegir tipo (Multiple Choice or Yes/No)
- **GameViewController.swift:** ViewController que va mostrando las preguntas iterativamente, y lee del model (Game.swift) la pregunta actual, y el score acumulado.
- **FinalScoreViewController.swift:** Controller que muestra el score final

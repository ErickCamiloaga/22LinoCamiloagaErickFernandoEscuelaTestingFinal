🧪 Escuela Testing Final – Pruebas con Karate
📌 Descripción del Proyecto

Este proyecto contiene pruebas API utilizando Karate Framework sobre los módulos:

store

user

Se implementaron escenarios Happy Path y Unhappy Path, realizando validaciones sobre códigos de estado HTTP, estructura y contenido de las respuestas.

El proyecto cumple con los siguientes requerimientos:

No exposición de datos sensibles.

Configuración centralizada mediante karate-config.js.

Uso correcto de tags para segmentación de pruebas.

Estructura organizada bajo estándar Maven.

Archivo .gitignore configurado.

Repositorio estructurado correctamente.

🛠️ Tecnologías utilizadas

Java 17+

Maven

Karate Framework

JUnit 5

📂 Estructura del Proyecto
src
└── test
├── java
│     KarateRunner.java
└── resources
store.feature
user.feature
karate-config.js
pom.xml
⚙️ Configuración

El archivo karate-config.js centraliza la configuración base del entorno:

URL base de la API

Variables globales

Configuración reutilizable

Casos Automatizados
📦 Módulo Store

Crear orden (Happy Path)

Consultar orden existente

Consultar orden inexistente (Unhappy Path)

👤 Módulo User

Crear usuario (Happy Path)

Login usuario válido

Login usuario inválido (Validación de comportamiento real API)

Consultar usuario inexistente (Unhappy Path – 404)

🏷️ Tags Implementados

@store

@user

@happyPath

@unhappyPath

Permiten ejecutar pruebas específicas.

Ejemplo:

Ejecutar solo happy path:

mvn test -Dkarate.options="--tags @happyPath"

Ejecutar solo user:

mvn test -Dkarate.options="--tags @user"
▶️ Cómo ejecutar el proyecto

Desde la raíz del proyecto:

mvn clean test

O ejecutar directamente desde KarateRunner.

📌 Consideraciones

No se utilizan credenciales reales.

No se exponen datos sensibles.

Se valida comportamiento real de la API (análisis funcional previo).

👨‍💻 Autor

Erick Fernado Lino Camiloaga
Escuela Testing – Proyecto Final con Karate Framework
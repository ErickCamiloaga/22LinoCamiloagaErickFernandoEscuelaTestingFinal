# Swagger Petstore – Pruebas con Karate

## 📌 Descripción del Proyecto
Este proyecto contiene pruebas API automatizadas utilizando **Karate Framework** sobre los siguientes módulos:
- 📦 **Store**
- 👤 **User**

## Enfoque de Pruebas
Las pruebas fueron diseñadas considerando:

- Escenarios positivos (Happy Path)
- Escenarios negativos (Unhappy Path)
- Validación de códigos de estado HTTP
- Verificación de datos en la respuesta
- Separación mediante tags para facilitar ejecución selectiva

Se utilizó un **Background** para centralizar la configuración base y el objeto de usuario de prueba.

---
## ✅ Requerimientos Cumplidos
-  No exposición de datos sensibles  
-  Configuración centralizada mediante `karate-config.js`  
-  Uso correcto de tags para segmentación de pruebas  
-  Estructura organizada bajo estándar Maven  
-  Archivo `.gitignore` configurado  
-  Repositorio estructurado  

---
## 🛠 Tecnologías Utilizadas
- Java 17+
- Maven
- Karate Framework
- JUnit 5

---

## 📂 Estructura del Proyecto

    src/test/java/runner/KarateRunner.java
                         store.feature
                         user.feature
     
    karate-config.js
    pom.xml
    README.md
---

## ⚙️ Configuración
El archivo *karate-config.js* centraliza la configuración base del entorno:
- URL base de la API
- Variables globales
- Configuración reutilizable

---
## 📦 Módulo Store

El módulo Store automatiza pruebas sobre el endpoint `/store/order` de la API Swagger Petstore, validando el ciclo de vida completo de una orden y el comportamiento del sistema ante datos inválidos.
Se implementó generación dinámica de identificadores (`orderId`) para evitar conflictos entre ejecuciones y garantizar independencia de escenarios.
En el **Background** se define:
- URL base de la API
- Generación dinámica de `orderId`
- Generación dinámica de `invalidOrderId`
Esto permite que cada ejecución sea reproducible y sin dependencia de datos preexistentes.

### ✅ Escenarios Happy Path

Se validaron los siguientes casos funcionales:

- Creación de orden válida con ID dinámico
- Creación y posterior consulta de orden
- Creación y eliminación de orden
- Flujo completo (Crear → Consultar → Eliminar → Verificar eliminación)

En estos escenarios se valida:

- Código HTTP 200
- Integridad del ID generado dinámicamente
- Coincidencia del estado de la orden
- Eliminación efectiva (404)
- Tiempo de respuesta menor a 2000 ms

El escenario de flujo completo permite validar el comportamiento integral del recurso durante todo su ciclo de vida.

### ❌ Escenarios Unhappy Path

Se probaron distintos escenarios negativos para evaluar la robustez del sistema:

- Consulta de orden inexistente (404)
- Creación de orden con cantidad negativa
- Flujo negativo con datos inválidos (cantidad negativa y fecha incorrecta)

En el flujo negativo se identificó que la API devuelve **500 Internal Server Error** ante ciertos datos inválidos, lo que sugiere ausencia de validación adecuada en el backend.

Luego se verifica si la orden fue realmente creada, evaluando distintos posibles códigos de respuesta (400, 404 o 500), con el objetivo de analizar el comportamiento del sistema ante errores.

### 🔎 Observaciones Técnicas

Durante la ejecución se detectaron comportamientos relevantes:

- La API acepta cantidades negativas en algunos casos.
- Se generan errores 500 cuando deberían manejarse como 400 (Bad Request).
- La validación de formato de fecha no es consistente.
- El manejo de errores no siempre sigue estándares REST.
- Se permitió rango de códigos debido a comportamiento inconsistente del API demo. P. ej.: `Then match [400,404,500] contains responseStatus` 

Estos hallazgos evidencian la importancia de incluir pruebas negativas para identificar debilidades en la validación del sistema.

---

## 👤 Módulo User

### ✅ Happy Path

Se implementaron pruebas para:

- Crear usuario válido
- Obtener usuario existente
- Login con credenciales correctas
- Logout
- Eliminar usuario existente

Se validó:

- Respuesta HTTP 200
- Coincidencia de datos enviados y recibidos
- Flujo completo de gestión de usuario

### ❌ Unhappy Path

Se evaluaron distintos casos negativos:

- Obtener usuario inexistente (404)
- Login con contraseña incorrecta
- Login con usuario inexistente
- Eliminar usuario inexistente
- Crear usuario duplicado
- Crear usuario con campos faltantes
- Crear usuario con tipo de dato incorrecto
- Crear usuario con username excesivamente largo

### Observaciones

En algunos escenarios negativos se identificaron respuestas inconsistentes:

- Respuestas 200 ante datos incompletos
- Error 500 cuando se envían tipos incorrectos
- Validación limitada en ciertos campos

Esto demuestra la importancia de las pruebas negativas para detectar debilidades en el sistema.

---

## 🏷️ Tags Implementados
- @store
- @user
- @happyPath
- @unhappyPath

*Permiten ejecutar pruebas específicas*.

## ▶️ Cómo ejecutar el proyecto

Ejecutar todas las pruebas: `mvn clean test`

Ejecutar solo Happy Path: `mvn test -Dkarate.options="--tags @happyPath"`

Ejecutar solo Unhappy Path: `mvn test -Dkarate.options="--tags @unhappyPath"`

Ejecutar por módulo:

`mvn test -Dkarate.options="--tags @store"`
`mvn test -Dkarate.options="--tags @user"`

---
## 🎯 Conclusión
El proyecto demuestra la implementación de pruebas automatizadas aplicando buenas prácticas como independencia de escenarios, validación positiva y negativa, y análisis del comportamiento del sistema.
Además de verificar funcionalidad, se identificaron oportunidades de mejora relacionadas con validación de datos y manejo de errores, resaltando la importancia del testing automatizado como herramienta clave en el aseguramiento de calidad.

---
#### 👨‍💻 Autor
**Erick Fernando Lino Camiloaga**

*Escuela de Testing – Proyecto Final con Karate Framework*

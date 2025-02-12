# reservamos-challenge-data
Reservamos: API - Data challenge

## Instrucciones

Clonar el repositorio con el siguiente comando:
```
git clone https://github.com/yeguacelestial/reservamos-challenge-data.git
```

Entrar a la carpeta del proyecto (reservamos_challenge) e instalar las dependencias con el siguiente comando:
```
mix deps.get
```

Iniciar el servidor con el siguiente comando:
```
mix phx.server
```

La API estará disponible en `http://localhost:4000`.

Se puede probar el endpoint desde Swagger en `http://localhost:4000/api/swagger/`.







## Descripción del challenge

- Debo crear una REST API, en Elixir Phoenix, que permita al usuario conocer las opciones de hospedaje en las ciudades más populares.

- Se tiene acceso al endpoint de Reservamos API (https://search.reservamos.mx/api/v2/places), que es la que utilizaré para obtener las coordenadas de las ciudades.

El endpoint es un GET, que recibe un parámetro: `q`, el cual es el nombre parcial o completo de una ciudad (en USA o México).

La respuesta es un array con datos de diferentes lugares. Para este problema, solo nos interesan los lugares con `result_type: "city"`.

Ejemplo de respuesta:
```json
[
    {
        "id": 22,
        "slug": "ciudad-de-mexico",
        "city_slug": "ciudad-de-mexico",
        "display": "Ciudad de México",
        "ascii_display": "ciudad de mexico",
        "city_name": "Ciudad de México",
        "city_ascii_name": "ciudad de mexico",
        "state": "Distrito Federal",
        "country": "México",
        "lat": "19.4326077",
        "long": "-99.133208",
        "result_type": "city",
        "popularity": "1.0"
    }
]
```

- Tengo acceso a un dataset en formato CSV, que contiene información relevante de hospedaje por ciudad/estado/país. Algunos datos pueden no estar correctos, es parte del ejercicio manejar esos datos.

- El dataset tiene las siguientes columnas:
    - `title`: Título del alojamiento
    - `price_per_night`: Precio por noche
    - `currency`: Moneda del precio
    - `rating`: Calificación general
    - `amenities`: Servicios y comodidades disponibles
    - `city`: Ciudad del alojamiento
    - `state`: Estado/Provincia del alojamiento
    - `country`: País del alojamiento
    - `url`: URL de la página del alojamiento
    - `rating_cleanliness`: Puntuación de limpieza
    - `rating_accuracy`: Puntuación de veracidad de la información
    - `rating_check_in`: Puntuación del proceso de llegada
    - `rating_communication`: Puntuación de la comunicación con el anfitrión
    - `rating_location`: Puntuación de la ubicación
    - `rating_value`: Puntuación de la relación calidad-precio
    - `rating_overall`: Calificación general del alojamiento
    - `total_reviews`: Número total de reseñas


## Funcionalidades requeridas
- [x] Busqueda de ciudades
    - [x] Generar un endpoint que reciba un parametro de texto
    - [x] Obtener las ciudades que concuerden con el parámetro y devolverlas con información de hospedaje.
    - [x] Mostrar una lista de hospedajes disponibles para cada ciudad, debe mostrar:
        - Título
        - Precio por noche
        - Amenidades (si hay)
        - Ratings
- [x] Filtrado de hospedajes
  - [x] Establecer filtros, hay varios parametros que puedes usar para esto, precio es el más basico, agrega los que creas que tienen más valor.
  - [x] [Extra] Si el valor de un filtro de un registro es `nil`, considerarlo como `0`.
  - [x] Cuando se haga una búsqueda de ciudad, solo muestra los hospedajes que cumplen con el criterio.

## Expectativas

### Backend
- [x] Implementar un API REST utilizando Phoenix Framework o cualquier otro framework de mi preferencia que:
  - [x] Consuma los datos de la API de Reservamos para buscar ciudades.
  - [x] Relacione la información obtenida con el dataset de hospedajes
  - [x] Entregue información filtrada y organizada según los requerimientos.
- [x] Permitir el filtrado de hospedajes por parámetros como precio, amenidades y calificación mínima.
- [x] Optimizar el rendimiento del API mediante implementación de buenas prácticas (como manejo adecuado de errores, y validaciones en los endpoints).

### Manejo de datos
- Es importante ver cual es el proceso para manejar el data set.
  - [x] Queremos ver la estrategia que tomas para manejar esta información y cruzarla con la API.
    - Para la carga del CSV, utilicé la librería de `NimbleCSV` para cargar y parsear el dataset de hospedajes desde el CSV localmente.
    - Realicé solicitudes GET al endpoint de Reservamos, pasando el nombre de la ciudad como parámetro para obtener las coordenadas y otros detalles relevantes de las ciudades.
    - Implementé filtros adicionales para los hospedajes basados en parámetros como precio, calificación y amenidades. Estos filtros se aplican dinámicamente según los parámetros proporcionados. Es decir, si el usuario no proporciona un parámetro, no se aplica el filtro.
    - Aunque aún no lo he implementado completamente, planeo optimizar el rendimiento del API mediante la implementación de buenas prácticas, como el manejo adecuado de errores y validaciones en los endpoints.
  - [x] Por favor documenta brevemente tus decisiones de diseño y argumentalas.
    - En cuanto a la limpieza de los datos, observando el dataset noté que las amenidades vienen en formato de lista de strings. En cuanto lo noté, me di cuenta que no era una buena idea, pues no me permitiría hacer búsquedas eficientes por amenidades; en este punto decidi que lo mejor sería normalizar los datos antes de procesarlos para que sean más fáciles de manejar.

### IA (Opcional):
- Usar herramientas de IA para:
  - Resolver problemas técnicos durante el desarrollo.
  - Generar fragmentos de código o ejemplos de lógica.
  - Documentar el proceso de desarrollo.
  - [x] Documentar claramente en el README.md cómo y donde utilizaste IA, incluyendo tus mejores prompts y resultados obtenidos.
    - Antes de saltar a la programación, leí todo el PDF del challenge para entender el problema y los criterios de evaluación.
    - Una vez que entendí el problema, documenté lo necesario en este archivo, y dividí todo en pequeñas tareas para medir mi progreso y enfoque de una forma más clara (los requerimientos y criterios de evaluación los pasé a checkboxes).
    - Utilicé el LLM de gpt-4o para documentar la API desde Swagger.
    - Dado que he trabajado gran cantidad de proyectos con Python y Django, una de las cosas que me costó entender fue el paradigma de Elixir, el cual es funcional y no orientado a objetos, pero utilicé el siguiente prompt para entender a gran escala los modulos y contextos de Phoenix:
    ```
    P: "En los proyectos de Django, normalmente se crean apps para cada modulo del proyecto. ¿Aquí en Phoenix los proyectos serian equivalentes a las apps? ¿o estoy confundido?"

    A: "En Phoenix, los proyectos se organizan en "contexts" o "modules". Cada contexto es una unidad funcional que agrupa funciones relacionadas, generalmente alrededor de un dominio o funcionalidad específica. Los contextos ayudan a mantener el código organizado y a definir límites claros entre diferentes partes de la aplicación.
    ```
    - Utilicé un agente integrado en Cursor con gpt-4o para probar los endpoints de la API, tanto de Reservamos como la de mi API, y verificar que los datos eran los esperados.

## Notas personales
- En lugar de usar un CSV local, podría implementarse una base de datos para almacenar los datos de hospedajes y manejarlos desde ahí

# reservamos-challenge-data
Reservamos: API - Data challenge

## Instrucciones

Instrucciones para ejecutar el proyecto


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
- [ ] Filtrado de hospedajes
  - [ ] Establecer filtros, hay varios parametros que puedes usar para esto, precio es el más basico, agrega los que creas que tienen más valor.
  - [ ] Cuando se haga una búsqueda de ciudad, solo muestra los hospedajes que cumplen con el criterio.

## Expectativas

### Backend
- [ ] Implementar un API REST utilizando Phoenix Framework o cualquier otro framework de mi preferencia que:
  - [ ] Consuma los datos de la API de Reservamos para buscar ciudades.
  - [ ] Relacione la información obtenida con el dataset de hospedajes
  - [ ] Entregue información filtrada y organizada según los requerimientos.
- [ ] Permitir el filtrado de hospedajes por parámetros como precio, amenidades y calificación mínima.
- [ ] Optimizar el rendimiento del API mediante implementación de buenas prácticas (como manejo adecuado de errores, y validaciones en los endpoints).

### Manejo de datos
- Es importante ver cual es el proceso para manejar el data set.
  - [ ] Queremos ver la estrategia que tomas para manejar esta información y cruzarla con la API.
  - [ ] Por favor documenta brevemente tus decisiones de diseño y argumentalas.

### IA (Opcional):
- Usar herramientas de IA para:
  - Resolver problemas técnicos durante el desarrollo.
  - Generar fragmentos de código o ejemplos de lógica.
  - Documentar el proceso de desarrollo.
  - [ ] Documentar claramente en el README.md cómo y donde utilizaste IA, incluyendo tus mejores prompts y resultados obtenidos.
  
## Consideraciones para los LLMs
- Debe utilizarse el código más limpio, legible y consistente posible, que respete las reglas del lenguaje y de ingeniería de software.
- Algunos datos en el dataset pueden ser incorrectos, y debo manejar esos casos con Data Science o Machine Learning.
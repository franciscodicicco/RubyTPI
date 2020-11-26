# Consideraciones generales

El programa se realizó respetando las estructuras ya dadas.

A continuación se listan las principales decisiones tomadas:

-   Se agregó un archivo "validator.rb", el cual contiene el módulo "Validator" que contiene variables de clase y métodos luego utilizados en las clases "Books" y "Notes".
-   La creación del cajón de notas ".my_rns" y del global book "Cuaderno Global" se realizan al crear una nota o un cuaderno. Si se intenta realizar alguna operación antes de haber creado una nota o un cuaderno, se lanzará una alerta.
-   Se utilizó TTY-Editor para realizar la creación y la edición de notas.
-   Si al crear una nota se especifica un cuaderno no existente, la nota no se creará y se alertará que debe crear primero el cuaderno y luego la nota.
-   El borrado de un cuaderno eliminará todas las notas contenidas dentro del mismo.
-   Cuando un nombre de un cuaderno o un título de una nota posee caracteres inválidos, éstos son filtrados y se reemplazan para convertirse en "válidos". Se toma como caracter inválido la `"/"` (barra) y se reemplaza por un `"_"` (guión bajo).
-   Se utilizó el formato en texto plano "markdown" (.md) para el contenido de las notas.
-   Se seleccionó HTML como formato para la exportación.
-   Para la exportación de múltiples notas en una sola operación, se generarán muchos archivos (uno por nota exportada), respetando la estructura de directorios que plantean los cuadernos de notas.
-   Se utilizó la gema "github-markdown" para convertir desde markdown a HTML. (Fuente: https://rubygems.org/gems/github-markdown)

# Books --> Uso y comandos

Ejemplo de creación de un cuaderno --> Ejecutar el siguiente comando: ruby bin/rn books create "nuevo cuaderno"

## books 'create'

-   Descripción: Crear un cuaderno. Se debe especificar el nombre.
-   Argumentos obligatorios: "name"
-   Argumentos opcionales: -

## books 'delete'

-   Descripción: Eliminar un cuaderno. Se debe especificar el nombre. Opcionalmente, se puede pasar el parámetro "--global" para eliminar todas las notas dentro del cuaderno global.
-   Argumentos obligatorios: "name"
-   Argumentos opcionales: --global

## books 'list'

-   Descripción: Lista todos los cuadernos del directorio ".my_rns".
-   Argumentos obligatorios: -
-   Argumentos opcionales: -

## books 'rename'

-   Descripción: Renombrar un cuaderno. Se deben especificar el viejo_nombre y el nuevo_nombre.
-   Argumentos obligatorios: "old_name", "new_name"
-   Argumentos opcionales: -

# Notes --> Uso y comandos

Ejemplo de creación de una nota --> Ejecutar el siguiente comando: ruby bin/rn notes create "nueva nota" --book "nuevo cuaderno"

## notes 'create'

-   Descripción: Crear una nota. Se debe especificar el título. Opcionalmente, se le puede pasar el parámetro "--book" para crear una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se almacenará en el cuaderno global.
-   Argumentos obligatorios: "title"
-   Argumentos opcionales: --book "a_book"

## notes 'delete'

-   Descripción: Eliminar una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro "--book" para eliminar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se eliminará desde el cuaderno global.
-   Argumentos obligatorios: "title"
-   Argumentos opcionales: --book "a_book"

## notes 'edit'

-   Descripción: Editar una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro "--book" para buscar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se buscará dentro del cuaderno global.
-   Argumentos obligatorios: "title"
-   Argumentos opcionales: --book "a_book"

## notes 'retitle'

-   Descripción: Renombrar el título de una nota. Se deben especificar el viejo_titulo y el nuevo_titulo. Opcionalmente, se puede pasar el parámetro "--book" para buscar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se buscará dentro del cuaderno global.
-   Argumentos obligatorios: "old_title", "new_title"
-   Argumentos opcionales: --book "a_book"

## notes 'list'

-   Descripción: Listado de notas. Opcionalmente, se puede pasar el parámetro "--book" para listar las notas dentro de un cuaderno específico o el parámetro "--global" para listar todas las notas del cuaderno global. Si no se pasan argumentos, se listarán todas las notas.
-   Argumentos obligatorios: -
-   Argumentos opcionales: --book "a_book", --global

## notes 'show'

-   Descripción: Muestra el contenido de una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro "--book" para buscar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se buscará dentro del cuaderno global.
-   Argumentos obligatorios: "title"
-   Argumentos opcionales: --book "a_book"

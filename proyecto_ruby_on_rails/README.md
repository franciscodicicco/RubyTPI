# Proyecto Ruby on Rails

## Descripción:

Aplicación utilizada para la creación de notas, organizadas en cuadernos.

Consta de un primer paso para el registro y autenticación de un usuario, luego ese usuario puede crear cuadernos y dentro de los cuadernos puede crear notas. Además brinda la posibilidad de exportar una nota creada en formato markdown y visualizarla en formato HTML.

## Consideraciones generales:

- La aplicación se realizó de acuerdo a los lineamientos planteados.
- Se utilizó "SQLite" como base de datos.
- Se utilizó la gema "devise" para la creación y autenticación de usuarios --> https://github.com/heartcombo/devise.
- Se utilizó la gema "Redcarpet" para la exportación de formato markdown a HTML --> https://github.com/vmg/redcarpet.
- Se utilizó bootstrap para el diseño y los estilos --> https://getbootstrap.com/.
- Al crear un usuario, se crea automáticamente un cuaderno global para ese usuario.
- La eliminación de un cuaderno eliminará todas las notas contenidas dentro del mismo.
- No se permite la repetición del título de una nota dentro del alcance de un cuaderno, pero sí se permite entre distintos cuadernos. Lo mismo sucede con el nombre de los cuadernos dentro del alcance de un usuario.

## Stack tecnológico:

- Ruby MRI (versión 2.7.1)
- Ruby on rails (versión 6.1.1)
- Base de datos SQLite3.

## Pasos para el funcionamiento local:

### En primer lugar debemos posicionarnos dentro del directorio del proyecto y abrir una terminal. Luego, debemos ejecutar los siguientes comandos:

- bundle install (para instalar las dependencias)
- rails db:create (crea la base de datos para el entorno actual)
- rails db:migrate (corre las migraciones de la base de datos)
- rails db:seed (corre el archivo seed.rb que contiene usuarios, cuadernos y notas).
- rails server (o simplemente "rails s") (para correr la aplicación)
- Abrir un navegador e ingresar en http://localhost:3000/

## Autenticación:

Al ingresar en la app, se puede crear una nueva cuenta propia o ingresar con las cuentas ya creadas gracias al archivo seed.

Estas cuentas son 10 y poseen el siguiente formato:

- usuario: user#@email.com
- contraseña: userpw#

(donde "#" debe ser reemplazado con un numero del 0 al 9)

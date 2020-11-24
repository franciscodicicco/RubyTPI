require_relative "validator"
require_relative "../models/notes"
module RN
  module Commands
    module Notes
      NOTE = Note.new()
      class Create < Dry::CLI::Command
        desc 'Crear una nota. Se debe especificar el título. Opcionalmente, se le puede pasar el parámetro "--book" para crear una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se almacenará en el cuaderno global.'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          NOTE.create(title, **options)
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Eliminar una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro "--book" para eliminar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se eliminará desde el cuaderno global.'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          NOTE.delete(title, **options)
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Editar una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro "--book" para buscar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se buscará dentro del cuaderno global.'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          NOTE.edit(title, **options)
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Renombrar el título de una nota. Se deben especificar el viejo_titulo y el nuevo_titulo. Opcionalmente, se puede pasar el parámetro "--book" para buscar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se buscará dentro del cuaderno global.'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          NOTE.retitle(old_title, new_title, **options)
        end
      end

      class List < Dry::CLI::Command
        desc 'Listado de notas. Opcionalmente, se puede pasar el parámetro "--book" para listar las notas dentro de un cuaderno específico o el parámetro "--global" para listar todas las notas del cuaderno global. Si no se pasan argumentos, se listarán todas las notas.'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          NOTE.list(**options)
        end
      end

      class Show < Dry::CLI::Command
        desc 'Muestra el contenido de una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro "--book" para buscar una nota dentro de un cuaderno específico. Si no se especifica un book, la nota se buscará dentro del cuaderno global.'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          NOTE.show(title, **options)
        end

      end
    end
  end
end

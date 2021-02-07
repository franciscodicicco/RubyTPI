require_relative "../models/book"
module RN
  module Commands
    module Books
      BOOK = Book.new()
      class Create < Dry::CLI::Command
        desc 'Crear un cuaderno. Se debe especificar el nombre.'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]

        def call(name:, **)
            msg = BOOK.create(name)
            puts msg
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Eliminar un cuaderno. Se debe especificar el nombre. Opcionalmente, se puede pasar el parámetro "--global" para eliminar todas las notas dentro del cuaderno global.'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
            msg = BOOK.delete(name, **options)
            puts msg
        end
      end

      class List < Dry::CLI::Command
        desc 'Lista todos los cuadernos del directorio ".my_rns".'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          msg = BOOK.list()
          puts msg
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Renombrar un cuaderno. Se deben especificar el viejo_nombre y el nuevo_nombre.'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          msg = BOOK.rename(old_name, new_name)
          puts msg
        end
      end

      class Export < Dry::CLI::Command
        desc 'Exporta las notas de un cuaderno. Se debe especificar el nombre del cuaderno. Opcionalmente se puede pasar el parámetro "--global" para exportar todas las notas del cuaderno global. Si no se pasan el parámetros, se exportarán todas las notas de todos los cuadernos del cajón de notas'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operates on the global book'

        example [
          '"My book"                           # Exports all notes from the book "My book",',
          '--global                            # Exports all notes from the Global Book',
          '                                    # Exports all notes from all books'
        ]

        def call(name: nil, **options)
          msg = BOOK.export(name, **options)
          puts msg
        end

      end

    end
  end
end

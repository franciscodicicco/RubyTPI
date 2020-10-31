module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Crear un cuaderno. Se debe especificar el nombre.'

        argument :name, required: true, desc: 'Name of the book'

        # example [
        #   '"My book" # Creates a new book named "My book"',
        #   'Memoires  # Creates a new book named "Memoires"'
        #   ruby bin/rn books create "nuevo book"
        # ]

        def call(name:, **)
          default_directory = ".my_rns"

          # Filtro caracteres inválidos ("/") y los reemplazo con un guión bajo ("_")
          filtered_name = name.gsub("/", "_")

          # Seteo el path con el nombre del book que llegó por parámetro
          path = "#{Dir.home}/#{default_directory}/#{filtered_name}"

          # Chequeo que no exista la carpeta y la creo.
          if (!Dir.exists?(path))
            Dir.mkdir(path)
            puts "El cuaderno '#{name}' fue creado exitosamente"
          else
            warn "El cuaderno '#{name}' ya existe"
          end

          # warn "TODO: Implementar creación del cuaderno de notas con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        # example [
        #   '--global  # Deletes all notes from the global book',
        #   '"My book" # Deletes a book named "My book" and all of its notes',
        #   'Memoires  # Deletes a book named "Memoires" and all of its notes'
        # ]

        def call(name: nil, **options)
          global = options[:global]
          default_directory = ".my_rns"
          default_book = "Cuaderno Global"

          # Si me llega global como parámetro --> elimino todas las notas del Cuaderno Global
          if (global)
            ####### Elimino todas las notas del Cuaderno Global
            return puts "Todas las notas del '#{default_book}' fueron eliminadas"
          end

          # Sino, elimino el book que me llegó como parámetro y todas sus notas
          ####### Elimino todas las notas del book "name"
          ####### Elimino el book
          return puts "El cuaderno '#{name}' y todas sus notas fueron eliminadas"

          # warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          warn "TODO: Implementar listado de los cuadernos de notas.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end

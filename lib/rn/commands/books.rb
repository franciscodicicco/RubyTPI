require_relative "validator"
module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        include Validator
        desc 'Crear un cuaderno. Se debe especificar el nombre.'

        argument :name, required: true, desc: 'Name of the book'

        # example [
        #   '"My book" # Creates a new book named "My book"',
        #   'Memoires  # Creates a new book named "Memoires"'
        #   ruby bin/rn books create "nuevo book"
        # ]

        def call(name:, **)

          set_default_path()
          check_directory(@@path)

          filtered_name = turn_invalid_into_valid(name)

          # Completo el path con el book que llegó por parametro
          add_to_path("/#{filtered_name}")

          # Chequeo que no exista el cuaderno --> Si no existe, lo creo.
          if (!Dir.exists?(@@path))
            Dir.mkdir(@@path)
            puts "El cuaderno '#{name}' fue creado exitosamente"
          else
            warn "El cuaderno '#{name}' ya existe"
          end

        end
      end

      class Delete < Dry::CLI::Command
        include Validator
        desc 'Eliminar un cuaderno. Se debe especificar el nombre. Opcionalmente, se puede pasar el parámetro (--global)'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        # example [
        #   '--global  # Deletes all notes from the global book',
        #   '"My book" # Deletes a book named "My book" and all of its notes',
        #   'Memoires  # Deletes a book named "Memoires" and all of its notes'
        # ]

        def call(name: nil, **options)
          global = options[:global]

          # Si me llega como parámetro el cuaderno "global" --> alerto un error
          if (name == @@default_book)
            warn "No se puede eliminar el cuaderno '#{@@default_book}'. Si desea eliminar su contenido, agregue el comando --global"
            return
          end

          set_default_path()

          # Si me llega la opción "--global" como parámetro --> elimino todas las notas del Cuaderno Global
          if (global)
            # Completo el path con el Cuaderno Global
            add_to_path("/#{@@default_book}")
            # Chequeo que el book exista --> Si no existe, retorno mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{@@default_book}' no existe. Primero debe crear una nota o un cuaderno."
            end
            # Elimino todas las notas dentro del Cuaderno Global
            `rm -rf "#{@@path}"/*`
            return puts "Todas las notas del '#{@@default_book}' fueron eliminadas"
          end

          # Si no me llega --global, elimino el cuaderno que me llegó como parámetro y todas sus notas
          filtered_name = turn_invalid_into_valid(name)

          # Completo el path con el book que llegó por parametro
          add_to_path("/#{filtered_name}")

          # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
          if (!Dir.exists?(@@path))
            return warn "El cuaderno '#{filtered_name}' no existe"
          end

          # Elimino el cuaderno que me llegó como parámetro y todas sus notas
          `rm -rf "#{@@path}"`
          return puts "El cuaderno '#{name}' y todas sus notas fueron eliminadas"

        end
      end

      class List < Dry::CLI::Command
        desc 'Listado de cuadernos'

        # example [
        #   '          # Lists every available book'
        # ]

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

require_relative "validator"
module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        include Validator
        desc 'Crear una nota. Se debe especificar el título. Opcionalmente, se le puede pasar el parámetro (--book "nombre_cuaderno")'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        # example [
        #   todo                         # Creates a note titled "todo" in the global book',
        #   '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
        #   'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        #   ruby bin/rn notes create "nueva nota" --book "nuevo cuaderno"
        # ]

        def call(title:, **options)
          book = options[:book]

          set_default_path()
          check_directory(@@path)

          # Si me llega un book como parámetro
          if (book)

            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")

            # Chequeo que el book exista --> Si no existe, lo creo.
            if (!Dir.exists?(@@path))
              Dir.mkdir(@@path)
            end

          else
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")
          end

          filtered_title = turn_invalid_into_valid(title)

          # Completo el path con el nombre de la nota
            add_to_path("/#{filtered_title}#{@@extension}")

          # Chequeo que no exista otra nota con el mismo nombre dentro del mismo book --> Si no existe, la creo.
          if (!File.file?(@@path))
            TTY::Editor.open(@@path)
            return puts "La nota '#{filtered_title}' fue creada exitosamente"
          else
            warn "La nota '#{filtered_title}' ya existe"
          end
        end
      end

      class Delete < Dry::CLI::Command
        include Validator
        desc 'Eliminar una nota. Se debe especificar el título. Opcionalmente, se puede pasar el parámetro (--book "nombre_cuaderno")'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        # example [
        #   'todo                        # Deletes a note titled "todo" from the global book',
        #   '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
        #   'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        # ]

        def call(title:, **options)
          book = options[:book]

          set_default_path()

          # Si me llega un book como parámetro
          if (book)

            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")

            # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{filtered_book}' no existe"
            end
          else
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")
          end

          filtered_title = turn_invalid_into_valid(title)

          # Completo el path con el nombre de la nota
          add_to_path("/#{filtered_title}#{@@extension}")

          # Chequeo que exista la nota --> Si existe, la elimino.
          if (File.file?(@@path))
            File.delete(@@path)
            puts "La nota '#{filtered_title}' fue eliminada exitosamente"
          else
            warn "La nota '#{filtered_title}' no existe"
          end

        end
      end

      class Edit < Dry::CLI::Command
        include Validator
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        # example [
        #   'todo                        # Edits a note titled "todo" from the global book',
        #   '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
        #   'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        # ]

        def call(title:, **options)
          book = options[:book]

          set_default_path()

          # Si me llega un book como parámetro
          if (book)

            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")

            # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{filtered_book}' no existe"
            end
          else
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")
          end

          filtered_title = turn_invalid_into_valid(title)

          # Completo el path con el nombre de la nota
          add_to_path("/#{filtered_title}#{@@extension}")

          # Chequeo que exista la nota --> Si existe, la abro para editar.
          if (File.file?(@@path))
            TTY::Editor.open(@@path)
            puts File.read(@@path)
            return puts "La nota '#{filtered_title}' fue editada con éxito"
          else
            warn "La nota '#{filtered_title}' no existe"
          end

        end
      end

      class Retitle < Dry::CLI::Command
        include Validator
        desc 'Retitular una nota. Se deben especificar el viejo_titulo y el nuevo_titulo. Opcionalmente, se puede pasar el parámetro (--book "nombre_cuaderno")'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        # example [
        #   'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
        #   '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
        #   'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        # ]

        def call(old_title:, new_title:, **options)
          book = options[:book]

          set_default_path()

          # Si me llega un book como parámetro
          if (book)

            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")

            # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{filtered_book}' no existe"
            end
          else
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")
          end

          filtered_old_title = turn_invalid_into_valid(old_title)
          filtered_new_title = turn_invalid_into_valid(new_title)

          # Completo el path con el nombre de la nota
          path_old_title = @@path + "/#{filtered_old_title}#{@@extension}"
          path_new_title = @@path + "/#{filtered_new_title}#{@@extension}"

          # Chequeo que exista la nota
          if (File.file?(path_old_title))
            # Si existe, chequeo que no haya otra nota con el mismo nombre --> Si no hay, la retitulo
            if (!File.file?(path_new_title))
              File.rename(path_old_title, path_new_title)
              return puts "La nota '#{filtered_old_title}' fue retitulada por '#{filtered_new_title}' exitosamente"
            else
              return warn "La nota '#{filtered_old_title}' no puede ser retitulada porque la nota '#{filtered_new_title}' ya existe"
            end
          else
            warn "La nota '#{filtered_old_title}' no existe"
          end

        end
      end

      class List < Dry::CLI::Command
        include Validator
        desc 'Listado de notas. Opcionalmente, se pueden pasar los parámetros (--global y --book "nombre_cuaderno")'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        # example [
        #   '                 # Lists notes from all books (including the global book)',
        #   '--global         # Lists notes from the global book',
        #   '--book "My book" # Lists notes from the book named "My book"',
        #   '--book Memoires  # Lists notes from the book named "Memoires"'
        # ]

        def call(**options)
          book = options[:book]
          global = options[:global]

          set_default_path()

          # Si me llega un book como parámetro
          if (book)

            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")

            # Chequeo que el book exista --> Si no existe, retorno mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{filtered_book}' no existe"
            # Si existe, listo las notas del book especificado
            else
              # Chequeo que haya notas --> Si no hay, retorno un mensaje avisando que no hay notas
              if ((Dir.entries(@@path) - %w[. ..]).empty?)
                return warn "No hay notas en el cuaderno '#{filtered_book}'"
              else
                return puts (Dir.entries(@@path) - %w[. ..])
              end
            end
          end

          # Si me llega global como parámetro
          if (global)
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")
            # Chequeo que el book exista --> Si no existe, retorno mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{default_book}' no existe. Primero debe crear una nota o un cuaderno."
            end
            # Chequeo que haya notas --> Si no hay, retorno un mensaje avisando que no hay notas
            if ((Dir.entries(@@path) - %w[. ..]).empty?)
              return warn "No hay notas en el cuaderno '#{default_book}'"
            else
              # Listo las notas del Cuaderno Global
              return puts (Dir.entries(@@path) - %w[. ..])
            end
          end

          # Chequeo que el path exista --> Si no existe, retorno mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "No se pueden listar las notas. Primero debe crear una nota o un cuaderno."
            end

          # Si no me llegaron parámetros opcionales, listo todas las notas (incluidas las del Cuaderno Global)
          books_count = (Dir.entries(@@path) - %w[. ..]).count
          books_names = (Dir.entries(@@path) - %w[. ..])

          books_count.times { |i|
            (new_path = @@path + "/#{books_names[i]}")
            puts "Notas del cuaderno '#{books_names[i]}':"
            if ((Dir.entries(new_path) - %w[. ..]).empty?)
              puts "No hay notas en el cuaderno"
            else
              puts (Dir.entries(new_path) - %w[. ..])
            end
          }

        end
      end

      class Show < Dry::CLI::Command
        include Validator
        desc 'Muestra el contenido de una nota. Opcionalmente, se puede pasar el parámetro (--book "nombre_cuaderno")'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        # example [
        #   'todo                        # Shows a note titled "todo" from the global book',
        #   '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
        #   'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        # ]

        def call(title:, **options)
          book = options[:book]

          set_default_path()

          # Si me llega un book como parámetro
          if (book)

            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")

            # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
            if (!Dir.exists?(@@path))
              return warn "El cuaderno '#{filtered_book}' no existe"
            end
          else
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")
          end

          filtered_title = turn_invalid_into_valid(title)

          # Completo el path con el nombre de la nota
          add_to_path("/#{filtered_title}#{@@extension}")

          # Chequeo que exista la nota --> Si existe, la muestro.
          if (File.file?(@@path))
            puts "Contenido de la nota '#{filtered_title}':"
            puts File.read(@@path)
          else
            warn "La nota '#{filtered_title}' no existe"
          end

        end
      end
    end
  end
end

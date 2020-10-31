module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Crear una nota. Se debe especificar el título. Opcionalmente, se pueden pasar dos parámetros (--book "un_cuaderno" y --content "un_contenido")'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'
        option :content, type: :string, desc: 'Content of the note'

        # example [
        #   todo                         # Creates a note titled "todo" in the global book',
        #   '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
        #   'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        #   ruby bin/rn notes create "nueva nota" --book "nuevo cuaderno" --content "programando en ruby!"
        # ]

        def call(title:, **options)
          book = options[:book]
          content = options[:content]
          default_directory = ".my_rns"
          default_book = "Cuaderno Global"
          extension = ".rn"

          # Seteo el path default del directorio ".my_rns"
            path = "#{Dir.home}/#{default_directory}"

          # Si me llega un book como parámetro
          if (book)

            # Filtro caracteres inválidos del nombre del book ("/") y los reemplazo con un guión bajo ("_")
            filtered_book = book.gsub("/", "_")

            # Completo el path con el book que llegó por parametro
            path += "/#{filtered_book}"

            # Chequeo que el book exista --> Si no existe, lo creo.
            if (!Dir.exists?(path))
              Dir.mkdir(path)
            end

          else
            # Completo el path con el book default "Cuaderno Global"
            path += "/#{default_book}"
          end

          # Filtro caracteres inválidos del nombre de la nota ("/") y los reemplazo con un guión bajo ("_")
          filtered_title = title.gsub("/", "_")

          # Completo el path con el path de la nota
            path += "/#{filtered_title}#{extension}"

          # Chequeo que no exista otra nota con el mismo nombre dentro del mismo book --> Si no existe, la creo.
          if (!File.file?(path))
            new_file = File.new(path, "w")
            new_file.puts(content)
            new_file.close
            puts "La nota fue creada exitosamente"
          else
            warn "La nota ya existe"
          end

          # warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          book = options[:book]
          warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end

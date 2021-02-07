require_relative "validator"
require_relative "export_helper"
class Note
    include Validator
    include Export_helper
    def create(title, **options)
        book = options[:book]

        set_default_path()
        check_directory(@@path)

        # Si me llega un book como parámetro
        if (book)

        filtered_book = turn_invalid_into_valid(book)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_book}")

        # Chequeo que el book exista
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{filtered_book}' no existe. Debe crearlo primero para luego agregarle una nota."
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
        return "La nota '#{filtered_title}' fue creada exitosamente"
        else
        return "La nota '#{filtered_title}' ya existe"
        end
    end

    def delete(title, **options)
        book = options[:book]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega un book como parámetro
        if (book)

        filtered_book = turn_invalid_into_valid(book)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_book}")

        # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{filtered_book}' no existe"
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
        return "La nota '#{filtered_title}' fue eliminada exitosamente"
        else
        return "La nota '#{filtered_title}' no existe"
        end
    end

    def edit(title, **options)
        book = options[:book]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega un book como parámetro
        if (book)

        filtered_book = turn_invalid_into_valid(book)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_book}")

        # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{filtered_book}' no existe"
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
        return "La nota '#{filtered_title}' fue editada con éxito"
        else
        return "La nota '#{filtered_title}' no existe"
        end
    end

    def retitle(old_title, new_title, **options)
        book = options[:book]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega un book como parámetro
        if (book)

        filtered_book = turn_invalid_into_valid(book)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_book}")

        # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{filtered_book}' no existe"
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
            return "La nota '#{filtered_old_title}' fue retitulada por '#{filtered_new_title}' exitosamente"
        else
            return "La nota '#{filtered_old_title}' no puede ser retitulada porque la nota '#{filtered_new_title}' ya existe"
        end
        else
        return "La nota '#{filtered_old_title}' no existe"
        end
    end

    def list(**options)
        book = options[:book]
        global = options[:global]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas para listar. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega un book como parámetro
        if (book)

        filtered_book = turn_invalid_into_valid(book)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_book}")

        # Chequeo que el book exista --> Si no existe, retorno mensaje de error.
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{filtered_book}' no existe"
        # Si existe, listo las notas del book especificado
        else
            # Chequeo que haya notas --> Si no hay, retorno un mensaje avisando que no hay notas
            if ((Dir.entries(@@path) - %w[. ..]).empty?)
            return "No hay notas en el cuaderno '#{filtered_book}'"
            else
            return (Dir.entries(@@path) - %w[. ..])
            end
        end
        end

        # Si me llega global como parámetro
        if (global)
        # Completo el path con el book default "Cuaderno Global"
        add_to_path("/#{@@default_book}")
        # Chequeo que el book exista --> Si no existe, retorno mensaje de error.
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{@@default_book}' no existe. Primero debe crear una nota o un cuaderno."
        end
        # Chequeo que haya notas --> Si no hay, retorno un mensaje avisando que no hay notas
        if ((Dir.entries(@@path) - %w[. ..]).empty?)
            return "No hay notas en el cuaderno '#{@@default_book}'"
        else
            # Listo las notas del Cuaderno Global
            return (Dir.entries(@@path) - %w[. ..])
        end
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

    def show(title, **options)
        book = options[:book]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega un book como parámetro
        if (book)

        filtered_book = turn_invalid_into_valid(book)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_book}")

        # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
        if (!Dir.exists?(@@path))
            return "El cuaderno '#{filtered_book}' no existe"
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
        return "Contenido de la nota '#{filtered_title}':\n" + File.read(@@path)
        else
        return "La nota '#{filtered_title}' no existe"
        end
    end

    def export(title, **options)
        book = options[:book]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
            return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        if (book)
            filtered_title = turn_invalid_into_valid(title)
            filtered_book = turn_invalid_into_valid(book)

            # Completo el path con el book que llegó por parametro
            add_to_path("/#{filtered_book}")
            # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
            if (!Dir.exists?(@@path))
                return "El cuaderno '#{filtered_book}' no existe"
            end

            # Completo el path con el nombre de la nota
            add_to_path("/#{filtered_title}")

            # Guardo dos paths con el nombre de la nota sin la extensión y le agrego las extensiones correspondientes
            new_path = @@path
            html_path = @@path
            new_path += ".md"
            html_path += ".html"

            # Completo el path con la extensión default
            add_to_path("#{@@extension}")

            # Chequeo que exista la nota --> Si existe, la exporto.
            if (File.file?(@@path))
                export_note(@@path, new_path, html_path)
                return "La nota '#{filtered_title}' del cuaderno '#{filtered_book}' se ha exportado exitosamente"
            else
                return "La nota '#{filtered_title}' no existe"
            end
        else
            filtered_title = turn_invalid_into_valid(title)
            # Completo el path con el book default "Cuaderno Global"
            add_to_path("/#{@@default_book}")

            # Completo el path con el nombre de la nota
            add_to_path("/#{filtered_title}")

            # Guardo dos paths con el nombre de la nota sin la extensión y le agrego las extensiones correspondientes
            new_path = @@path
            html_path = @@path
            new_path += ".md"
            html_path += ".html"

            # Completo el path con la extensión default
            add_to_path("#{@@extension}")

            # Chequeo que exista la nota --> Si existe, la exporto.
            if (File.file?(@@path))
                export_note(@@path, new_path, html_path)
                return "La nota '#{filtered_title}' del cuaderno '#{@@default_book}' se ha exportado exitosamente"
            else
                return "La nota '#{filtered_title}' no existe"
            end
        end

    end

end
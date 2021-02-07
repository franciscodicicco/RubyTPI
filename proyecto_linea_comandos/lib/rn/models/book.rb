require_relative "validator"
class Book
    include Validator
    def create(name)
        set_default_path()
        check_directory(@@path)

        filtered_name = turn_invalid_into_valid(name)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_name}")

        # Chequeo que no exista el cuaderno --> Si no existe, lo creo.
        if (!Dir.exists?(@@path))
          Dir.mkdir(@@path)
          return "El cuaderno '#{name}' fue creado exitosamente"
        else
          return "El cuaderno '#{name}' ya existe"
        end
    end

    def delete(name, **options)
        global = options[:global]
        # Si me llega como parámetro el cuaderno "global" --> alerto un error
        if (name == @@default_book)
        return "No se puede eliminar el cuaderno '#{@@default_book}'. Si desea eliminar su contenido, agregue el comando --global"
        end

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega la opción "--global" como parámetro --> elimino todas las notas del Cuaderno Global
        if (global)
        # Completo el path con el Cuaderno Global
        add_to_path("/#{@@default_book}")
        # Elimino todas las notas dentro del Cuaderno Global
        `rm -rf "#{@@path}"/*`
        return "Todas las notas del '#{@@default_book}' fueron eliminadas"
        end

        # Si no me llega --global, elimino el cuaderno que me llegó como parámetro y todas sus notas
        filtered_name = turn_invalid_into_valid(name)

        # Completo el path con el book que llegó por parametro
        add_to_path("/#{filtered_name}")

        # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
        if (!Dir.exists?(@@path))
        return "El cuaderno '#{filtered_name}' no existe"
        end

        # Elimino el cuaderno que me llegó como parámetro y todas sus notas
        `rm -rf "#{@@path}"`
        return "El cuaderno '#{name}' y todas sus notas fueron eliminadas"
    end

    def list()
        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen cuadernos para listar. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        return (Dir.entries(@@path) - %w[. ..])
    end

    def rename(old_name, new_name)
        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega como parámetro el cuaderno "global" --> alerto un error
        if (old_name == @@default_book)
        return "No se puede renombrar el cuaderno '#{@@default_book}'."
        end

        filtered_old_name = turn_invalid_into_valid(old_name)
        filtered_new_name = turn_invalid_into_valid(new_name)

        # Completo el path con el nombre de los cuadernos
        path_old_name = @@path + "/#{filtered_old_name}"
        path_new_name = @@path + "/#{filtered_new_name}"

        # Chequeo que exista el cuaderno a renombrar
        if (Dir.exists?(path_old_name))
        # Si existe, chequeo que no haya otro cuaderno con el mismo nombre --> Si no hay, lo renombro
        if (!Dir.exists?(path_new_name))
            File.rename(path_old_name, path_new_name)
            return "El cuaderno '#{filtered_old_name}' fue renombrado por '#{filtered_new_name}' exitosamente"
        else
            return "El cuaderno '#{filtered_old_name}' no puede ser renombrado porque el cuaderno '#{filtered_new_name}' ya existe"
        end
        else
        return "El cuaderno '#{filtered_old_name}' no existe"
        end
    end

    def export(name, **options)
        global = options[:global]

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
            return "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        if ((name != nil) || global)

            if (global)
                filtered_book = @@default_book
            else
                filtered_book = turn_invalid_into_valid(name)
            end

            # Completo el path con el book correspondiente
            add_to_path("/#{filtered_book}")
            # Chequeo que el book exista --> Si no existe, retorno un mensaje de error.
            if (!Dir.exists?(@@path))
                return "El cuaderno '#{filtered_book}' no existe"
            end

            if ((Dir.entries(@@path) - %w[. ..]).count == 0)
                return "El cuaderno '#{filtered_book}' no contiene notas para exportar"
            end

            book_path = @@path
            files_count = Dir.glob("#{@@path}/*.rn").count
            files = Dir.glob("#{@@path}/*.rn")

            files.each { |file|
                # Creo una copia de cada nota y le cambio la extensión default a extension ".md" (markdown)
                FileUtils.cp file, "#{File.dirname(file)}/#{File.basename(file,'.*')}.md"
                # Guardo el nombre del archivo ".md" para posteriormente eliminarlo
                md_file = "#{File.dirname(file)}/#{File.basename(file,'.*')}.md"
                # Guardo el path con el nombre de cada nota y le agrego la extensión ".html"
                html_path = book_path + "/" + File.basename("#{file}", '.rn') + ".html"
                # Utilizo la gema github-markdown para convertir el archivo .md en html
                md_file_content = File.read(file)
                html_content = GitHub::Markdown.render(md_file_content)
                # Guardo el contenido HTML que obtuve del resultado de la operación con la gema en una nota nueva
                new_html_note = File.new(html_path, "w")
                new_html_note.puts(html_content)
                new_html_note.close
                # Elimino el archivo ".md" creado anteriormente
                FileUtils.rm (md_file)
            }
            return "Todas las notas del cuaderno '#{filtered_book}' se han exportado exitosamente"
        end

        # Si no me llegó ningún parámetro, exporto todas las notas del cajón de notas
        books_count = (Dir.entries(@@path) - %w[. ..]).count
        books_names = (Dir.entries(@@path) - %w[. ..])

        books_names.each { |book|
            # Completo el path del cajón de notas con cada book en particular
            base_path = @@path
            base_path += "/#{book}"

            files_count = Dir.glob("#{base_path}/*.rn").count
            files = Dir.glob("#{base_path}/*.rn")
            files.each { |file|
                # Creo una copia de cada nota y le cambio la extensión default a extension ".md" (markdown)
                FileUtils.cp file, "#{File.dirname(file)}/#{File.basename(file,'.*')}.md"
                # Guardo el nombre del archivo ".md" para posteriormente eliminarlo
                md_file = "#{File.dirname(file)}/#{File.basename(file,'.*')}.md"
                # Guardo el path con el nombre de cada nota y le agrego la extensión ".html"
                html_path = base_path + "/" + File.basename("#{file}", '.rn') + ".html"
                # Utilizo la gema github-markdown para convertir el archivo .md en html
                md_file_content = File.read(file)
                html_content = GitHub::Markdown.render(md_file_content)
                # Guardo el contenido HTML que obtuve del resultado de la operación con la gema en una nota nueva
                new_html_note = File.new(html_path, "w")
                new_html_note.puts(html_content)
                new_html_note.close
                # Elimino el archivo ".md" creado anteriormente
                FileUtils.rm (md_file)
            }
        }
        return "Todas las notas del cajón de notas se han exportado exitosamente"
    end

end
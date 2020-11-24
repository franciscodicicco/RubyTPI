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
          puts "El cuaderno '#{name}' fue creado exitosamente"
        else
          warn "El cuaderno '#{name}' ya existe"
        end
    end

    def delete(name, **options)
        global = options[:global]
        # Si me llega como parámetro el cuaderno "global" --> alerto un error
        if (name == @@default_book)
        return warn "No se puede eliminar el cuaderno '#{@@default_book}'. Si desea eliminar su contenido, agregue el comando --global"
        end

        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return warn "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega la opción "--global" como parámetro --> elimino todas las notas del Cuaderno Global
        if (global)
        # Completo el path con el Cuaderno Global
        add_to_path("/#{@@default_book}")
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

    def list()
        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return warn "No existen cuadernos para listar. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        return puts (Dir.entries(@@path) - %w[. ..])
    end

    def rename(old_name, new_name)
        # Chequeo que el default directory exista
        if (!default_directory_exists?)
        return warn "No existen notas ni cuadernos. Primero debe crear una nota o un cuaderno."
        end

        set_default_path()

        # Si me llega como parámetro el cuaderno "global" --> alerto un error
        if (old_name == @@default_book)
        return warn "No se puede renombrar el cuaderno '#{@@default_book}'."
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
            return puts "El cuaderno '#{filtered_old_name}' fue renombrado por '#{filtered_new_name}' exitosamente"
        else
            return warn "El cuaderno '#{filtered_old_name}' no puede ser renombrado porque el cuaderno '#{filtered_new_name}' ya existe"
        end
        else
        warn "El cuaderno '#{filtered_old_name}' no existe"
        end
    end

end
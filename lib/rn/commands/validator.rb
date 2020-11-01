module Validator

    @@default_directory = ".my_rns"
    @@default_book = "Cuaderno Global"
    @@extension = ".rn"
    @@path

    def set_default_path()
        # Seteo el path del directorio default ".my_rns"
        @@path = "#{Dir.home}/#{@@default_directory}"
    end

    def check_directory(path)
        # Chequeo que el directorio default ".my_rns" exista --> Si no existe, Creo el directorio default .my_rns y el cuaderno default "Cuaderno Global".
        if (!Dir.exists?(path))
            Dir.mkdir(path)
            path += "/#{@@default_book}"
            Dir.mkdir(path)
        end
    end

    def turn_invalid_into_valid(name)
        # Filtro caracteres inválidos del nombre ("/") y los reemplazo con un guión bajo ("_")
        return name.gsub("/", "_")
    end

    def add_to_path(partial_path)
        # Agrego al path el partial_path que me llega por parámetro
        return @@path += partial_path
    end
end
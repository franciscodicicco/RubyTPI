module Export_helper

    def export_note(path, new_path, html_path)
        # Creo una copia del archivo y le cambio la extensión default a extension ".md" (markdown)
        FileUtils.cp path, "#{File.dirname(path)}/#{File.basename(path,'.*')}.md"
        # Utilizo la gema github-markdown para convertir el archivo .md en html
        md_file_content = File.read(new_path)
        html_content = GitHub::Markdown.render(md_file_content)
        save_html_note(html_path, html_content)
        # Elimino el archivo ".md" creado anteriormente
        FileUtils.rm (new_path)
    end

    def export_all_notes(file, base_path)
        # Creo una copia de cada nota y le cambio la extensión default a extension ".md" (markdown)
        FileUtils.cp file, "#{File.dirname(file)}/#{File.basename(file,'.*')}.md"
        # Guardo el nombre del archivo ".md" para posteriormente eliminarlo
        md_file = "#{File.dirname(file)}/#{File.basename(file,'.*')}.md"
        # Guardo el path con el nombre de cada nota y le agrego la extensión ".html"
        html_path = base_path + "/" + File.basename("#{file}", '.rn') + ".html"
        # Utilizo la gema github-markdown para convertir el archivo .md en html
        md_file_content = File.read(file)
        html_content = GitHub::Markdown.render(md_file_content)
        save_html_note(html_path, html_content)
        # Elimino el archivo ".md" creado anteriormente
        FileUtils.rm (md_file)
    end

    def save_html_note(html_path, html_content)
        # Guardo el contenido HTML que obtuve del resultado de la operación con la gema en una nota nueva
        new_html_note = File.new(html_path, "w")
        new_html_note.puts(html_content)
        new_html_note.close
    end

end
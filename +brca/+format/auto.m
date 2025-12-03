function format = auto(object)

    switch class(object)

        case 'nifti'
            format = brca.format.nifti();

        case 'char'
            % get extension (and remove leading period)
            [~,~,ext] = fileparts(object);
            ext = ext(2:end);
            % build list of extensions that work with imread/imwrite
            image_ext = {};
            info = imformats;
            for n=1:numel(info)
                image_ext = [image_ext info.ext];
            end
            % if match, use image format
            if any(strcmpi(ext, image_ext))
                format = brca.format.image(ext);
            elseif strcmpi(ext, 'nii')
                format = brca.format.nifti();
            else
                error('file format %s unsuppported', ext);
            end

        otherwise
            try
                format = brca.format.numeric(class(object));
            catch
                warning('format %s unsuppported, using single instead', class(object));
                format = brca.format.single(class(object));
            end
    end

end

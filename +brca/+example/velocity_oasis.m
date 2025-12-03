%% ------------------------------------------------------------------------
%  Specify input/output folders

input_folder = '/scratch/shape/oasis/oasis_disc1';
output_folder = '.';

%% ------------------------------------------------------------------------
%  Build dataset

file_list = {};

sub = dir(input_folder);

for i=1:numel(sub)
    if sub(i).isdir
        if strcmpi(sub(i).name, '9')
            continue
        end
        subsub = dir(fullfile(input_folder, sub(i).name));
        for j=1:numel(subsub)
            if ~subsub(j).isdir ...
                    && numel(subsub(j).name) >= 4 ...
                    && strcmpi(subsub(j).name, 'velocity.nii')
                file_list{end+1} = fullfile(input_folder, sub(i).name, subsub(j).name);
            end
        end
    end
end

dataset = brca.dataset.image(file_list{:});

%% ------------------------------------------------------------------------
%  Prepare model

brca_model                   = brca.model();        % Create model
brca_model.verbose           = 2;                   % 1 = speak | 2 = plot
brca_model.M                 = 5;                   % Nb of principal components
brca_model.parallel          = 15;                  % Nb of workers (inf = all)
brca_model.nA0               = 20;                  % (prior) d.f. latent precision
brca_model.nm0               = inf;                 % (prior) d.f. mean (inf = fixed)
brca_model.nl0               = eps;                 % (prior) d.f. residual precision
brca_model.dot               = brca.dot.diffeo;     % Diffeo dot product
brca_model.dot.Absolute      = 0;                   % prm(1)
brca_model.dot.Membrane      = 0.001;               % prm(2)
brca_model.dot.Bending       = 0.02;                % prm(3)
brca_model.dot.LinearElastic = [0.0025 0.005];      % prm([4 5])
brca_model.dot.Boundary      = 0;                   % 0 = circulant | 1 = neumann

%% ------------------------------------------------------------------------
%  Fit model

trained_model = brca_model.train(dataset);

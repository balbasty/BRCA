function varargout = numel(varargin)

    format = brca.format.auto(varargin{1});
    [varargout{1:nargout}] = format.numel(varargin{:});

end

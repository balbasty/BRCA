function varargout = read(varargin)

    format = brca.format.auto(varargin{1});
    [varargout{1:nargout}] = format.read(varargin{:});

end

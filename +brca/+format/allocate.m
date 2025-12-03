function varargout = allocate(varargin)

    format = brca.format.auto(varargin{1});
    [varargout{1:nargout}] = format.allocate(varargin{:});

end

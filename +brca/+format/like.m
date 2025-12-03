function varargout = like(varargin)

    format = brca.format.auto(varargin{1});
    [varargout{1:nargout}] = format.like(varargin{:});

end

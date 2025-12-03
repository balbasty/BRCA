function varargout = class(varargin)

    format = brca.format.auto(varargin{1});
    [varargout{1:nargout}] = format.class(varargin{:});

end

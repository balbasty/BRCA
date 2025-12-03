function varargout = size(varargin)

    format = brca.format.auto(varargin{1});
    [varargout{1:nargout}] = format.size(varargin{:});

end

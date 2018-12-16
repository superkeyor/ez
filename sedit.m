% launch sedit

function varargout = main(varargin)
    if nargin < 1
        !open -a 'Sublime Text' 
    else
        filename = varargin{:};
        eval(['!open -a "Sublime Text" ' which(filename)])
    end
end
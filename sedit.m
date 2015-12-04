% launch sedit

function varargout = main(varargin)
    if nargin < 1
        !open -a 'Sublime Text 2' 
    else
        filename = varargin{:};
        eval(['!open -a "Sublime Text 2" ' which(filename)])
    end
end
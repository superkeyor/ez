% usage:
% if nargin < 3, method_showhelp; return; end

function method_showhelp(varargin)
% method_showhelp, work for a method of a class
ST = dbstack('-completenames');
if isempty(ST), fprintf('\nYou must call this within a function\n\n'); return; end
eval(sprintf('help ''%s''', ST(2).name));  
end
% usage:
% if nargin < 3, mfile_showhelp; return; end

function mfile_showhelp(varargin)
% MFILE_SHOWHELP
ST = dbstack('-completenames');
if isempty(ST), fprintf('\nYou must call this within a function\n\n'); return; end
eval(sprintf('help ''%s''', ST(2).file));  
end
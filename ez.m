classdef ez
    % author=jerryzhujian9@gmail.com, June 15 2014, 07:59:26 PM CDT
    % usage: 
    % add this file to search path of matlab (e.g. put in userpath)
    % import ez.* GetDir()
    % or ez.method without import: ez.GetDir()
    %
    % help method to see more information
    %       error(msg), print(), pprint(), 
    %
    %       cwd(), csd(), parentdir(path), 
    %       isdirlike(path), isfilelike(path), 
    %       isdir(path), isfile(path), exists(path)
    %       splitpath(path), joinpath(path1, path2), cd(path)
    % 
    %       typeof(sth), str(sth), num(sth), len(sth)
    %       ls(path, regex), fls(path, regex), 
    %
    %       mkdir(path), rm(path), cp(src, dest), mv(src, dest)
    %       execute(cmd)
    %
    %       Alert(msg), result = Confirm(msg), results = Inputs(values, defaults), 
    %       GetDir(path), GetFile(pattern, multiple), SetFile(defaultFileName)
    %
    % # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % # file save routine
    % # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %
    % create a matrix y, with two rows
    % x = 0:0.1:1;
    % y = [x; exp(x)];
    %
    % % open a file for writing
    % % r: Open file for reading. 
    % % w: Open or create new file for writing. Discard existing contents, if any
    % % a: Open or create new file for writing. Append data to the end of the file.
    % % http://www.mathworks.com/help/matlab/ref/fopen.html
    % fid = fopen('exptable.txt', 'w');
    %
    % % print a title, followed by a blank line
    % % \t tab, %d, '%6.4f' prints pi as '3.1416' %s
    % % http://www.mathworks.com/help/matlab/ref/fprintf.html
    % fprintf(fid, 'Exponential Function\n\n');
    %
    % % print values in column order
    % % two values appear on each row of the file
    % fprintf(fid, '%f  %f\n', y);
    % fclose(fid);


    methods(Static)

        function varargout = error(varargin)
            % Display message and abort function, a wrapper of error()
            [varargout{1:nargout}] = error(varargin{:}); 
        end
        
        function varargout = print(varargin)
            % Display a message or variable, a wrapper of disp()
            [varargout{1:nargout}] = disp(varargin{:}); 
        end
        
        function pprint(sth)
            % Display a message, supporting formating
            fprintf(sth); % or fprintf(sth)
        end

        function result = cwd()
            % returns the current working directory
            result  = pwd;
        end

        function result = csd()
            % returns the caller (current caller m script file) 's directory
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                result = fileparts(theStack.file);
            catch
                result = pwd;
            end
        end

        function result = parentdir(path)
            % returns the parent dir of a path (a file or folder), 
            % no matter whether it exists or not
            [pathstr, name, ext] = fileparts(path);
            % if folder
            if isempty(ext)
                result = pathstr;
            else
                result = fileparts(pathstr);
            end
        end

        function result = isdirlike(path)
            % returns whether the path is a folder or a file, 
            % no matter whether it exists or not
            [pathstr, name, ext] = fileparts(path);
            % if folder
            if isempty(ext)
                result = true;
            else
                result = false;
            end
        end

        function result = isfilelike(path)
            % returns whether the path is a folder or a file, 
            % no matter whether it exists or not
            [pathstr, name, ext] = fileparts(path);
            % if folder
            if isempty(ext)
                result = false;
            else
                result = true;
            end
        end

        function result = isfile(path)
            % returns whether the path is an existing file; 
            % doesnot support wildcards
            result = exist(path,'file') == 2;
        end

        function varargout = isdir(varargin)
            % returns whether the path is an existing folder; 
            % doesnot support wildcards, a wrapper of isdir()
            [varargout{1:nargout}] = isdir(varargin{:}); 
        end

        function result = exists(path)
            % returns whether a file or folder exits; doesnot support wildcards
            if exist(path,'file')
                result = true;
            else
                result = false;
            end
        end

        function varargout = splitpath(varargin)
            % pathstr = splitpath(filename)
            % [pathstr,name] = splitpath(filename) 
            % [pathstr,name,ext] = splitpath(filename) 
            %
            % example:
            % file = 'H:\user4\matlab\myfile.txt';
            % [pathstr,name,ext] = splitpath(file)
            % pathstr = H:\user4\matlab
            % name = myfile
            % ext = .txt
            %
            % [pathstr,name,ext] = splitpath('/home/jsmith/.cshrc')
            % pathstr = /home/jsmith
            % name = Empty string: 1-by-0
            % ext = .cshrc
            %
            % a wrapper of fileparts()

            % http://www.mathworks.com/help/matlab/ref/fileparts.html
            % ref: http://stackoverflow.com/questions/4895556/how-to-wrap-a-function-using-varargin-and-varargout
            [varargout{1:nargout}] = fileparts(varargin{:}); 
        end

        function varargout = joinpath(varargin)
            % joinpath(filepart1,...,filepartN)
            % conceptually equivalent to [filepart1 filesep filepart2 filesep ... filesep filepartN]

            % http://www.mathworks.com/help/matlab/ref/fullfile.html
            % ref: http://stackoverflow.com/questions/4895556/how-to-wrap-a-function-using-varargin-and-varargout
            [varargout{1:nargout}] = fullfile(varargin{:}); 
        end

        function varargout = cd(varargin)
            % changes directory, the same as cd()
            [varargout{1:nargout}] = cd(varargin{:}); 
        end

        function varargout = typeof(varargin)
            % returns the datatype of an input, a wrapper of class()
            [varargout{1:nargout}] = class(varargin{:}); 
        end

        function varargout = str(varargin)
            % converts a number to string, a wrapper of num2str()
            % supports formatting, see:
            % http://www.mathworks.com/help/matlab/ref/num2str.html
            [varargout{1:nargout}] = num2str(varargin{:}); 
        end

        function varargout = num(varargin)
            % converts a string to number, a wrapper of str2num()
            % '1 23 6 21; 53:56' -> 1 23 6 21 53 54 55 56 
            % http://www.mathworks.com/help/matlab/ref/str2num.html
            [varargout{1:nargout}] = str2num(varargin{:}); 
        end

        function varargout = len(varargin)
            % returns the len of an array
            [varargout{1:nargout}] = length(varargin{:}); 
        end

        function result = ls(rootdir, expstr, recursive)
            % returns a nx1 cell of files in directory with fullpath
            % ls(path,regex) regex is case sensitive by default
            switch nargin
                case 0
                    rootdir = pwd;
                    expstr = '.*';
                    recursive = false;
                case 1
                    % the first arg is tenatively rootdir
                    % user passed an existing dir
                    if isdir(rootdir)
                        rootdir = rootdir;
                        expstr = '.*';
                    % user passed a regex
                    else
                        expstr = rootdir;
                        rootdir = pwd;
                    end
                    recursive = false;
                case 2
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = false;
            end
            result = regexpdir(rootdir, expstr, recursive);
            % try
            %     % apply an anonymous function ~isdir to each element of the cell. then use logical indexing
            %     result = result(cellfun(@(x) ~isdir(x),result),1);
            % % empty result, if after cellfun, cannot indexed
            % catch
            %     result = cell(0,1);
            % end
        end

        function result = fls(rootdir, expstr, recursive)
            % returns a nx1 cell of files in directory with fullpath recursively
            % fls(path,regex) regex is case sensitive by default
            switch nargin
                case 0
                    rootdir = pwd;
                    expstr = '.*';
                    recursive = true;
                case 1
                    % the first arg is tenatively rootdir
                    % user passed an existing dir
                    if isdir(rootdir)
                        rootdir = rootdir;
                        expstr = '.*';
                    % user passed a regex
                    else
                        expstr = rootdir;
                        rootdir = pwd;
                    end
                    recursive = true;
                case 2
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = true;
            end
            result = regexpdir(rootdir, expstr, recursive);
            % try
            %     % apply an anonymous function ~isdir to each element of the cell. then use logical indexing
            %     result = result(cellfun(@(x) ~isdir(x),result),1);
            % catch
            %     result = cell(0,1);
            % end
        end

        function status = mkdir(path)
            % makes a new dir, path could be absolute or relative, returns true or false
            % creates all neccessay parent folders (e.g. 'a/b/c', creates a b for c)
            % if folder exits, still creates and returns success
            warning('off', 'MATLAB:MKDIR:DirectoryExists');
            status = mkdir(path);
            disp([path ' created']);
            warning('on', 'MATLAB:MKDIR:DirectoryExists');
        end

        function rm(path)
            % removes a folder recursively or a file; file supports wildcards
            if isdir(path)
                rmdir(path, 's');
                % disp([path ' removed folder']);
            else
                delete(path);
                % disp([path ' removed file']);
            end
        end

        function varargout = cp(varargin)
            % copys a file or folder to new destination , a wrapper of copyfile()
            % be careful with the trailing fielsep! in the destination
            % example: ('Projects/my*','../newProjects/')
            % sources supports wildcards
            % destination does not have to exist to begin with
            % http://www.mathworks.com/help/matlab/ref/copyfile.html
            [varargout{1:nargout}] = copyfile(varargin{:}); 
        end

        function varargout = mv(varargin)
            % moves a file or folder to new destination , a wrapper of movefile()
            % be careful with the trailing fielsep! in the destination
            % cannot be used to rename a file or folder
            % example: ('Projects/my*','../newProjects/')
            % sources supports wildcards
            % destination does not have to exist to begin with
            % http://www.mathworks.com/help/matlab/ref/movefile.html
            [varargout{1:nargout}] = movefile(varargin{:}); 
        end

        function result = execute(command)
            % execute operating system command and returns output
            [status,result] = system(command,'-echo');
        end

        % # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        % # 
        % # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        function Alert(msg)
            % msg = {'Message line 1';'Message line 2'}
            % no-modal dialogue. script still continues without waiting for user response.
            warndlg(msg,'Alert!');
        end

        function result = Confirm(msg)
            % msg = {'Message line 1';'Message line 2'}
            % returns true (only when Yes pressed) or false (anything else)
            button = questdlg(msg,'Question?','Yes','No','No');
            switch button
                case 'Yes'
                    result = true;
                otherwise
                    result = false;
            end
            if (~result); error('MATLAB:ambiguousSyntax','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function results = Inputs(values, defaults)
            % Inputs({'x=', 'y='})      Inputs({'x=', 'y='},{'2','2'})
            % {'x=', 'y='}, {'0','0'} <- default Answer must be a cell array of strings.
            % returns a <n x 1 cell array> or {}; defaults is optional
            % use isempty() to  parse results
            if ~exist('defaults','var'); defaults = cell(size(values)); defaults(:)={['']}; end  % defaults(:)={''} also works
            results = inputdlg(values, 'Inputs:', 1, defaults, 'on');
            if (isempty(results)); error('MATLAB:ambiguousSyntax','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function result = GetDir(path)
            % returns a path string/char or false
            % path is default path; optional, defaults to current script directory

            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                csd = fileparts(theStack.file);
            catch
                csd = pwd;
            end

            if ~exist('path','var'); path = csd; end
            result = uigetdir(path,'Select a folder...');
            if isequal(result, 0); result = false; end
            if (~result); error('MATLAB:ambiguousSyntax','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function result = GetFile(pattern, multiple)
            % pattern = {'*.xls';'*.txt';'*.csv'} or {'*.m'} or '*.*'
            % {'*.m;*.fig;*.mat;*.slx;*.mdl','MATLAB Files (*.m,*.fig,*.mat,*.slx,*.mdl)';
            %  '*.m','Code files (*.m)';
            %  '*.fig','Figures (*.fig)';
            %  '*.mat','MAT-files (*.mat)';
            %  '*.mdl;*.slx','Models (*.slx, *.mdl)';
            %  '*.*','All Files (*.*)'}
            %
            % multiple = 1, 0; optional, default 1 allowing multiple selection
            %
            % returns a nx1 cell with full path to file(s) (no matter how many files selected), or {}

            if ~exist('pattern','var')
                pattern = {'*.*','All Files (*.*)'};
            end

            if ~exist('multiple','var')
                multiple = 'on';
            elseif isequal(multiple, 1)
                    multiple = 'on';
            elseif isequal(multiple, 0)
                multiple = 'off';
            end

            [fileName,pathName,filterIndex] = uigetfile(pattern,'Select file(s)...', 'MultiSelect', multiple);
            if isequal(fileName, 0)
                result = {};
            else
                if ~iscell(fileName); fileName = {fileName}; end
                % transpose to nx1 cell from 1xn
                fileName = fileName .';
                result = cellfun(@(x) fullfile(pathName,x),fileName, 'UniformOutput', false);
            end
            if (isempty(result)); error('MATLAB:ambiguousSyntax','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function result = SetFile(defaultFileName)
            % saves a file
            % returns the fullpath string/char or false
            % optional defaultFileName = ''
            if ~exist('defaultFileName','var'); defaultFileName = ''; end
            [fileName,pathName,filterIndex] = uiputfile({'*.*','All Files (*.*)'},'Save (as) ...',defaultFileName);
            if isequal(fileName, 0)
                result = false;
            else
                result = fullfile(pathName, fileName);
            end
            if (~result); error('MATLAB:ambiguousSyntax','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

    end
end

% modified from http://www.mathworks.com/matlabcentral/fileexchange/16216-regexpdir
function dirlist = regexpdir(rootdir, expstr, recursive)
% REGEXPDIR Gives a directory listing based on a regular expression
%    REGEXPDIR(ROOTDIR, REGEXP) gives a directory listing of the directory 
%    ROOTDIR based on the pattern specified by the regular expression
%    REGEXP. 
% 
%    REGEXPDIR(ROOTDIR, REGEXP, RECURSIVE) By default REGEXPDIR traverses 
%    all subdirectories recursively. This behaviour can be controlled by
%    supplying the optional boolean RECURSIVE. Setting this to 'false' will
%    limit the function to the directory specified in ROOTDIR. 
% 
%    Example:
%     rootdir = 'C:\';
%     expstr = '^.*\.exe$';
%     dirlist = regexpdir(rootdir, expstr);
% 
%    The above example will return any EXE files on the C-drive. 
% 
%    By default REGEXPDIR searches case insensitive (I changed to case sensitve by default--Jerry). To make it case
%    senstitive please specify it in the regular expression by adding 
%    '(?-i)' to it. Ommitting to specify the beginning '^' and ending '$'
%    of the regular expression may result in unexpected behaviour.
% 
%    Have a look at the source code for more information. For more 
%    info on this function and how to use it, bug reports, feature
%    requests, etc. feel free to contact the author.
% 
%    See also DIR, REGEXP, REGEXPTRANSLATE

%==========================================================================
% B.C. Hamans (b.c.hamans@rad.umcn.nl)                                 2007
%==========================================================================

% Check input arguments
% error(nargchk(2, 3, nargin));
if ~exist('recursive','var'); recursive = true; end

% Check if the root directory contains a trailing file seperator or supply
rootdir = char(rootdir); 
if ~strcmp(rootdir(length(rootdir)), filesep); rootdir=[rootdir filesep]; end

% Remember initial starting directory when traversing. 
persistent basedir; if isempty(basedir); basedir = rootdir; end

% Traverse the structure
% dirlist = cell({}); dirtree = dir(rootdir);
dirlist = cell(0,1); dirtree = dir(rootdir);
for h = find([dirtree.isdir]);
    if ~any(strcmp({'.','..'}, dirtree(h).name));
        % if regexpi(strrep(fullfile(rootdir, dirtree(h).name, filesep), basedir, ''), expstr);
        %     dirlist = [dirlist; fullfile(rootdir, dirtree(h).name, filesep)];
        % end
        if recursive;
            dirlist = [dirlist; regexpdir(fullfile(rootdir, dirtree(h).name, filesep), expstr, recursive)];
        end
    end
end
for i = find(~[dirtree.isdir]);
    % if regexpi(strrep(fullfile(rootdir, dirtree(i).name), basedir, ''), expstr);
    if regexp(dirtree(i).name, expstr);
        dirlist = [dirlist; fullfile(rootdir, dirtree(i).name)];
    end
end
end
%==========================================================================
% Changelog:
% 03-09-2007 v1.00 (BCH)  Initial release
% 20-09-2007 v1.01 (BCH)  Proper solution for persistent variable 'basedir'
%==========================================================================
classdef ez
    % author=jerryzhujian9@gmail.com, June 15 2014, 07:59:26 PM CDT
    % usage: 
    % add this file to search path of matlab (e.g. put in userpath)
    % import ez.* GetDir()
    % or ez.method without import: ez.GetDir()
    %
    % help method to see more information
    %       clear(), clean()
    %
    %       iff(test,s1,s2)
    %
    %       sleep([seconds])
    %
    %       error(msg), print(sth), pprint(sth[, color])
    %       writelog(line[,file]), log(line[,file])
    %
    %       moment()
    %
    %       cwd(), pwd(), csd(), csf(), parentdir(path), 
    %       isdirlike(path), isfilelike(path), 
    %       isdir(path), isfile(path), exists(path)
    %       addpath(path), splitpath(path), joinpath(path1, path2), trimdir(path), cd(path)
    % 
    %       typeof(sth), type(sth), str(sth), num(sth), len(sth)
    %       ls([[path, ]regex, fullpath]), fls([[path, ]regex]), lsd([[path, ]regex, fullpath])
    %
    %       join(sep,string1,string2) or join(sep,array)
    %       replace(cellArray, item, replacement)
    %
    %       mkdir(path), rm(path), cp(src, dest), mv(src, dest), rn(src, dest)
    %       execute(cmd)
    %
    %       Alert(msg), result = Confirm(msg), results = Inputs(values[, defaults, title]), 
    %       GetDir([title, path]), 
    %       [result, pathName] = GetFile([pattern[, title, multiple]]), [result, pathName] = SetFile([defaultFileName[, title]])
    %       WinTop([fig])
    %
    %       GetVal(baseVarName)
    %
    %       cell2csv(csvFile,cellArray)
    %       result = csv2cell(csvFile)
    %       [raw,num,txt] = xls2cell(xlsFile)
    %
    %       gmail(email, subject, content, sender, user, pass) 
    %
    %       export(), capture()
    %
    %       backward compatabilities: union, unique, ismember, setdiff, intersect, setxor       
    %
    %       result = AreTheseToolboxesInstalled({,})
    %       result = compare(A,B)
    %       expand(C)
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

        function clean()
            % clear command window, all variables. close all figures. show workspace/variables window
            clc;         % clear command window
            clear all;   % clear workspace/variables
            evalin('base','clear all');  % clear base workspace as well
            close all;   % close all figures
            % workspace;   % show/activate workspace/variables window
            commandwindow; % refocus to command window
        end

        function clear()
            % clear command window, all variables. close all figures. show workspace/variables window
            clc;         % clear command window
            clear all;   % clear workspace/variables
            evalin('base','clear all');  % clear base workspace as well
            close all;   % close all figures
            % workspace;   % show/activate workspace/variables window
            commandwindow; % refocus to command window
        end

        function result = iff(test,s1,s2)
            % Usage:
            %  >> result = iff(test, s1, s2);
            %
            % Input:
            %   test   - logical test with result 0 or 1
            %   s1     - result if 1
            %   s2     - result if 0
            %
            % Output:
            %   result    - s1 or s2 depending on the value of the test
            if test
                result = s1;
            else
                result = s2;
            end
            return;
        end

        function varargout = error(varargin)
            % Display message and abort function, a wrapper of error()
            [varargout{1:nargout}] = error(varargin{:}); 
        end

        function varargout = sleep(varargin)
            % sleep([seconds])
            % seconds could be fraction, e.g., sleep(0.01) 10ms
            % if no para, sleep(), pause and wait user to strike any key before continuing
            % a wrapper of pause()
            [varargout{1:nargout}] = pause(varargin{:}); 
        end

        function writelog(line,file)
            % writelog(line[,file])
            % Inputs:
            %   line, a record line in string type
            %   file--optional, log file path, defaults to "Log.txt" in the current working directory
            % Append a record line with timestamp to a log file and also display the message on screen
            % returns nothing

            if ~exist('file','var'), file = 'Log.txt'; end
            timestamp = datestr(now,'yyyy-mm-dd_HH-MM-SS-FFF');

            fid = fopen(file,'a');
            fprintf(fid,'%s,%s\n',timestamp,line);
            fclose(fid);

            % show on screen
            fprintf('%s,%s\n',timestamp,line);
        end

        function log(line,file)
            % log(line[,file])
            % Inputs:
            %   line, a record line in string type
            %   file--optional, log file path, defaults to "Log.txt" in the current working directory
            % Append a record line with timestamp to a log file and also display the message on screen
            % returns nothing

            if ~exist('file','var'), file = 'Log.txt'; end
            timestamp = datestr(now,'yyyy-mm-dd_HH-MM-SS-FFF');

            fid = fopen(file,'a');
            fprintf(fid,'%s,%s\n',timestamp,line);
            fclose(fid);

            % show on screen
            fprintf('%s,%s\n',timestamp,line);
        end
        
        function varargout = print(varargin)
            % Display message without formating, start a new line, a wrapper of disp()
            [varargout{1:nargout}] = disp(varargin{:}); 
        end

        function pprint(sth, color)
            % print(sth[, color]), color is optional, default to 'purple'
            % Display a message in the command window, supporting formating and color
            % color(case-insensitive): 'Black','Cyan','Magenta','Blue','Green','Red','Yellow','White'
            
            % Strings are in Purple
            if ~exist('color','var'); color = 'Strings'; end
            % cprintf by default does not start a new line
            sth = [sth '\n'];
            cprintf(color,sth);
        end

        function result = moment(format)
            % moment([format])
            % returns a char/string representing the current time
            % format is optional, default to 'yyyy-mm-dd_HH-MM-SS-FFF'
            %
            % yyyy, Year in full, 1990
            % yy, Year in two digits, 02
            % mmmm, Month using full name, March, December
            % mmm, Month using first three letters, Mar, Dec
            % mm, Month in two digits, 03, 12
            % dddd, Day using full name, Monday, Tuesday
            % ddd, Day using first three letters, Mon, Tue
            % dd, Day in two digits, 05, 20
            % d, Day using capitalized first letter, M, T
            %
            % HH, Hour in two digits, (no leading zeros when symbolic identifier AM or PM is used), 05, 5 AM
            % MM, Minute in two digits, 12, 02
            % SS, Second in two digits, 07, 59
            % FFF, Millisecond in three digits, 057
            % AM or PM, converts from 24 hr to 12 hr, 3:45:02 PM
            if ~exist('format','var'); format = 'yyyy-mm-dd_HH-MM-SS-FFF'; end
            result = datestr(now, format);
        end

        function result = cwd()
            % cwd()
            % returns the current working directory
            result  = pwd;
        end

        function result = pwd()
            % pwd()
            % returns the current working directory
            result  = pwd;
        end

        function result = csd()
            % csd()
            % returns the caller (current caller m script file)'s directory
            % see also http://www.mathworks.com/access/helpdesk/help/techdoc/ref/mfilename.html
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                result = fileparts(theStack.file);
            catch
                result = pwd;
            end
        end

        function result = csf()
            % csf()
            % returns the caller (current caller m script file)'s name only (without filepath and fileext)
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                [folder, name, ext] = fileparts(theStack.file);
                result = name;
            catch
                result = '';
            end
        end

        function result = parentdir(path)
            % parentdir(path)
            % returns the parent dir of a path (a file or folder), 
            % no matter whether it exists or not
            % no matter whether the path has a trailing filesep / \
            
            % trim path first
            if isempty(path)
                path = '';
            else
                path = strtrim(path);  % remove leading and trailing white spaces
                % check the last char to see if it is a \w (alphabetic, numeric, or underscore); if it is \, / or other stuff regexp returns []
                if isempty(regexp(path(end),'\w')), path = path(1:end-1); end
            end
            % trim finishes
            [pathstr, name, ext] = fileparts(path);
            % if folder
            if isempty(ext)
                result = pathstr;
            else
                result = fileparts(pathstr);
            end
            if isempty(result), result = pwd(); end
        end

        function result = isdirlike(path)
            % isdirlike(path)
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
            % isfilelike(path)
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
            % isfile(path)
            % returns whether the path is an existing file; 
            % doesnot support wildcards
            result = exist(path,'file') == 2;
        end

        function varargout = isdir(varargin)
            % isdir(path)
            % returns whether the path is an existing folder; 
            % doesnot support wildcards, a wrapper of isdir()
            [varargout{1:nargout}] = isdir(varargin{:}); 
        end

        function result = exists(path)
            % exists(path)
            % returns whether a file or folder exits; doesnot support wildcards
            if exist(path,'file')
                result = true;
            else
                result = false;
            end
        end

        function setdefault(variable,defaultValue)
            % setdefault(variable,defaultValue)
            % sets a default value for a variable, does not returns anything
            % useful for define a function as in the following example:
            %
            % function result = funcname(para,varargin)
            %       setdefault('para',3)
            %       blabla...
            % end
            %
            % effectively the same as: 
            % if ~exist('para','var'), para = 3; end
            varExist = evalin('caller',sprintf('exist(''%s'',''var'')',variable));  % '' to escape
            if ~varExist
                assignin('caller',variable,defaultValue);
            end
        end

        function varargout = addpath(varargin)
            % addpath(varargin)
            % Add a path to matlab search path, a wrapper of addpath()
            % http://www.mathworks.com/help/matlab/ref/addpath.html
            [varargout{1:nargout}] = addpath(varargin{:}); 
        end

        function varargout = splitpath(varargin)
            % pathstr = splitpath(filename)
            % [pathstr,name] = splitpath(filename) 
            % [pathstr,name,ext] = splitpath(filename) 
            % no matter whether the path has a trailing filesep / \
            % note: input could be a n*1 cell array, vectorization supported
            
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
            path = varargin{:};
            % vectorization, recursive call using cellfun
            if strcmp(class(path),'cell')
                [varargout{1:nargout}] = cellfun(@(e) ez.splitpath(e),path,'UniformOutput',false);
                return; 
            end
            % trim path first
            if isempty(path)
                path=[];
            else
                path = strtrim(path);  % remove leading and trailing white spaces
                % check the last char to see if it is a \w (alphabetic, numeric, or underscore); if it is \, / or other stuff regexp returns []
                if isempty(regexp(path(end),'\w')), path = path(1:end-1); end
            end
            % trim finishes
            [varargout{1:nargout}] = fileparts(path); 
        end

        function varargout = joinpath(varargin)
            % joinpath(filepart1,...,filepartN)
            % conceptually equivalent to [filepart1 filesep filepart2 filesep ... filesep filepartN]
            % but this function works regardless whether filepart has a trailing filesep or not (e.g. a/b or a/b/)
            % note: input could be a n*1 cell array, vectorization supported
            % e.g., (pwd,{'a';'b'},{'a1';'b1'})-->{'pwd/a/a1'; 'pwd/b/b1'} in which dimensions of {'a';'b'},{'a1';'b1'} should match

            % http://www.mathworks.com/help/matlab/ref/fullfile.html
            % ref: http://stackoverflow.com/questions/4895556/how-to-wrap-a-function-using-varargin-and-varargout
            
            vectorization = false;
            % to see whether there is a n*1 cell array input
            for i = 1:nargin
                if strcmp(class(varargin{i}),'cell')
                    vectorization = true;
                    dim = size(varargin{i});
                    if dim(2) ~= 1, error('Input only supports n*1 cell array'); end
                    break;
                end
            end

            if vectorization
                for i = 1:nargin
                    if ~strcmp(class(varargin{i}),'cell')
                        varargin{i} = repmat(cellstr(varargin{i}),dim);
                    end
                end
                % reorganize varargin
                tempParts = [varargin{:}];
                parts = {};
                for i = 1:size(tempParts,1)
                    parts = [parts;{tempParts(i,:)}];
                end
                [varargout{1:nargout}] = cellfun(@(e) fullfile(e{:}),parts,'UniformOutput',false);
            else
                [varargout{1:nargout}] = fullfile(varargin{:}); 
            end
        end
        
        function result = join(sep,varargin)
            % glue together strings/array with sep
            % 
            % 1) join('','string1','string2',...)
            % 2) Input only supports n*1 cell array
            %    join('|',{'string1';'string2'},{'string3';'string4'},...) -> {string1|string3;string2|string4}
            % 3) join(',',{'this','is','a','cell','array'})
            %    join('_',[1,2,2]) >> 1_2_2
            %    join('\t',{1,2,2,'string'})
            
            % nargin refers to all incoming args, not just the ones in varargin
            % in the case of (sep), nargin = 1
            if nargin < 2
                error('Give me more inputs');
            elseif nargin == 2
                result = strjoin(varargin{1},sep);
                return;
            else
                vectorization = false;
                % to see whether there is a n*1 cell array input
                for i = 1:length(varargin)
                    if strcmp(class(varargin{i}),'cell')
                        vectorization = true;
                        dim = size(varargin{i});
                        if dim(2) ~= 1, error('Input only supports n*1 cell array'); end
                        break;
                    end
                end

                if vectorization
                    for i = 1:length(varargin)
                        if ~strcmp(class(varargin{i}),'cell')
                            varargin{i} = repmat(cellstr(varargin{i}),dim);
                        end
                    end
                    % reorganize varargin
                    tempParts = [varargin{:}];
                    parts = {};
                    for i = 1:size(tempParts,1)
                        parts = [parts;{tempParts(i,:)}];
                    end
                    result = cellfun(@(e) ez.join(sep,e{:}),parts,'UniformOutput',false);
                    return;
                end

                result = varargin{1};
                for i = 2:length(varargin)
                    result = [result sep varargin{i}];
                end
            end % end if nargin
        end

        function result = replace(cellArray, item, replacement)
            % (cellArray, item, replacement)
            % replace all occurance of item in cellArray with replacement
            % 
            % input cell array could be an array (any dimensions) of numbers, or strings or mixed
            % item could be a number, e.g., 3, or an (anonymous) function
            % Be careful with comparing char with number 'cat'>3 returns [1 1 1]
            % 
            % Returns the changed cell array but the passed-in array is NOT changed.
            % input cell array could be any dimensions, but always returns n*1 cell array
            % 
            % e.g., 
            % replace({0,-1,1},@(x) x~=0,0)         % recommended for both string and number
            % replace({'c','a','cat'},'cat','tom')  % strcmp(string), same as replace({'c','a','cat'},@(x) strcmp(x,'cat'),'tom')
            % replace({0,-1,1},-1,0)                % equal number
            % replace({'cat','bat','sit'},@(x) isempty(regexp(x,'[bc]at')), 'tom')  % returns cat bat tom

            array = cellArray(:);
            % check if item is function handle
            % http://stackoverflow.com/questions/7867247/how-to-test-a-variable-is-a-function-handle-or-not-in-matlab
            if isa(item, 'function_handle')
                for i = 1:length(array)
                    if item(array{i})
                        array{i} = replacement;
                    end
                end
            else
                if ~strcmp(class(item),'char')  % equal numbers
                    for i = 1:length(array)
                        if array{i} == item
                            array{i} = replacement;
                        end
                    end 
                else
                    for i = 1:length(array)     % equal strings
                        if strcmp(array{i}, item)
                            array{i} = replacement;
                        end
                    end 
                end
            end
            result = array;
        end
        
        function result = remove(cellArray, item)
            % (cellArray, item)
            % remove all occurance of item in cellArray
            % 
            % input cell array could be an array (any dimensions) of numbers, or strings or mixed
            % item could be a number, e.g., 3, or an (anonymous) function
            % Be careful with comparing char with number 'cat'>3 returns [1 1 1]
            % 
            % Returns the changed cell array but the passed-in array is NOT changed.
            % input cell array could be any dimensions, but always returns n*1 cell array
            % 
            % e.g., 
            % remove({0,-1,1},@(x) x~=0)         % recommended for both string and number
            % remove({'c','a','cat'},'cat')      % strcmp(string), same as remove({'c','a','cat'},@(x) strcmp(x,'cat'))
            % remove({0,-1,1},-1)                % equal number
            % remove(files,@(x) isempty(regexp(x,'VR')))

            array = cellArray(:);
            % check if item is function handle
            % http://stackoverflow.com/questions/7867247/how-to-test-a-variable-is-a-function-handle-or-not-in-matlab
            if isa(item, 'function_handle')
                for i = 1:length(array)
                    if item(array{i})
                        array{i} = '!!!';
                    end
                end
            else
                if ~strcmp(class(item),'char')  % equal numbers
                    for i = 1:length(array)
                        if array{i} == item
                            array{i} = '!!!';
                        end
                    end 
                else
                    for i = 1:length(array)     % equal strings
                        if strcmp(array{i}, item)
                            array{i} = '!!!';
                        end
                    end 
                end
            end
            % delete '!!!' by selective copying to a new array
            newArray = {};
            for i = 1:length(array)
                if ~strcmp(array{i}, '!!!')
                    newArray = [newArray; array{i}];
                end
            end 
            result = newArray;
        end

        function result = trimdir(path)
            % trimdir(path)
            % remove leading and trailing white spaces from a dir path, 
            % and also any non-alphabetic, non-numeric, or non-underscore char (e.g., \ or /) at the dir path end
            % note: input could be a n*1 cell array, vectorization supported

            % vectorization, recursive call using cellfun
            if strcmp(class(path),'cell')
                result = cellfun(@(e) ez.trimdir(e),path,'UniformOutput',false);
                return; 
            end
            if isempty(path)
                result = '';
            else
                result = strtrim(path);  % remove leading and trailing white spaces
                % check the last char to see if it is a \w (alphabetic, numeric, or underscore); if it is \, / or other stuff regexp returns []
                if isempty(regexp(result(end),'\w')), result = result(1:end-1); end
            end
        end

        function varargout = cd(varargin)
            % cd(varargin)
            % changes directory, the same as cd()
            [varargout{1:nargout}] = cd(varargin{:}); 
        end

        function varargout = type(varargin)
            % type(varargin)
            % returns the datatype of an input, a wrapper of class()
            [varargout{1:nargout}] = class(varargin{:}); 
        end

        function varargout = typeof(varargin)
            % typeof(varargin)
            % returns the datatype of an input, a wrapper of class()
            [varargout{1:nargout}] = class(varargin{:}); 
        end

        function varargout = str(varargin)
            % str(varargin)
            % converts a number to string, a wrapper of num2str()
            % supports formatting, see:
            % http://www.mathworks.com/help/matlab/ref/num2str.html
            [varargout{1:nargout}] = num2str(varargin{:}); 
        end

        function result = num(sth)
            % num(sth)
            % converts a string to number. if input a num, still return that num
            % '1 23 6 21; 53:56' ->      1    23     6    21
            %                           53    54    55    56
            if isnumeric(sth)
                result = sth;
            elseif ischar(sth)
                result = str2num(sth); 
            else
                error('Unsupported Input Type');
            end
        end

        function varargout = len(varargin)
            % len(varargin)
            % returns the len of an array
            [varargout{1:nargout}] = length(varargin{:}); 
        end

        function result = ls(rootdir, expstr, fullpath)
            % ls(), ls(path), ls(regex), ls(path, regex), ls(path, regex, fullpath)
            % if path is missing, refers to current working directory
            % returns a nx1 cell of files in directory with fullpath (default fullpath=true)
            % ls(path,regex) regex is case sensitive by default
            switch nargin
                case 0
                    rootdir = pwd;
                    expstr = '.*';
                    recursive = false;
                    fullpath = true;
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
                    fullpath = true;
                case 2
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = false;
                    fullpath = true;
                case 3
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = false;
                    fullpath = fullpath;                    
            end
            result = regexpdir(rootdir, expstr, recursive);

            if ~fullpath, result = cellfun(@GetFileName,result,'UniformOutput',false); end
            function result = GetFileName(e)
                parts = regexp(e,filesep,'split');
                result = parts{end};
            end % end sub-function
        end

        function result = fls(rootdir, expstr)
            % fls(), fls(path), fls(regex), fls(path, regex)
            % if path is missing, refers to current working directory
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
        end

        function result = lsd(path,regex,fullpath)
            % ls directory, lsd(), lsd(path), lsd(regex), lsd(path, regex), lsd(path, regex, fullpath)
            % path defaults to pwd, not recursive; support case-sensitive regex, default .*
            % returns a nx1 cell with all subfolder's names (only names, sorted ascending), or an empty 0 x 1 cell.
            % fullpath defaults to false
            switch nargin
                case 0
                    path = pwd;
                    regex = '.*';
                    fullpath = false;
                case 1
                    % the first arg is tenatively path
                    % user passed an existing dir
                    if isdir(path)
                        path = path;
                        regex = '.*';
                    % user passed a regex
                    else
                        regex = path;
                        path = pwd;
                    end
                    fullpath = false;
                case 2
                    path = path;
                    regex = regex;
                    fullpath = false;
                case 3
                    path = path;
                    regex = regex;
                    fullpath = fullpath;
            end
            listing = dir(path);
            issub = [listing(:).isdir]; % returns logical vector
            folderNames = {listing(issub).name}';
            folderNames(ismember(folderNames,{'.','..'})) = []; % get rid of . ..
            ind = cellfun(@(x)( ~isempty(x) ), regexp(folderNames, regex));
            result = folderNames(ind);
            result = sort(result); % ascending order

            if fullpath, result = cellfun(@(e) fullfile(path,e),result,'UniformOutput',false); end
        end

        function status = mkdir(path)
            % mkdir(path)
            % makes a new dir, path could be absolute or relative, returns true or false
            % creates all neccessay parent folders (e.g. 'a/b/c', creates a b for c)
            % if folder exits, does nothing and returns success/true
            if isdir(path)
                status = true;
            else
                status = mkdir(path);
                disp([path ' created']);
            end

            % % mkdir(path)
            % % makes a new dir, path could be absolute or relative, returns true or false
            % % creates all neccessay parent folders (e.g. 'a/b/c', creates a b for c)
            % % if folder exits, still creates and returns success
            % warning('off', 'MATLAB:MKDIR:DirectoryExists');
            % status = mkdir(path);
            % disp([path ' created']);
            % warning('on', 'MATLAB:MKDIR:DirectoryExists');
        end

        function rm(path)
            % rm(path)
            % removes a folder recursively or a file; file supports wildcards
            % if a path does not exist, nothing happens.
            % note: input could be a n*1 cell array, vectorization supported

            % vectorization, recursive call using cellfun
            if strcmp(class(path),'cell')
                cellfun(@(e) ez.rm(e),path,'UniformOutput',false);
                return; 
            end

            if isdir(path)
                rmdir(path, 's');
                % disp([path ' removed folder']);
            elseif exist(path,'file') == 2
                delete(path);
                % disp([path ' removed file']);
            end
        end

        function varargout = cp(varargin)
            % cp(from, to)
            % copies a file or folder to new destination
            % to folder does not have to exist already (if exists, merge the folders)
            % from and to cannot be the same, otherwise error
            % note: input could be a n*1 cell array, vectorization supported
            %       trailing filesep in destination folder does not matter
            %
            % e.g.,
            % 1) both works ez.cp('a.txt','folder'), ez.cp('a.txt','folder/b.txt')
            % the former copy still has the same name 'a.txt', the latter copy new name 'b.txt'
            % also ez.cp(['a.txt','b.txt'],'folder')
            % 2) folder: ez.cp('a','b')-->if b not exists, cp contents of a to b; if b exist, a becomes subfolder of b
            % kinda combines rn and mv
            % 3) regular expression
            % flist = ls("patha", "^filea.+[.]csv$")
            % cp(flist, "pathb")
            %
            % sources supports wildcards
            % example: ('Projects/my*','../newProjects/')  
            % copy files and folders beginning with 'my'
            %
            % http://www.mathworks.com/help/matlab/ref/copyfile.html

            vectorization = false;
            % to see whether there is a n*1 cell array input
            for i = 1:nargin
                if strcmp(class(varargin{i}),'cell')
                    vectorization = true;
                    dim = size(varargin{i});
                    if dim(2) ~= 1, error('Input only supports n*1 cell array'); end
                    break;
                end
            end

            if vectorization
                for i = 1:nargin
                    if ~strcmp(class(varargin{i}),'cell')
                        varargin{i} = repmat(cellstr(varargin{i}),dim);
                    end
                end
                % reorganize varargin
                tempParts = [varargin{:}];
                parts = {};
                for i = 1:size(tempParts,1)
                    parts = [parts;{tempParts(i,:)}];
                end
                [varargout{1:nargout}] = cellfun(@(e) ez.cp(e{:}),parts,'UniformOutput',false);
                return;
            end

            from = varargin{1}; to = varargin{2};
            % if from is dir
            if isdir(from)
                % if to exists
                if isdir(to)
                    [dummy,folderName] = fileparts(from);
                    to = fullfile(to,folderName);
                else
                    toDir = fileparts(to);
                    if isempty(toDir), toDir = pwd(); end
                    if ~isdir(toDir), mkdir(toDir); end
                end
                [varargout{1:nargout}] = copyfile(from,to);
                return;
            end

            [pathstr, name, ext] = fileparts(to);
            % if to dirlike
            if isempty(ext)
                % if to dir not exist
                if ~isdir(to), mkdir(to); end
            else
                toDir = fileparts(to);
                if isempty(toDir), toDir = pwd(); end
                if ~isdir(toDir), mkdir(toDir); end
            end
            [varargout{1:nargout}] = copyfile(varargin{:});
        end

        function varargout = mv(varargin)
            % mv(from, to)
            % moves a file or folder to new destination
            % to folder does not have to exist already (if exists, merge the folders)
            % from and to cannot be the same, otherwise error
            % note: input could be a n*1 cell array, vectorization supported
            %       trailing filesep in destination folder does not matter
            %
            % e.g.,
            % ez.mv('a.txt','folder'), ez.mv('a.txt','folder/a.txt'), ez.mv('a.txt','folder/b.txt')
            % ez.mv('a','b')-->regardless of b exists, a becomes subfolder of b
            %                  use ez.rn('a','b') to change name a->b
            %
            % sources supports wildcards
            % example: ('Projects/my*','../newProjects/')  
            % move files and folders beginning with 'my'
            %
            % http://www.mathworks.com/help/matlab/ref/movefile.html

            vectorization = false;
            % to see whether there is a n*1 cell array input
            for i = 1:nargin
                if strcmp(class(varargin{i}),'cell')
                    vectorization = true;
                    dim = size(varargin{i});
                    if dim(2) ~= 1, error('Input only supports n*1 cell array'); end
                    break;
                end
            end

            if vectorization
                for i = 1:nargin
                    if ~strcmp(class(varargin{i}),'cell')
                        varargin{i} = repmat(cellstr(varargin{i}),dim);
                    end
                end
                % reorganize varargin
                tempParts = [varargin{:}];
                parts = {};
                for i = 1:size(tempParts,1)
                    parts = [parts;{tempParts(i,:)}];
                end
                [varargout{1:nargout}] = cellfun(@(e) ez.mv(e{:}),parts,'UniformOutput',false);
                return;
            end

            from = varargin{1}; to = varargin{2};
            [pathstr, name, ext] = fileparts(to);
            % if to dirlike
            if isempty(ext)
                % if to dir not exist
                if ~isdir(to), mkdir(to); end
            else
                toDir = fileparts(to);
                if isempty(toDir), toDir = pwd(); end
                if ~isdir(toDir), mkdir(toDir); end
            end
            [varargout{1:nargout}] = movefile(varargin{:});
        end

        function varargout = rn(varargin)
            % rn(old, new)
            % to parent folder must exist already; otherwise error
            % old and new cannot be the same, otherwise error
            % note: input could be a n*1 cell array, vectorization supported
            % in case new name exists
            %       if old and new both folders, move old to new as subfolder
            %       if old and new both files, overwrite the new file with old file without prompt
            % ez.rn('a','b')-->rename folder a to folder b
            %
            % http://www.mathworks.com/help/matlab/ref/movefile.html
            
            vectorization = false;
            % to see whether there is a n*1 cell array input
            for i = 1:nargin
                if strcmp(class(varargin{i}),'cell')
                    vectorization = true;
                    dim = size(varargin{i});
                    if dim(2) ~= 1, error('Input only supports n*1 cell array'); end
                    break;
                end
            end

            if vectorization
                for i = 1:nargin
                    if ~strcmp(class(varargin{i}),'cell')
                        varargin{i} = repmat(cellstr(varargin{i}),dim);
                    end
                end
                % reorganize varargin
                tempParts = [varargin{:}];
                parts = {};
                for i = 1:size(tempParts,1)
                    parts = [parts;{tempParts(i,:)}];
                end
                [varargout{1:nargout}] = cellfun(@(e) ez.rn(e{:}),parts,'UniformOutput',false);
                return;
            end

            old = varargin{1}; new = varargin{2};
            [pathstr, name, ext] = fileparts(new);
            % if new dirlike
            if isempty(ext)
                % if new dir exist
                if isdir(new)
                    % error('Cannot rename to exising folder name');
                    [varargout{1:nargout}] = ez.mv(varargin{:});
                else
                    [varargout{1:nargout}] = movefile(varargin{:});
                end
            else
                newDir = fileparts(new);
                if isempty(newDir), newDir = pwd(); end
                if ~isdir(newDir)
                    error('Destination parent folder does not exist')
                else
                    [varargout{1:nargout}] = movefile(varargin{:});
                end
            end
            
        end

        function result = execute(command)
            % execute(command)
            % execute operating system command and returns output
            [status,result] = system(command,'-echo');
        end

        % # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        % # 
        % # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        function Alert(msg)
            % Alert(msg)
            % msg = {'Message line 1';'Message line 2'}
            % modal, script pauses, waiting for response
            uiwait(warndlg(msg,'Alert!','modal'));

            % % no-modal dialogue. script still continues without waiting for user response.
            % % if displaying a second alert without closing the first one, both are shown.
            % warndlg(msg,'Alert!');
        end

        function result = Confirm(msg)
            % Confirm(msg)
            % msg = {'Message line 1';'Message line 2'}
            % returns true (only when Yes pressed) or false (anything else)
            % false does not raise an error (i.e. not like other dlg)
            button = questdlg(msg,'Question?','Yes','No','No');
            switch button
                case 'Yes'
                    result = true;
                otherwise
                    result = false;
            end
            % if (~result); error('MATLAB:UNIQUE:NotEnoughInputs','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function results = Inputs(values, defaults, title)
            % Inputs(values[, defaults, title])
            % Inputs({'x=', 'y='})      Inputs({'x=', 'y='},{'2','2'})
            % {'x=', 'y='}, {'0','0'} <- default Answer must be a cell array of strings.
            % returns a <n x 1 cell array>
            % if the return is {}, raise an error
            if ~exist('defaults','var'); defaults = cell(size(values)); defaults(:)={['']}; end  % defaults(:)={''} also works
            if ~exist('title','var'); title = 'Inputs:'; end
            results = inputdlg(values, title, 1, defaults, 'on');
            if (isempty(results)); error('MATLAB:UNIQUE:NotEnoughInputs','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function result = GetDir(title, path)
            % GetDir([title,path])
            % returns a path string/char
            % path is default path; optional, defaults to current script directory
            % title is optional, the title showing on the dialogue
            % if the return deos not exist, raise an error

            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                csd = fileparts(theStack.file);
            catch
                csd = pwd;
            end

            if ~exist('title','var'); title = 'Select a folder...'; end    
            if ~exist('path','var'); path = csd; end
            result = uigetdir(path,title);
            if isequal(result, 0); result = false; end
            if (~result); error('MATLAB:UNIQUE:NotEnoughInputs','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function [result, pathName] = GetFile(pattern, title, multiple)
            % [result, pathName] = GetFile([pattern[, title, multiple]])
            % 
            % pattern optional, defaults to "all files"
            % pattern = {'*.xls';'*.txt';'*.csv'} or {'*.m'} or '*.*'
            % {'*.m;*.fig;*.mat;*.slx;*.mdl','MATLAB Files (*.m,*.fig,*.mat,*.slx,*.mdl)';
            %  '*.m','Code files (*.m)';
            %  '*.fig','Figures (*.fig)';
            %  '*.mat','MAT-files (*.mat)';
            %  '*.mdl;*.slx','Models (*.slx, *.mdl)';
            %  '*.*','All Files (*.*)'}
            %
            % title is optional, the title showing on the dialogue
            %
            % multiple = 1, 0; optional, default 1 allowing multiple selection
            %
            % returns a nx1 cell with full path to file(s) (one or more than one files selected)
            % if the return is {}, raise an error
            % also optionally returns pathName

            if ~exist('pattern','var')
                pattern = {'*.*','All Files (*.*)'};
            end

            if ~exist('title','var'); title = 'Select file(s)...'; end

            if ~exist('multiple','var')
                multiple = 'on';
            elseif isequal(multiple, 1)
                    multiple = 'on';
            elseif isequal(multiple, 0)
                multiple = 'off';
            end

            [fileName,pathName,filterIndex] = uigetfile(pattern, title, 'MultiSelect', multiple);
            if isequal(fileName, 0)
                result = {};
            else
                if ~iscell(fileName); fileName = {fileName}; end
                % transpose to nx1 cell from 1xn
                fileName = fileName .';
                result = cellfun(@(x) fullfile(pathName,x),fileName, 'UniformOutput', false);
            end
            if (isempty(result)); error('MATLAB:UNIQUE:NotEnoughInputs','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function [result, pathName] = SetFile(defaultFileName, title)
            % [result, pathName] = SetFile([defaultFileName[, title]])
            % saves a file, returns the fullpath string/char
            % defaultFileName, optional, a file name with or without full path
            %    defaults to '' in current script directory
            % title is optional, the title showing on the dialogue
            % if the return does not exist, raise an error
            % also optionally return pathName
            if ~exist('defaultFileName','var'); defaultFileName = ''; end
            if ~exist('title','var'); title = 'Save (as) ...'; end

            %csd
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                csd = fileparts(theStack.file);
            catch
                csd = pwd;
            end

            % if fullpath
            if ~isempty(strfind(defaultFileName, filesep))
                defaultFileName = defaultFileName;
            else
                defaultFileName = fullfile(csd, defaultFileName);
            end
            

            [fileName,pathName,filterIndex] = uiputfile({'*.*','All Files (*.*)'},title,defaultFileName);
            if isequal(fileName, 0)
                result = false;
            else
                result = fullfile(pathName, fileName);
            end
            if (~result); error('MATLAB:UNIQUE:NotEnoughInputs','++++++++++++++++++++++++++++++++++++++++\nUser canceled. Raise error to stop script...\n++++++++++++++++++++++++++++++++++++++++'); end
        end

        function WinTop(fig)
            % toggle figure win (default=gcf) on top
            if ~exist('fig','var'), fig = gcf; end
            isOnTop  = WinOnTop(fig,[]);
            if isOnTop
                WinOnTop(fig, false);
            else
                WinOnTop(fig, true);
            end
        end % end function

        function result = GetVal(baseVarName)
            % get a variable value from base workspace
            % if the variable does not exist, return ''
            try
                result = evalin('base', baseVarName);
            catch
                result = '';
            end
        end

        function cell2csv(csvFile,cellArray)
            % cell2csv(csvFile,cellArray)
            % write the content of a cell array to a csv file, comma separated
            % works with empty cells, numeric, char, string, row vector, and logical cells. 
            % row vector such as [1 2 3] will be separated by two spaces, that is "1  2  3"
            % One array can contain all of them, but only one value per cell.
            cell2csvModified(csvFile,cellArray,',',1997,'.'); %csv,cell,value separator,excel year,decimal point
        end

        function result = csv2cell(csvFile)
            % csv2cell(csvFile)
            % read csv into a cell
            % basically everything defaults to string,  However there are 2 exceptions:
            % 1) if a cell (excel cell not the matlab cell) is like a num, will try to convert to num
            % 2) if a cell (again excel cell) is empty, will be converted to an empty array [], 
            % because I mainly process numbers. could be convienent to concatenate, say [[113 128], []] instead of [[113 128], '']
            % [[113 128], []] returns [113 128] as expected, [[113 128], ''] returns 'q', trying 113 only as ascii code
            % don't care about whether the csv has header or not
            tempResult = csv2cellModified(csvFile,'fromfile');
            result = cellfun(@Numerize, tempResult, 'UniformOutput', false);
            function result = Numerize(x)
                if isempty(str2num(x))
                    if isempty(x), 
                        result = []; 
                    else
                        result = x;
                    end
                else
                    result = str2num(x);
                end % end if
            end % end sub-function    
        end

        function [raw,num,txt] = xls2cell(varargin)
            % [raw,num,txt] = xls2cell(varargin), read XLS, XLSX, XLSM, XLTX, and XLTM into a cell
            % only works on Windows platform with/without Microsoft Excel installed
            % (filename)  % reads data from the first worksheet 
            % (filename,sheet)  % sheet: string | positive integer
            % (filename,xlRange) % xlRange: 'B2:C3', 'B:B'
            % (filename,sheet,xlRange)
            %
            % raw = 
            %     'First'    'Second'    'Third'
            %     [    1]    [     2]    [    3]
            %     [    4]    [     5]    'x'    
            %     [    7]    [     8]    [    9]
            %
            % num =
            %      1     2     3
            %      4     5   NaN
            %      7     8     9
            %
            % txt = 
            %     'First'    'Second'    'Third'
            %     ''         ''          ''     
            %     ''         ''          'x'    
            [num,txt,raw] = xlsread(varargin{:});
        end

        function gmail(email, subject, content, sender, user, pass)
            % e.g. gmail('a@b.com', 'greetings', ['line1' 10 'line2'], 'Sender Name <c@gmail.com>', 'c@gmail.com', 'password');
            setpref('Internet','E_mail',sender);
            setpref('Internet','SMTP_Server','smtp.gmail.com');
            setpref('Internet','SMTP_Username',user);
            setpref('Internet','SMTP_Password',pass);

            props = java.lang.System.getProperties;
            props.setProperty('mail.smtp.auth','true');
            props.setProperty('mail.smtp.socketFactory.class', ...
                              'javax.net.ssl.SSLSocketFactory');
            props.setProperty('mail.smtp.socketFactory.port','465');

            sendmail(email,subject,content);
        end

        function varargout = export(varargin)
            % export the current(last activated) figure in matlab to a file
            %
            % for publication, export as pdf (vector)
            %       export(), export('Fig'), export('Fig.pdf') --> all export as pdf
            %       additionally accepts 'append' to export as a single pdf file
            %       export('Fig.pdf','append') <-- .pdf must be explicitly specified
            %       requires ghostscript
            %           windows/linux users: http://ghostscript.com/download/gsdnld.html
            %           mac users: download at http://pages.uoregon.edu/koch/
            % for viewing, export as jpg
            %       export('Fig.jpg'), 
            %       export('Fig.jpg', 'm2.5', 'q50' ,'a1')
            %       m(magnify relative to the screen dimension), default m1
            %       q(0...100; 100=highest quality, largest filesize)
            %       a(1...4; 4=more anti-alias,larger filesize)
            % filename supports sprintf() if dynamically change names
            % size: adjust the matlab figure size/dimension manually, then export
            % finally, accepts a figure handle(e.g. 1 2 3 etc), defaut to gcf. export('Fig.jpg', 3)
            % if the handle does not exist, use gcf
            %
            % pdf, eps, jpg <-- lossless and lossy compression
            % png, tiff, jpg, bmp (bitmap)  <--magnify, anti-alias
            % pdf, eps, png <-- transparent
            % pdf, tiff <-- append
            %
            % detailed help: https://github.com/ojwoodford/export_fig/blob/master/README.md

            % add the export_fig folder to path which is in the same folder as ez
            addpath(genpath_exclude(fileparts(mfilename('fullpath')),{'^\..*'}));

            if nargin < 1
                % default filename, default filetype is pdf
                varargin = {sprintf('Fig_%s.pdf', datestr(now, 'yyyy-mm-dd_HH-MM-SS-FFF'))};
            elseif nargin == 1
                % if no (or no supported) filetype, make it pdf
                if isempty(regexp(varargin{1},'^.*\.(jpg|jpeg|eps|png|tiff|tif|bmp|pdf)$')), varargin{1} = [varargin{1} '.pdf']; end
            else
                % prepend '-' to parameters if no -
                varargin(2:end) = cellfun(@(x) TheParser(x), varargin(2:end), 'UniformOutput', false);
            end
            % celldisp(varargin) % debug
            [varargout{1:nargout}] = export_fig(varargin{:}); 

            function y = TheParser(x)
                if ischar(x) & x(1) ~= '-'
                    y = ['-' x]; 
                else
                    y = x;
                end
            end % end subfunction
        end

        function varargout = capture(varargin)
            % launch FastStone Capture (the last freeware version (v5.3)), Windows OS only
            % & = background running, matlab continues processing
            system([fileparts(mfilename('fullpath')) '\fscapture\FSCapture.exe &']);
        end

        % if matlab version >= 7.14 (2012a), add 'legacy' to the parameters, otherwise not
        % this way, maintain cross-matlab version compatability
        function varargout = unique(varargin)
            % backward compatibility: unique, union, ismember, setdiff, intersect, setxor
            % all results with no repetitions, result sorted
            % setdiff(a,b) returns items in a but not in b
            % setxor(a,b) returns items  not in intersect(a,b)
            % ismember returns an array of 0/1, see more "help ismember"
            varargin = legacize(varargin);
            [varargout{1:nargout}] = unique(varargin{:}); 
        end

        function varargout = union(varargin)
            % backward compatibility: unique, union, ismember, setdiff, intersect, setxor
            % all results with no repetitions, result sorted
            % setdiff(a,b) returns items in a but not in b
            % setxor(a,b) returns items  not in intersect(a,b)
            % ismember returns an array of 0/1, see more "help ismember"
            varargin = legacize(varargin);
            [varargout{1:nargout}] = union(varargin{:}); 
        end

        function varargout = ismember(varargin)
            % backward compatibility: unique, union, ismember, setdiff, intersect, setxor
            % all results with no repetitions, result sorted
            % setdiff(a,b) returns items in a but not in b
            % setxor(a,b) returns items  not in intersect(a,b)
            % ismember returns an array of 0/1, see more "help ismember"            
            varargin = legacize(varargin);
            [varargout{1:nargout}] = ismember(varargin{:}); 
        end

         function varargout = setdiff(varargin)
            % backward compatibility: unique, union, ismember, setdiff, intersect, setxor
            % all results with no repetitions, result sorted
            % setdiff(a,b) returns items in a but not in b
            % setxor(a,b) returns items  not in intersect(a,b)
            % ismember returns an array of 0/1, see more "help ismember"            
            varargin = legacize(varargin);
            [varargout{1:nargout}] = setdiff(varargin{:}); 
        end

        function varargout = intersect(varargin)
            % backward compatibility: unique, union, ismember, setdiff, intersect, setxor
            % all results with no repetitions, result sorted
            % setdiff(a,b) returns items in a but not in b
            % setxor(a,b) returns items  not in intersect(a,b)
            % ismember returns an array of 0/1, see more "help ismember"            
            varargin = legacize(varargin);
            [varargout{1:nargout}] = intersect(varargin{:}); 
        end

        function varargout = setxor(varargin)
            % backward compatibility: unique, union, ismember, setdiff, intersect, setxor
            % all results with no repetitions, result sorted
            % setdiff(a,b) returns items in a but not in b
            % setxor(a,b) returns items  not in intersect(a,b)
            % ismember returns an array of 0/1, see more "help ismember"            
            varargin = legacize(varargin);
            [varargout{1:nargout}] = setxor(varargin{:}); 
        end

        function result = compare(S1, S2)
            % result = compare(S1, S2) returns 0/1
            % compare two structures and print out reports
            % notice: the compare will treat value of '' [] (though both empty) as different
            %         The order in which the fields of each structure were created will be ignored
            result = structcmp(S1,S2,'report','on','EqualNans','on','IgnoreSorting','on','IsRecursiveCall','no');
        end

        function result = expand(C)
            % expand(C) expands a cell or structure to display its content
            if strcmp(class(C),'cell')
                celldisp(C);
            else
                fn_structdisp(C);
            end
        end

        function tf = AreTheseToolboxesInstalled(requiredToolboxes)
        %ARETHESETOOLBOXESINSTALLED takes a cell array of toolbox names and checks whether they are currently installed
        % SYNOPSIS tf = AreTheseToolboxesInstalled(requiredToolboxes)
        %
        % INPUT requiredToolboxes: cell array with toolbox names to test for. Eg. 
        %        {'MATLAB','Image Processing Toolbox'}
        %
        % OUTPUT tf: true or false if the required toolboxes are installed or not
        %%%%%%%%%%%%%%%%%%%%%%%%%%

        % get all installed toolbox names
        v = ver;
        % collect the names in a cell array
        [installedToolboxes{1:length(v)}] = deal(v.Name);

        % check 
        tf = all(ismember(requiredToolboxes,installedToolboxes));

        % print out
        if tf
            disp('Congratulations, all required Matlab toolbox(es) installed!');
        else
            cprintf('red', 'Oops, at least one of the following requried Matlab toolboxes is not installed:\n')
            fprintf('-----------------------------------------\n');
            fprintf('%s\n', requiredToolboxes{:});
            fprintf('-----------------------------------------\n');
            disp('You can type ''ver'' to see what you have installed.');
        end
        end % end function

    % leave a blank line before this
    end % end static methods
end % end class


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


% credits: http://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-the-command-window
function count = cprintf(style,format,varargin)
% CPRINTF displays styled formatted text in the Command Window
%
% Syntax:
%    count = cprintf(style,format,...)
%
% Description:
%    CPRINTF processes the specified text using the exact same FORMAT
%    arguments accepted by the built-in SPRINTF and FPRINTF functions.
%
%    CPRINTF then displays the text in the Command Window using the
%    specified STYLE argument. The accepted styles are those used for
%    Matlab's syntax highlighting (see: File / Preferences / Colors / 
%    M-file Syntax Highlighting Colors), and also user-defined colors.
%
%    The possible pre-defined STYLE names are:
%
%       'Text'                 - default: black
%       'Keywords'             - default: blue
%       'Comments'             - default: green
%       'Strings'              - default: purple
%       'UnterminatedStrings'  - default: dark red
%       'SystemCommands'       - default: orange
%       'Errors'               - default: light red
%       'Hyperlinks'           - default: underlined blue
%
%       'Black','Cyan','Magenta','Blue','Green','Red','Yellow','White'
%
%    STYLE beginning with '-' or '_' will be underlined. For example:
%          '-Blue' is underlined blue, like 'Hyperlinks';
%          '_Comments' is underlined green etc.
%
%    STYLE beginning with '*' will be bold (R2011b+ only). For example:
%          '*Blue' is bold blue;
%          '*Comments' is bold green etc.
%    Note: Matlab does not currently support both bold and underline,
%          only one of them can be used in a single cprintf command. But of
%          course bold and underline can be mixed by using separate commands.
%
%    STYLE also accepts a regular Matlab RGB vector, that can be underlined
%    and bolded: -[0,1,1] means underlined cyan, '*[1,0,0]' is bold red.
%
%    STYLE is case-insensitive and accepts unique partial strings just
%    like handle property names.
%
%    CPRINTF by itself, without any input parameters, displays a demo
%
% Example:
%    cprintf;   % displays the demo
%    cprintf('text',   'regular black text');
%    cprintf('hyper',  'followed %s','by');
%    cprintf('key',    '%d colored', 4);
%    cprintf('-comment','& underlined');
%    cprintf('err',    'elements\n');
%    cprintf('cyan',   'cyan');
%    cprintf('_green', 'underlined green');
%    cprintf(-[1,0,1], 'underlined magenta');
%    cprintf([1,0.5,0],'and multi-\nline orange\n');
%    cprintf('*blue',  'and *bold* (R2011b+ only)\n');
%    cprintf('string');  % same as fprintf('string') and cprintf('text','string')
%
% Bugs and suggestions:
%    Please send to Yair Altman (altmany at gmail dot com)
%
% Warning:
%    This code heavily relies on undocumented and unsupported Matlab
%    functionality. It works on Matlab 7+, but use at your own risk!
%
%    A technical description of the implementation can be found at:
%    <a href="http://undocumentedmatlab.com/blog/cprintf/">http://UndocumentedMatlab.com/blog/cprintf/</a>
%
% Limitations:
%    1. In R2011a and earlier, a single space char is inserted at the
%       beginning of each CPRINTF text segment (this is ok in R2011b+).
%
%    2. In R2011a and earlier, consecutive differently-colored multi-line
%       CPRINTFs sometimes display incorrectly on the bottom line.
%       As far as I could tell this is due to a Matlab bug. Examples:
%         >> cprintf('-str','under\nline'); cprintf('err','red\n'); % hidden 'red', unhidden '_'
%         >> cprintf('str','regu\nlar'); cprintf('err','red\n'); % underline red (not purple) 'lar'
%
%    3. Sometimes, non newline ('\n')-terminated segments display unstyled
%       (black) when the command prompt chevron ('>>') regains focus on the
%       continuation of that line (I can't pinpoint when this happens). 
%       To fix this, simply newline-terminate all command-prompt messages.
%
%    4. In R2011b and later, the above errors appear to be fixed. However,
%       the last character of an underlined segment is not underlined for
%       some unknown reason (add an extra space character to make it look better)
%
%    5. In old Matlab versions (e.g., Matlab 7.1 R14), multi-line styles
%       only affect the first line. Single-line styles work as expected.
%       R14 also appends a single space after underlined segments.
%
%    6. Bold style is only supported on R2011b+, and cannot also be underlined.
%
% Change log:
%    2012-08-09: Graceful degradation support for deployed (compiled) and non-desktop applications; minor bug fixes
%    2012-08-06: Fixes for R2012b; added bold style; accept RGB string (non-numeric) style
%    2011-11-27: Fixes for R2011b
%    2011-08-29: Fix by Danilo (FEX comment) for non-default text colors
%    2011-03-04: Performance improvement
%    2010-06-27: Fix for R2010a/b; fixed edge case reported by Sharron; CPRINTF with no args runs the demo
%    2009-09-28: Fixed edge-case problem reported by Swagat K
%    2009-05-28: corrected nargout behavior sugegsted by Andreas Gäb
%    2009-05-13: First version posted on <a href="http://www.mathworks.com/matlabcentral/fileexchange/authors/27420">MathWorks File Exchange</a>
%
% See also:
%    sprintf, fprintf

% License to use and modify this code is granted freely to all interested, as long as the original author is
% referenced and attributed as such. The original author maintains the right to be solely associated with this work.

% Programmed and Copyright by Yair M. Altman: altmany(at)gmail.com
% $Revision: 1.08 $  $Date: 2012/10/17 21:41:09 $

  persistent majorVersion minorVersion
  if isempty(majorVersion)
      %v = version; if str2double(v(1:3)) <= 7.1
      %majorVersion = str2double(regexprep(version,'^(\d+).*','$1'));
      %minorVersion = str2double(regexprep(version,'^\d+\.(\d+).*','$1'));
      %[a,b,c,d,versionIdStrs]=regexp(version,'^(\d+)\.(\d+).*');  %#ok unused
      v = sscanf(version, '%d.', 2);
      majorVersion = v(1); %str2double(versionIdStrs{1}{1});
      minorVersion = v(2); %str2double(versionIdStrs{1}{2});
  end

  % The following is for debug use only:
  %global docElement txt el
  if ~exist('el','var') || isempty(el),  el=handle([]);  end  %#ok mlint short-circuit error ("used before defined")
  if nargin<1, showDemo(majorVersion,minorVersion); return;  end
  if isempty(style),  return;  end
  if all(ishandle(style)) && length(style)~=3
      dumpElement(style);
      return;
  end

  % Process the text string
  if nargin<2, format = style; style='text';  end
  %error(nargchk(2, inf, nargin, 'struct'));
  %str = sprintf(format,varargin{:});

  % In compiled mode
  try useDesktop = usejava('desktop'); catch, useDesktop = false; end
  if isdeployed | ~useDesktop %#ok<OR2> - for Matlab 6 compatibility
      % do not display any formatting - use simple fprintf()
      % See: http://undocumentedmatlab.com/blog/bold-color-text-in-the-command-window/#comment-103035
      % Also see: https://mail.google.com/mail/u/0/?ui=2&shva=1#all/1390a26e7ef4aa4d
      % Also see: https://mail.google.com/mail/u/0/?ui=2&shva=1#all/13a6ed3223333b21
      count1 = fprintf(format,varargin{:});
  else
      % Else (Matlab desktop mode)
      % Get the normalized style name and underlining flag
      [underlineFlag, boldFlag, style] = processStyleInfo(style);

      % Set hyperlinking, if so requested
      if underlineFlag
          format = ['<a href="">' format '</a>'];

          % Matlab 7.1 R14 (possibly a few newer versions as well?)
          % have a bug in rendering consecutive hyperlinks
          % This is fixed by appending a single non-linked space
          if majorVersion < 7 || (majorVersion==7 && minorVersion <= 1)
              format(end+1) = ' ';
          end
      end

      % Set bold, if requested and supported (R2011b+)
      if boldFlag
          if (majorVersion > 7 || minorVersion >= 13)
              format = ['<strong>' format '</strong>'];
          else
              boldFlag = 0;
          end
      end

      % Get the current CW position
      cmdWinDoc = com.mathworks.mde.cmdwin.CmdWinDocument.getInstance;
      lastPos = cmdWinDoc.getLength;

      % If not beginning of line
      bolFlag = 0;  %#ok
      %if docElement.getEndOffset - docElement.getStartOffset > 1
          % Display a hyperlink element in order to force element separation
          % (otherwise adjacent elements on the same line will be merged)
          if majorVersion<7 || (majorVersion==7 && minorVersion<13)
              if ~underlineFlag
                  fprintf('<a href=""> </a>');  %fprintf('<a href=""> </a>\b');
              elseif format(end)~=10  % if no newline at end
                  fprintf(' ');  %fprintf(' \b');
              end
          end
          %drawnow;
          bolFlag = 1;
      %end

      % Get a handle to the Command Window component
      mde = com.mathworks.mde.desk.MLDesktop.getInstance;
      cw = mde.getClient('Command Window');
      xCmdWndView = cw.getComponent(0).getViewport.getComponent(0);

      % Store the CW background color as a special color pref
      % This way, if the CW bg color changes (via File/Preferences), 
      % it will also affect existing rendered strs
      com.mathworks.services.Prefs.setColorPref('CW_BG_Color',xCmdWndView.getBackground);

      % Display the text in the Command Window
      count1 = fprintf(2,format,varargin{:});

      %awtinvoke(cmdWinDoc,'remove',lastPos,1);   % TODO: find out how to remove the extra '_'
      drawnow;  % this is necessary for the following to work properly (refer to Evgeny Pr in FEX comment 16/1/2011)
      docElement = cmdWinDoc.getParagraphElement(lastPos+1);
      if majorVersion<7 || (majorVersion==7 && minorVersion<13)
          if bolFlag && ~underlineFlag
              % Set the leading hyperlink space character ('_') to the bg color, effectively hiding it
              % Note: old Matlab versions have a bug in hyperlinks that need to be accounted for...
              %disp(' '); dumpElement(docElement)
              setElementStyle(docElement,'CW_BG_Color',1+underlineFlag,majorVersion,minorVersion); %+getUrlsFix(docElement));
              %disp(' '); dumpElement(docElement)
              el(end+1) = handle(docElement);  %#ok used in debug only
          end

          % Fix a problem with some hidden hyperlinks becoming unhidden...
          fixHyperlink(docElement);
          %dumpElement(docElement);
      end

      % Get the Document Element(s) corresponding to the latest fprintf operation
      while docElement.getStartOffset < cmdWinDoc.getLength
          % Set the element style according to the current style
          %disp(' '); dumpElement(docElement)
          specialFlag = underlineFlag | boldFlag;
          setElementStyle(docElement,style,specialFlag,majorVersion,minorVersion);
          %disp(' '); dumpElement(docElement)
          docElement2 = cmdWinDoc.getParagraphElement(docElement.getEndOffset+1);
          if isequal(docElement,docElement2),  break;  end
          docElement = docElement2;
          %disp(' '); dumpElement(docElement)
      end

      % Force a Command-Window repaint
      % Note: this is important in case the rendered str was not '\n'-terminated
      xCmdWndView.repaint;

      % The following is for debug use only:
      el(end+1) = handle(docElement);  %#ok used in debug only
      %elementStart  = docElement.getStartOffset;
      %elementLength = docElement.getEndOffset - elementStart;
      %txt = cmdWinDoc.getText(elementStart,elementLength);
  end

  if nargout
      count = count1;
  end
  return;  % debug breakpoint
end

% Process the requested style information
function [underlineFlag,boldFlag,style] = processStyleInfo(style)
  underlineFlag = 0;
  boldFlag = 0;

  % First, strip out the underline/bold markers
  if ischar(style)
      % Styles containing '-' or '_' should be underlined (using a no-target hyperlink hack)
      %if style(1)=='-'
      underlineIdx = (style=='-') | (style=='_');
      if any(underlineIdx)
          underlineFlag = 1;
          %style = style(2:end);
          style = style(~underlineIdx);
      end

      % Check for bold style (only if not underlined)
      boldIdx = (style=='*');
      if any(boldIdx)
          boldFlag = 1;
          style = style(~boldIdx);
      end
      if underlineFlag && boldFlag
          warning('YMA:cprintf:BoldUnderline','Matlab does not support both bold & underline')
      end

      % Check if the remaining style sting is a numeric vector
      %styleNum = str2num(style); %#ok<ST2NM>  % not good because style='text' is evaled!
      %if ~isempty(styleNum)
      if any(style==' ' | style==',' | style==';')
          style = str2num(style); %#ok<ST2NM>
      end
  end

  % Style = valid matlab RGB vector
  if isnumeric(style) && length(style)==3 && all(style<=1) && all(abs(style)>=0)
      if any(style<0)
          underlineFlag = 1;
          style = abs(style);
      end
      style = getColorStyle(style);

  elseif ~ischar(style)
      error('YMA:cprintf:InvalidStyle','Invalid style - see help section for a list of valid style values')

  % Style name
  else
      % Try case-insensitive partial/full match with the accepted style names
      validStyles = {'Text','Keywords','Comments','Strings','UnterminatedStrings','SystemCommands','Errors', ...
                     'Black','Cyan','Magenta','Blue','Green','Red','Yellow','White', ...
                     'Hyperlinks'};
      matches = find(strncmpi(style,validStyles,length(style)));

      % No match - error
      if isempty(matches)
          error('YMA:cprintf:InvalidStyle','Invalid style - see help section for a list of valid style values')

      % Too many matches (ambiguous) - error
      elseif length(matches) > 1
          error('YMA:cprintf:AmbigStyle','Ambiguous style name - supply extra characters for uniqueness')

      % Regular text
      elseif matches == 1
          style = 'ColorsText';  % fixed by Danilo, 29/8/2011

      % Highlight preference style name
      elseif matches < 8
          style = ['Colors_M_' validStyles{matches}];

      % Color name
      elseif matches < length(validStyles)
          colors = [0,0,0; 0,1,1; 1,0,1; 0,0,1; 0,1,0; 1,0,0; 1,1,0; 1,1,1];
          requestedColor = colors(matches-7,:);
          style = getColorStyle(requestedColor);

      % Hyperlink
      else
          style = 'Colors_HTML_HTMLLinks';  % CWLink
          underlineFlag = 1;
      end
  end
end

% Convert a Matlab RGB vector into a known style name (e.g., '[255,37,0]')
function styleName = getColorStyle(rgb)
  intColor = int32(rgb*255);
  javaColor = java.awt.Color(intColor(1), intColor(2), intColor(3));
  styleName = sprintf('[%d,%d,%d]',intColor);
  com.mathworks.services.Prefs.setColorPref(styleName,javaColor);
end

% Fix a bug in some Matlab versions, where the number of URL segments
% is larger than the number of style segments in a doc element
function delta = getUrlsFix(docElement)  %#ok currently unused
  tokens = docElement.getAttribute('SyntaxTokens');
  links  = docElement.getAttribute('LinkStartTokens');
  if length(links) > length(tokens(1))
      delta = length(links) > length(tokens(1));
  else
      delta = 0;
  end
end

% fprintf(2,str) causes all previous '_'s in the line to become red - fix this
function fixHyperlink(docElement)
  try
      tokens = docElement.getAttribute('SyntaxTokens');
      urls   = docElement.getAttribute('HtmlLink');
      urls   = urls(2);
      links  = docElement.getAttribute('LinkStartTokens');
      offsets = tokens(1);
      styles  = tokens(2);
      doc = docElement.getDocument;

      % Loop over all segments in this docElement
      for idx = 1 : length(offsets)-1
          % If this is a hyperlink with no URL target and starts with ' ' and is collored as an error (red)...
          if strcmp(styles(idx).char,'Colors_M_Errors')
              character = char(doc.getText(offsets(idx)+docElement.getStartOffset,1));
              if strcmp(character,' ')
                  if isempty(urls(idx)) && links(idx)==0
                      % Revert the style color to the CW background color (i.e., hide it!)
                      styles(idx) = java.lang.String('CW_BG_Color');
                  end
              end
          end
      end
  catch
      % never mind...
  end
end

% Set an element to a particular style (color)
function setElementStyle(docElement,style,specialFlag, majorVersion,minorVersion)
  %global tokens links urls urlTargets  % for debug only
  global oldStyles
  if nargin<3,  specialFlag=0;  end
  % Set the last Element token to the requested style:
  % Colors:
  tokens = docElement.getAttribute('SyntaxTokens');
  try
      styles = tokens(2);
      oldStyles{end+1} = styles.cell;

      % Correct edge case problem
      extraInd = double(majorVersion>7 || (majorVersion==7 && minorVersion>=13));  % =0 for R2011a-, =1 for R2011b+
      %{
      if ~strcmp('CWLink',char(styles(end-hyperlinkFlag))) && ...
          strcmp('CWLink',char(styles(end-hyperlinkFlag-1)))
         extraInd = 0;%1;
      end
      hyperlinkFlag = ~isempty(strmatch('CWLink',tokens(2)));
      hyperlinkFlag = 0 + any(cellfun(@(c)(~isempty(c)&&strcmp(c,'CWLink')),tokens(2).cell));
      %}

      styles(end-extraInd) = java.lang.String('');
      styles(end-extraInd-specialFlag) = java.lang.String(style);  %#ok apparently unused but in reality used by Java
      if extraInd
          styles(end-specialFlag) = java.lang.String(style);
      end

      oldStyles{end} = [oldStyles{end} styles.cell];
  catch
      % never mind for now
  end
  
  % Underlines (hyperlinks):
  %{
  links = docElement.getAttribute('LinkStartTokens');
  if isempty(links)
      %docElement.addAttribute('LinkStartTokens',repmat(int32(-1),length(tokens(2)),1));
  else
      %TODO: remove hyperlink by setting the value to -1
  end
  %}

  % Correct empty URLs to be un-hyperlinkable (only underlined)
  urls = docElement.getAttribute('HtmlLink');
  if ~isempty(urls)
      urlTargets = urls(2);
      for urlIdx = 1 : length(urlTargets)
          try
              if urlTargets(urlIdx).length < 1
                  urlTargets(urlIdx) = [];  % '' => []
              end
          catch
              % never mind...
              a=1;  %#ok used for debug breakpoint...
          end
      end
  end
  
  % Bold: (currently unused because we cannot modify this immutable int32 numeric array)
  %{
  try
      %hasBold = docElement.isDefined('BoldStartTokens');
      bolds = docElement.getAttribute('BoldStartTokens');
      if ~isempty(bolds)
          %docElement.addAttribute('BoldStartTokens',repmat(int32(1),length(bolds),1));
      end
  catch
      % never mind - ignore...
      a=1;  %#ok used for debug breakpoint...
  end
  %}
  
  return;  % debug breakpoint
end

% Display information about element(s)
function dumpElement(docElements)
  %return;
  numElements = length(docElements);
  cmdWinDoc = docElements(1).getDocument;
  for elementIdx = 1 : numElements
      if numElements > 1,  fprintf('Element #%d:\n',elementIdx);  end
      docElement = docElements(elementIdx);
      if ~isjava(docElement),  docElement = docElement.java;  end
      %docElement.dump(java.lang.System.out,1)
      disp(' ');
      disp(docElement)
      tokens = docElement.getAttribute('SyntaxTokens');
      if isempty(tokens),  continue;  end
      links = docElement.getAttribute('LinkStartTokens');
      urls  = docElement.getAttribute('HtmlLink');
      try bolds = docElement.getAttribute('BoldStartTokens'); catch, bolds = []; end
      txt = {};
      tokenLengths = tokens(1);
      for tokenIdx = 1 : length(tokenLengths)-1
          tokenLength = diff(tokenLengths(tokenIdx+[0,1]));
          if (tokenLength < 0)
              tokenLength = docElement.getEndOffset - docElement.getStartOffset - tokenLengths(tokenIdx);
          end
          txt{tokenIdx} = cmdWinDoc.getText(docElement.getStartOffset+tokenLengths(tokenIdx),tokenLength).char;  %#ok
      end
      lastTokenStartOffset = docElement.getStartOffset + tokenLengths(end);
      txt{end+1} = cmdWinDoc.getText(lastTokenStartOffset, docElement.getEndOffset-lastTokenStartOffset).char;  %#ok
      %cmdWinDoc.uiinspect
      %docElement.uiinspect
      txt = strrep(txt',sprintf('\n'),'\n');
      try
          data = [tokens(2).cell m2c(tokens(1)) m2c(links) m2c(urls(1)) cell(urls(2)) m2c(bolds) txt];
          if elementIdx==1
              disp('    SyntaxTokens(2,1) - LinkStartTokens - HtmlLink(1,2) - BoldStartTokens - txt');
              disp('    ==============================================================================');
          end
      catch
          try
              data = [tokens(2).cell m2c(tokens(1)) m2c(links) txt];
          catch
              disp([tokens(2).cell m2c(tokens(1)) txt]);
              try
                  data = [m2c(links) m2c(urls(1)) cell(urls(2))];
              catch
                  % Mtlab 7.1 only has urls(1)...
                  data = [m2c(links) urls.cell];
              end
          end
      end
      disp(data)
  end
end

% Utility function to convert matrix => cell
function cells = m2c(data)
  %datasize = size(data);  cells = mat2cell(data,ones(1,datasize(1)),ones(1,datasize(2)));
  cells = num2cell(data);
end

% Display the help and demo
function showDemo(majorVersion,minorVersion)
  fprintf('cprintf displays formatted text in the Command Window.\n\n');
  fprintf('Syntax: count = cprintf(style,format,...);  click <a href="matlab:help cprintf">here</a> for details.\n\n');
  url = 'http://UndocumentedMatlab.com/blog/cprintf/';
  fprintf(['Technical description: <a href="' url '">' url '</a>\n\n']);
  fprintf('Demo:\n\n');
  boldFlag = majorVersion>7 || (majorVersion==7 && minorVersion>=13);
  s = ['cprintf(''text'',    ''regular black text'');' 10 ...
       'cprintf(''hyper'',   ''followed %s'',''by'');' 10 ...
       'cprintf(''key'',     ''%d colored'',' num2str(4+boldFlag) ');' 10 ...
       'cprintf(''-comment'',''& underlined'');' 10 ...
       'cprintf(''err'',     ''elements:\n'');' 10 ...
       'cprintf(''cyan'',    ''cyan'');' 10 ...
       'cprintf(''_green'',  ''underlined green'');' 10 ...
       'cprintf(-[1,0,1],  ''underlined magenta'');' 10 ...
       'cprintf([1,0.5,0], ''and multi-\nline orange\n'');' 10];
   if boldFlag
       % In R2011b+ the internal bug that causes the need for an extra space
       % is apparently fixed, so we must insert the sparator spaces manually...
       % On the other hand, 2011b enables *bold* format
       s = [s 'cprintf(''*blue'',   ''and *bold* (R2011b+ only)\n'');' 10];
       s = strrep(s, ''')',' '')');
       s = strrep(s, ''',5)',' '',5)');
       s = strrep(s, '\n ','\n');
   end
   disp(s);
   eval(s);
end

%%%%%%%%%%%%%%%%%%%%%%%%%% TODO %%%%%%%%%%%%%%%%%%%%%%%%%
% - Fix: Remove leading space char (hidden underline '_')
% - Fix: Find workaround for multi-line quirks/limitations
% - Fix: Non-\n-terminated segments are displayed as black
% - Fix: Check whether the hyperlink fix for 7.1 is also needed on 7.2 etc.
% - Enh: Add font support
%%%%%%%%%%%%%%%%%%%%%%%%%% End %%%%%%%%%%%%%%%%%%%%%%%%%


function cell2csvModified(fileName, cellArray, separator, excelYear, decimal)
% % Writes cell array content into a *.csv file.
% % 
% % CELL2CSV(fileName, cellArray[, separator, excelYear, decimal])
% %
% % fileName     = Name of the file to save. [ e.g. 'text.csv' ]
% % cellArray    = Name of the Cell Array where the data is in
% % 
% % optional:
% % separator    = sign separating the values (default = ',')
% % excelYear    = depending on the Excel version, the cells are put into
% %                quotes before they are written to the file. The separator
% %                is set to semicolon (;)  (default = 1997 which does not change separator to semicolon ;)
% % decimal      = defines the decimal separator (default = '.')
% %
% %         by Sylvain Fiedler, KA, 2004
% % updated by Sylvain Fiedler, Metz, 06
% % fixed the logical-bug, Kaiserslautern, 06/2008, S.Fiedler
% % added the choice of decimal separator, 11/2010, S.Fiedler
% %
% % modfiedy and optimized by Jerry Zhu, June, 2014, jerryzhujian9@gmail.com
% % now works with empty cells, numeric, char, string, row vector, and logical cells. 
% % row vector such as [1 2 3] will be separated by two spaces, that is "1  2  3"
% % other types will be converted to the string "NA".
% % One array can contain all of them, but only one value per cell.
% % 2x times faster than Sylvain's codes (8.8s vs. 17.2s):
% % tic;C={'te','tm';5,[1,2];true,{}};C=repmat(C,[10000,1]);cell2csv([datestr(now,'MMSS') '.csv'],C);toc;

%% Checking for optional Variables
if ~exist('separator', 'var')
    separator = ',';
end

if ~exist('excelYear', 'var')
    excelYear = 1997;
end

if ~exist('decimal', 'var')
    decimal = '.';
end

%% Setting separator for newer excelYears
if excelYear > 2000
    separator = ';';
end

% convert cell
cellArray = cellfun(@Stringize, cellArray, 'UniformOutput', false);

% Write file
datei = fopen(fileName, 'w');
[nrows,ncols] = size(cellArray);
for row = 1:nrows
    fprintf(datei,[sprintf(['%s' separator],cellArray{row,1:ncols-1}) cellArray{row,ncols} '\n']);
end    
% Close file
fclose(datei);

% sub-function
function result = Stringize(x)
    % empty element
    if isempty(x)
        result = '';
    % If numeric -> String, e.g. 1, [1 2]
    elseif isnumeric(x) && isrow(x)
        result = num2str(x);
        if decimal ~= '.'
            result = strrep(result, '.', decimal);
        end
    % If logical -> 'true' or 'false'
    elseif islogical(x)
        if x == 1
            result = 'TRUE';
        else
            result = 'FALSE';
        end
    % If matrix array -> a1 a2 a3. e.g. [1 2 3]
    % row vector such as [1 2 3] will be separated by two spaces, that is "1 2 3" 
    % also catch string or char here
    elseif isrow(x) && ~iscell(x)
        result = num2str(x);
    % everthing else, such as [1;2], {1}
    else
        result = 'NA';
    end

    % If newer version of Excel -> Quotes 4 Strings
    if excelYear > 2000
        result = ['"' x '"'];
    end
end % end sub-function
end % end function


function data = csv2cellModified(varargin)
% http://www.mathworks.com/matlabcentral/fileexchange/20836-csv2cell
% CSV2CELL - parses a Windows CSV file into an NxM cell array, where N is
% the number of lines in the CSV text and M is the number of fields in the
% longest line of the CSV file. Lines are delimited by carriage returns
% and/or newlines.
%
% A Windows CSV file format allows for commas (,) and double quotes (") to
% be contained within fields of the CSV file. Regular fields are just text
% separated by commas (e.g. foo,bar,hello world). Fields containing commas
% or double quotes are surrounded by double quotes (e.g.
% foo,bar,"item1,item2,item3",hello world). In the previous example,
% "item1,item2,item3" is one field in the CSV text. For double quotes to be
% represented, they are written in pairs in the file, and contained within
% a quoted field, (e.g. foo,"this field contains ""quotes""",bar). Spaces
% within fields (even leading and trailing) are preserved.
%
% All fields from the CSV file are returned as strings. If the CSV text
% contains lines with different numbers of fields, then the "missing"
% fields with appear as empty arrays, [], in the returned data. You can
% easily convert the data you expect to be numeric using str2num() and
% num2cell(). 
%
% Examples:
%  >> csv2cell('foo.csv','fromfile') % loads and parses entire file
%  >> csv2cell(',,,') % returns cell array {'','','',''}
%  >> csv2cell(',,,','text') % same as above, declaring text input
%  >> csv2cell(sprintf('%s\r\n%s',...
%     '"Ten Thousand",10000,,"10,000","""It''s ""10 Grand"", baby",10k',...
%     ',foo,bar,soo'))
%  ans = 
%    'Ten Thousand'    '10000'       ''    '10,000'    [1x22 char]    '10k'
%                ''    'foo'      'bar'    'soo'                []       []
%  >> % note the two empty [] cells, because the second line has two fewer
%  >> % fields than the first. The empty field '' at the beginning of the
%  >> % second line is due to the leading comma on that line, which is
%  >> % correct behavior. A trailing comma will do the same to the end of a
%  >> % line.
% 
% Limitations/Exceptions:
%   * This code is untested on large files. It may take a long time due to
%   variables growing inside loops (yes, poor practice, but easy coding).
%   * This code has been minimally tested to work with a variety of weird
%   Excel files that I have.
%   * Behavior with improperly formatted CSV files is untested.
%   * Technically, CSV files from Excel always separate lines with the pair
%   of characters \r\n. This parser will also separate lines that have only
%   \r or \n as line terminators. 
%   * Line separation is the first operation. I don't think the Excel CSV
%   format has any allowance for newlines or carriage returns within
%   fields. If it does, then this parser does not support it and would not
%   return bad output.
%
% Copyright 2008 Arthur Hebert

% Process arguments
if nargin == 1
    text = varargin{1};
elseif nargin == 2
    switch varargin{2}
        case 'fromfile'
            filename = varargin{1};
            fid = fopen(filename);
            text = char(fread(fid))';
            fclose(fid);
        case 'text'
            text = varargin{1};
        otherwise
            error('Invalid 2nd argument %s. Valid options are ''fromfile'' and ''text''',varargin{2})
    end
else
    error('CSV2CELL requires 1 or 2 arguments.')
end


% First split it into lines
lines = regexp(text,'(\r\n|[\r\n])','split'); % lines should now be a cell array of text split by newlines

% a character is either a delimiter or a field
inField = true;
inQuoteField = false;
% if inField && ~inQuoteField --> then we're in a raw field

skipNext = false;
data = {};
field = '';
for lineNumber = 1:length(lines)
    nChars = length(lines{lineNumber}); % number of characters in this line
    fieldNumber = 1;
    for charNumber = 1:nChars
        if skipNext
            skipNext = false;
            continue
        end
        thisChar = lines{lineNumber}(charNumber);
        if thisChar == ','
            if inField 
                if inQuoteField % this comma is part of the field
                    field(end+1) = thisChar;
                else % this comma is the delimiter marking the end of the field
                    data{lineNumber,fieldNumber} = field;
                    field = '';
                    fieldNumber = fieldNumber + 1;
                end
            else % we are not currently in a field -- this is the start of a new delimiter
                inField = true;
            end
            if charNumber == nChars % this is a hanging comma, indicating the last field is blank
                data{lineNumber,fieldNumber} = '';
                field = '';
                fieldNumber = fieldNumber + 1;
            end
        elseif thisChar == '"' 
            if inField
                if inQuoteField
                    if charNumber == nChars % it's the last character, so this must be the closing delimiter?
                        inField = false;
                        inQuoteField = false;
                        data{lineNumber,fieldNumber} = field;
                        field = '';
                        fieldNumber = fieldNumber + 1;
                    else 
                        if lines{lineNumber}(charNumber+1) == '"' % this is translated to be a double quote in the field
                            field(end+1) = '"';
                            skipNext = true;
                        else % this " is the delimiter ending this field
                            data{lineNumber,fieldNumber} = field;
                            field = '';
                            inField = false;
                            inQuoteField = false;
                            fieldNumber = fieldNumber + 1;
                        end
                    end
                else % this is a delimiter and we are in a new quote field
                    inQuoteField = true;
                end
            else % we are not in a field. This must be an opening quote for the first field?
                inField = true;
                inQuoteField = true;
            end
        else % any other character ought to be added to field
            field(end+1) = thisChar;
            if charNumber == nChars
                data{lineNumber,fieldNumber} = field;
                field = '';
                fieldNumber = fieldNumber + 1;
            elseif charNumber == 1 % we are starting a new raw field
                inField = true;
            end
        end
    end
end
end % end function


function p = genpath_exclude(d,excludeDirs)
% http://www.mathworks.com/matlabcentral/fileexchange/22209-genpath-exclude
% pathStr = genpath_exclude(basePath,ignoreDirs)
%
% Extension of Matlab's "genpath" function, except this will exclude
% directories (and their sub-tree) given by "ignoreDirs". 
%
% Example usage:
% genpath_exclude('C:\myDir',{'CVS'}) %<--- simple usage to ignore CVS direcotries
% genpath_exclude('C:\myDir',{'\.svn'}) %<--- simple usage to ignore .svn (note that "." must be escaped for proper handling in the regexp)
% genpath_exclude('C:\myDir',{'CVS','#.*'}) %<----more advanced usage to ignore CVS directories and any directory starting with "#"
%
% Inputs:
%    basePath: string.  The base path for which to generate path string.
%
%    excludeDirs: cell-array of strings. all directory names to ignore. Note,
%                 these strings are passed into regexp surrounded by
%                 '^'   and '$'.  If your directory name contains special
%                 characters to regexp, they must be escaped.  For example,
%                 use '\.svn' to ignore ".svn" directories.  You may also
%                 use regular expressions to ignore certian patterns. For
%                 example, use '*._ert_rtw' to ignore all directories ending
%                 with "_ert_rtw".
%
% Outputs:
%    pathStr: string. semicolon delimited string of paths. (see genpath)
% 
% See also genpath
%
% ---CVS Keywords----
% $Author: jhopkin $
% $Date: 2009/10/27 19:06:19 $
% $Name:  $
% $Revision: 1.5 $

% $Log: genpath_exclude.m,v $
% Revision 1.5  2009/10/27 19:06:19  jhopkin
% fixed regexp handling.  added more help comments
%
% Revision 1.4  2008/11/25 19:04:29  jhopkin
% minor cleanup.  Made input more robust so that if user enters a string as 'excudeDir' rather than a cell array of strings this function will still work.  (did this by moving the '^' and '$' to surround the entire regexp string, rather than wrapping them around each "excludeDir")
%
% Revision 1.3  2008/11/25 18:43:10  jhopkin
% added help comments
%
% Revision 1.1  2008/11/22 00:23:01  jhopkin
% *** empty log message ***
%
    % if the input is a string, then use it as the searchstr
    if ischar(excludeDirs)
        excludeStr = excludeDirs;
    else
        excludeStr = '';
        if ~iscellstr(excludeDirs)
            error('excludeDirs input must be a cell-array of strings');
        end
        
        for i = 1:length(excludeDirs)
            excludeStr = [excludeStr '|^' excludeDirs{i} '$'];
        end
    end

    
    % Generate path based on given root directory
    files = dir(d);
    if isempty(files)
      return
    end

    % Add d to the path even if it is empty.
    p = [d pathsep];

    % set logical vector for subdirectory entries in d
    isdir = logical(cat(1,files.isdir));
    %
    % Recursively descend through directories which are neither
    % private nor "class" directories.
    %
    dirs = files(isdir); % select only directory entries from the current listing

    for i=1:length(dirs)
        dirname = dirs(i).name;
        %NOTE: regexp ignores '.', '..', '@.*', and 'private' directories by default. 
        % if ~any(regexp(dirname,['^\.$|^\.\.$|^\@.*|^private$|' excludeStr ],'start'))
        if ~any(regexp(dirname,['^\.$|^\.\.$|^\@.*|^\+.*|^private$|' excludeStr ],'start')) 
          p = [p genpath_exclude(fullfile(d,dirname),excludeStr)]; % recursive calling of this function.
        end
    end
end % end function


function result = legacize(theArg);
% if matlab version >= 7.14 (2012a), add 'legacy' to the parameters, otherwise not
% this way, maintain cross-matlab version compatability
v = version;
indp = find(v == '.');
v = str2num(v(1:indp(2)-1));
if v > 7.19, v = floor(v) + rem(v,1)/10; end;

result = theArg;
hasLegacy = any(strcmp('legacy', theArg));
if ~hasLegacy
    if v >= 7.14
        result = {theArg{:}, 'legacy'};
    end
end;
end  % end internal function


function WasOnTop = WinOnTop( FigureHandle, IsOnTop )
    % http://www.mathworks.com/matlabcentral/fileexchange/42252-winontop
    %WINONTOP allows to trigger figure's "Always On Top" state
    % INPUT ARGUMENTS:
    % * FigureHandle - Matlab's figure handle, scalar
    % * IsOnTop      - logical scalar or empty array
    %
    % USAGE:
    % * WinOnTop( hfigure, bool );
    % * WinOnTop( hfigure );            - equal to WinOnTop( hfigure,true);
    % * WinOnTop();                     - equal to WinOnTop( gcf, true);
    % * WasOnTop = WinOnTop(...);       - returns boolean value "if figure WAS on top"
    % * IsOnTop  = WinOnTop(hfigure,[]) - gets "if figure is on top" property
    % 
    % LIMITATIONS:
    % * java enabled
    % * figure must be visible
    % * figure's "WindowStyle" should be "normal"
    %
    %
    % Written by Igor
    % i3v@mail.ru
    %
    % 16 June 2013 - Initial version
    % 27 June 2013 - removed custom "ishandle_scalar" function call

    %% Parse Inputs
    if ~exist('FigureHandle','var');FigureHandle = gcf; end
    assert(...
              isscalar( FigureHandle ) && ishandle( FigureHandle ) &&  strcmp(get(FigureHandle,'Type'),'figure'),...
              'WinOnTop:Bad_FigureHandle_input',...
              '%s','Provided FigureHandle input is not a figure handle'...
           );
    assert(...
                strcmp('on',get(FigureHandle,'Visible')),...
                'WinOnTop:FigInisible',...
                '%s','Figure Must be Visible'...
           );
    assert(...
                strcmp('normal',get(FigureHandle,'WindowStyle')),...
                'WinOnTop:FigWrongWindowStyle',...
                '%s','WindowStyle Must be Normal'...
           );
    if ~exist('IsOnTop','var');IsOnTop=true;end
    assert(...
              islogical( IsOnTop ) &&  isscalar( IsOnTop) || isempty( IsOnTop ), ...
              'WinOnTop:Bad_IsOnTop_input',...
              '%s','Provided IsOnTop input is neither boolean, nor empty'...
          );
    %% Pre-checks
    error(javachk('swing',mfilename)) % Swing components must be available.
    %% Action
    % Flush the Event Queue of Graphic Objects and Update the Figure Window.
    drawnow expose
    jFrame = get(handle(FigureHandle),'JavaFrame');
    drawnow
    WasOnTop = jFrame.fHG1Client.getWindow.isAlwaysOnTop;
    if ~isempty(IsOnTop)
        jFrame.fHG1Client.getWindow.setAlwaysOnTop(IsOnTop);
    end
end % end internal function


% STRUCTCMP True if two structures are equal.
%     STRUCTCMP(A,B) returns logical 1 (TRUE) if structure A and B are the same
%     size, contain the same field names (case sensitive), same field sorting, and same values;
%     and logical 0 (FALSE) otherwise.
%     
%     If A is defined and you set B = A, STRUCTCMP(A,B) is not necessarily
%     true. If A's or B's field contains a NaN (Not a Number) element, STRUCTCMP returns 
%     false because NaNs are not equal to each other by definition. To considers NaN values to be equal
%     use STRUCTCMP(A,B, 'EqualNans', 'on')
%  
%     The order in which the fields of each structure were created is important. To ignore the field
%     sorting use STRUCTCMP(A,B, 'IgnoreSorting', 'on')
%
%     Field names comparison is case sensitive. To ignore any differences in letter case use 
%     STRUCTCMP(A,B, 'IgnoreCase', 'on')
%
%     STRUCTCMP(A,B, 'Report', 'on') displays a report on the command window
%  
%     See also isequal, isequalwithequalnans, eq.
%
% Author: Javier Lopez-Calderon
% email : javlopez@ucdavis.edu
% Davis, CA
% 2013
%
% 12-Sep-2013: JLC -  Added error msg when any input is not a structure.
% 12-Sep-2013: JLC -  When report is 'on' the checking loop continues until the last field (does not use "break")

function Lout = structcmp(S1, S2, varargin)
%
% Parsing inputs
%
p = inputParser;
p.FunctionName  = mfilename;
p.CaseSensitive = false;
p.addRequired('S1');
p.addRequired('S2');
p.addParamValue('Tab', 6, @isnumeric);
p.addParamValue('IgnoreCase', 'off', @ischar);
p.addParamValue('IgnoreSorting', 'off', @ischar);
p.addParamValue('EqualNans', 'off', @ischar);
p.addParamValue('Report', 'off', @ischar);
p.addParamValue('IsRecursiveCall', 'no', @ischar);
% add skip fields option
p.parse(S1, S2, varargin{:});
IsRecursiveCall = p.Results.IsRecursiveCall;
if ~isstruct(S1);error('First input argument is not a structure');end
if ~isstruct(S2);error('Second input argument is not a structure');end
ntab   = p.Results.Tab;
nS1    = length(S1);
nS2    = length(S2);
if nS1~=nS2
        Lout = false;
        fprintf('Structures have different length.\n');
        return
end % check equal length
fnameS1  = fieldnames(S1);
fnameS2  = fieldnames(S2);
nfnameS1 = length(fnameS1);
nfnameS2 = length(fnameS2);
if nfnameS1~=nfnameS2
        Lout = false;
        fprintf('Structures have different amount of fields.\n');
        return
end % check equal number of fields
[sortfnameS1 indxS1] = sort(fnameS1);
[sortfnameS2 indxS2] = sort(fnameS1);
if strcmpi(p.Results.IgnoreSorting, 'off') && ~isequal(indxS1, indxS2) 
        Lout = false;
        fprintf('Structures have different sorting order.\n');
        return
end % check equal fields' sorting
if strcmpi(p.Results.IgnoreCase, 'off')
        if ~isequal(sortfnameS1, sortfnameS2)
                Lout = false;
                fprintf('Structures have different field names (case sensitive).\n');
                return
        end % check equal field names (case sensitive)
else
        if ~isequal(lower(sortfnameS1), lower(sortfnameS2))
                Lout = false;
                fprintf('Structures have different field names.\n');
                return
        end % check equal field names
end
Lvalue = true(1,nfnameS1); % default
for kk=1:nfnameS1
        if strcmpi(p.Results.Report, 'on')
                Fcall = dbstack;callnames = {Fcall.name};
                tabstr = blanks(ntab*sum(ismember(callnames, {'structcmp'}))-1);
        end % check number of recursive calls
        try, RS1 = S1.(sortfnameS1{kk}); catch, if nS1==0, RS1 = 'Attention:EmptyStruct'; end; end
        try, RS2 = S2.(sortfnameS2{kk}); catch, if nS2==0, RS2 = 'Attention:EmptyStruct'; end; end
        if isstruct(RS1) && isstruct(RS2)
                IsRecursiveCall = 'yes';
                if strcmpi(p.Results.Report, 'on')
                        fprintf('%sComparing sub-structures "%s" and "%s" : \n', tabstr, sortfnameS1{kk}, sortfnameS2{kk});
                end % print report
                Lvalue(kk) = structcmp(RS1, RS2, 'Tab',ntab, 'IgnoreCase', p.Results.IgnoreCase, 'Report', p.Results.Report, 'IsRecursiveCall', IsRecursiveCall); % recursive calls in case of substructure
        elseif ~isstruct(RS1) && ~isstruct(RS2)
                IsRecursiveCall = 'no';
                if strcmpi(p.Results.Report, 'on')
                        fprintf('%sComparing contains of fields %s and %s : \n', tabstr, sortfnameS1{kk}, sortfnameS2{kk});
                end     % print report           
                if strcmpi(p.Results.EqualNans, 'off')
                        if ~isequal(RS1, RS2) | ~strcmp(class(RS1),class(RS2));Lvalue(kk)=false;else Lvalue(kk)=true; end
                else                        
                        if ~isequalwithequalnans(RS1, RS2) | ~strcmp(class(RS1),class(RS2));Lvalue(kk) = false;else Lvalue(kk)=true;end
                end % check equal values (including NaNs)               
        else
                IsRecursiveCall = 'no';
                if strcmpi(p.Results.Report, 'on')
                        fprintf('%sComparing %s and %s : \n', tabstr, sortfnameS1{kk}, sortfnameS2{kk});
                end % print report
                Lvalue(kk) = false;
        end
        if strcmpi(p.Results.Report, 'on')
            if strcmpi(IsRecursiveCall, 'no')
                if Lvalue(kk); fprintf('\bSame.\n');else fprintf('\b------>Diff!\n');end % print report
            end
        else
                if ~Lvalue(kk);break;end
        end 
end
Lout = all(Lvalue);
end % end internal function


function fn_structdisp(Xname)
% function fn_structdisp Xname
% function fn_structdisp(X)
%---
% Recursively display the content of a structure and its sub-structures
%
% Input:
% - Xname/X     one can give as argument either the structure to display or
%               or a string (the name in the current workspace of the
%               structure to display)
%
% A few parameters can be adjusted inside the m file to determine when
% arrays and cell should be displayed completely or not

% Thomas Deneux
% Copyright 2005-2012

if ischar(Xname)
    X = evalin('caller',Xname);
else
    X = Xname;
    Xname = inputname(1);
end

if ~isstruct(X), error('argument should be a structure or the name of a structure'), end
rec_structdisp(Xname,X)
end % end main function
%---------------------------------
function rec_structdisp(Xname,X)
%---

%-- PARAMETERS (Edit this) --%

ARRAYMAXROWS = 10;
ARRAYMAXCOLS = 10;
ARRAYMAXELEMS = 30;
CELLMAXROWS = 10;
CELLMAXCOLS = 10;
CELLMAXELEMS = 30;
CELLRECURSIVE = false;

%----- PARAMETERS END -------%

disp([Xname ':'])
disp(X)
%fprintf('\b')

if isstruct(X) || isobject(X)
    F = fieldnames(X);
    nsub = length(F);
    Y = cell(1,nsub);
    subnames = cell(1,nsub);
    for i=1:nsub
        f = F{i};
        Y{i} = X.(f);
        subnames{i} = [Xname '.' f];
    end
elseif CELLRECURSIVE && iscell(X)
    nsub = numel(X);
    s = size(X);
    Y = X(:);
    subnames = cell(1,nsub);
    for i=1:nsub
        inds = s;
        globind = i-1;
        for k=1:length(s)
            inds(k) = 1+mod(globind,s(k));
            globind = floor(globind/s(k));
        end
        subnames{i} = [Xname '{' num2str(inds,'%i,')];
        subnames{i}(end) = '}';
    end
else
    return
end

for i=1:nsub
    a = Y{i};
    if isstruct(a) || isobject(a)
        if length(a)==1
            rec_structdisp(subnames{i},a)
        else
            for k=1:length(a)
                rec_structdisp([subnames{i} '(' num2str(k) ')'],a(k))
            end
        end
    elseif iscell(a)
        if size(a,1)<=CELLMAXROWS && size(a,2)<=CELLMAXCOLS && numel(a)<=CELLMAXELEMS
            rec_structdisp(subnames{i},a)
        end
    elseif size(a,1)<=ARRAYMAXROWS && size(a,2)<=ARRAYMAXCOLS && numel(a)<=ARRAYMAXELEMS
        disp([subnames{i} ':'])
        disp(a)
    end
end
end % end this internal function


function output = strjoin(input, separator)
%STRJOIN Concatenate an array into a single string.
%
%     S = strjoin(C)
%     S = strjoin(C, separator)
%
% Description
%
% S = strjoin(C) takes an array C and returns a string S which concatenates
% array elements with comma. C can be a cell array of strings, a character
% array, a numeric array, or a logical array. If C is a matrix, it is first
% flattened to get an array and concateneted. S = strjoin(C, separator) also
% specifies separator for string concatenation. The default separator is comma.
%
% Examples
%
%     >> str = strjoin({'this','is','a','cell','array'})
%     str =
%     this,is,a,cell,array
%
%     >> str = strjoin([1,2,2],'_')
%     str =
%     1_2_2
%
%     >> str = strjoin({1,2,2,'string'},'\t')
%     str =
%     1 2 2 string
%

  if nargin < 2, separator = ','; end
  assert(ischar(separator), 'Invalid separator input: %s', class(separator));
  separator = strrep(separator, '%', '%%');

  output = '';
  if ~isempty(input)
    if ischar(input)
      input = cellstr(input);
    end
    if isnumeric(input) || islogical(input)
      output = [repmat(sprintf(['%.15g', separator], input(1:end-1)), ...
                       1, ~isscalar(input)), ...
                sprintf('%.15g', input(end))];
    elseif iscellstr(input)
      output = [repmat(sprintf(['%s', separator], input{1:end-1}), ...
                       1, ~isscalar(input)), ...
                sprintf('%s', input{end})];
    elseif iscell(input)
      output = strjoin(cellfun(@(x)strjoin(x, separator), input, ...
                               'UniformOutput', false), ...
                       separator);
    else
      error('strjoin:invalidInput', 'Unsupported input: %s', class(input));
    end
  end
end % end this internal function
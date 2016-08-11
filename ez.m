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
    %       cwd(), pwd(), csd(), csf(), parentdir(path), whichdir(mfilename)
    %       isdirlike(path), isfilelike(path), 
    %       isdir(path), isfile(path), exists(path)
    %       addpath(path), splitpath(path), joinpath(path1, path2), trimdir(path), cd(path)
    %       stepfolder(step)
    % 
    %       typeof(sth), type(sth), str(sth), num(sth), len(sth)
    %       ls([[path, ]regex, fullpath]), fls([[path, ]regex]), lsd([[path, ]regex, fullpath])
    %
    %       join(sep,string1,string2) or join(sep,array)
    %       replace(cellArray, item, replacement)
    %
    %       mkdir(path), rm(path), cp(src, dest), mv(src, dest), rn(src, dest), ln(src, dest)
    %       execute(cmd), open(path)
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
    %       export(), ps2pdf()
    %       exe_   portable exe
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

        function [dir] = whichdir(name)
            %   WHICHDIR  Returns directory name containing file in search path.
            %
            %   WHICHDIR NAME returns the directory containing a file called NAME,
            %   i.e. the full path of the file excluding NAME and the trailing '/'. 
            %
            %   If NAME does not include an extension, then it is interpreted as
            %   the name of an m-file, i.e. having extension '.m' .

            %   modified from:
            %   _________________________________________________________________
            %   This is part of JLAB --- type 'help jlab' for more information 
            %   (C) 2006--2015 J.M. Lilly --- type 'help jlab_license' for details
              
            if isempty(strfind(name,'.'))
                name=[name '.m'];
            end

            %   If more than one directory contains a file called NAME, then 
            %   WHICHDIR returns a cell array of directories names.
            % dir=which(name,'-all');
            dir={which(name)};

            for i=1:length(dir)
               dir{i}=dir{i}(1:end-length(name)-1);
            end

            if i==1
                dir=dir{1};
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

        function [folder, projFolder] = stepfolder(step)
            % [folder, projFolder] = stepfolder(step)
            % step: regex of folder, eg '01', if multiple match, return only the first matched
            %       integer -1 (default, backward) +2 (forward) 2 (same as +2)
            % folder: target folder path
            % projFolder: project folder path
            % 
            % Usage:
            %       Under a projFolder, there might be 01Original, 02Slicing, 03Motion...
            %       Use this function to go to a specific "step folder"
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                csd = fileparts(theStack.file);
            catch
                csd = pwd;
            end

            if nargin<1, step=-1; end
                
            projFolder = ez.parentdir(csd);
            if isstr(step)
                folder = ez.lsd(projFolder,step);
                folder = folder{1};
                folder = ez.joinpath(projFolder,folder);
            elseif isnumeric(step)
                steps = ez.lsd(projFolder,'^\d\d'); % a cell of all folders like 01Original, 06Set
                [dummy, currentStep] = ez.splitpath(csd);
                currentStepNum = find(strcmp(steps,currentStep));
                if ~isempty(currentStepNum), targetStep = steps{currentStepNum+step}; else targetStep = currentStep; end
                folder = ez.joinpath(projFolder,targetStep);
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

        function [status,result] = ln(src,dest)
            % ln(src,dest)
            % create a soft link
            % when src is a file, dest could be a target file or a target dir
            [status,result] = system(['ln -s ' src ' ' dest],'-echo');
        end

        function [status,result] = execute(command)
            % execute(command)
            % execute operating system command and returns output

            % '-echo' also displays (echoes) the command output in the MATLAB® Command Window
            [status,result] = system(command,'-echo');
        end

        function open(path)
            % Opens a file or directory outside matlab with default external program
            % works for both mac and windows (under windows, a wrapper of winopen())
            % open(path)
            if(ispc)
                winopen(path);
            elseif(ismac)
                system(['open ', path]);
            else
                error('unknown operating system to call open()');
            end
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

        function varargout = ps2pdf(varargin)
            % (source, dest)
            % (source, dest, crop)
            % (source, dest, crop, append)
            % (source, dest, crop, append, gray)
            % (source, dest, crop, append, gray, quality)
            %
            % source - filename of the source eps file to convert. The filename is
            %          assumed to already have the extension ".eps".
            % dest - filename of the destination pdf file. The filename is assumed to
            %        already have the extension ".pdf".
            % crop - boolean indicating whether to crop the borders off the pdf.
            %        Default: true.
            % append - boolean indicating whether the eps should be appended to the
            %          end of the pdf as a new page (if the pdf exists already).
            %          Default: false.
            % gray - boolean indicating whether the output pdf should be grayscale or
            %        not. Default: false.
            % quality - scalar indicating the level of image bitmap quality to
            %           output. A larger value gives a higher quality. quality > 100
            %           gives lossless output. Default: ghostscript prepress default.
            [varargout{1:nargout}] = eps2pdf(varargin{:}); 
        end

        function varargout = export(varargin)
            % export the current(last activated) or specified figure in matlab to a file
            %
            % for publication, export as pdf (vector)
            %       export(), export('Fig'), export('Fig.pdf') --> all export as pdf
            %       optional parameters:
            %           additionally accepts 'append' to export as a single pdf file
            %           export('Fig.pdf','append') <-- .pdf must be explicitly specified
            %           
            %           also accepts 'bookmark'--(use fig title as bookmark name), 'nocrop'
            %           export('Fig.pdf','nocrop')
            %           
            %           multiple parameters acceptable
            %           export('Fig.pdf','nocrop','bookmark')
            %       requires ghostscript
            %           windows/linux users: http://ghostscript.com/download/gsdnld.html
            %           mac users: download at http://pages.uoregon.edu/koch/
            % 
            % for viewing, export as jpg
            %       export('Fig.jpg'), 
            %       export('Fig.jpg', 'm2.5', 'q50' ,'a1')
            %       m(magnify relative to the screen dimension), default m1
            %       q(0...100; 100=highest quality, largest filesize)
            %       a(1...4; 4=more anti-alias,larger filesize)
            %
            % filename supports sprintf() if dynamically change names
            %
            % size: adjust the matlab figure size/dimension manually, then export
            %       manual adjustment: set(gcf, 'Position', [100 100 150 150]);
            %
            % finally, accepts a figure handle(e.g. 1 2 3 etc), defaut to gcf. export('Fig.jpg', 3)
            % if the handle does not exist, use gcf
            %
            % pdf, eps, jpg <-- lossless and lossy compression
            % png, tiff, jpg, bmp (bitmap)  <--magnify, anti-alias
            % pdf, eps, png <-- transparent
            % pdf, tiff <-- append
            %
            % detailed help: https://github.com/ojwoodford/export_fig/blob/master/README.md

            % as of Thu, Jul 28 2016, I merged all export_fig functions to the end of this file
            % % add the export_fig folder to path which is in the same folder as ez
            % addpath(genpath_exclude(fileparts(mfilename('fullpath')),{'^\..*'}));

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

        function varargout = exe_capture(varargin)
            % launch FastStone Capture (the last freeware version (v5.3)), Windows OS only
            % & = background running, matlab continues processing
            system([fileparts(mfilename('fullpath')) '\fscapture\FSCapture.exe &']);
        end

        function varargout = exe_ahk(varargin)
            % launch AutoHotkey classic (1.04805)
            % will also load Autohotkey.ahk in the same folder
            system([fileparts(mfilename('fullpath')) '\AutoHotkey104805\AutoHotkey.exe ' fileparts(mfilename('fullpath')) '\AutoHotkey104805\AutoHotkey.ahk' ' &']);
        end

        function varargout = exe_pdfxviewer(varargin)
            % launch pdf x change viewer
            system([fileparts(mfilename('fullpath')) '\PDFXViewer2.5.312.1\PDFXCview.exe &']);
        end

        function varargout = exe_imageviewer(varargin)
            % launch FastStone image viewer
            system([fileparts(mfilename('fullpath')) '\FSViewer53\FSViewer.exe &']);
        end

        function varargout = exe_text(varargin)
            % launch sublimetext2.02
            system([fileparts(mfilename('fullpath')) '\SublimeText2.0.2\sublime_text.exe &']);
        end

        function varargout = exe_xplorer2(varargin)
            system([fileparts(mfilename('fullpath')) '\xplorer2_lite\xplorer2_lite.exe &']);
        end

        function varargout = exe_zip(varargin)
            system([fileparts(mfilename('fullpath')) '\PeaZipPortable\PeaZipPortable.exe &']);
        end
        
        function varargout = exe_clipboard(varargin)
            system([fileparts(mfilename('fullpath')) '\DittoPortable\DittoPortable.exe &']);
        end
        
        function varargout = exe_renamer(varargin)
            system([fileparts(mfilename('fullpath')) '\AntRenamerPortable\AntRenamerPortable.exe &']);
        end

        function varargout = exe_note(varargin)
            % sticky note
            system([fileparts(mfilename('fullpath')) '\PNotesPortable\PNotesPortable.exe &']);
        end
              
        function varargout = exe_teamviewer(varargin)
            system([fileparts(mfilename('fullpath')) '\TeamViewerPortable\TeamViewerPortable.exe &']);
        end

        function varargout = exe_compare(varargin)
            system([fileparts(mfilename('fullpath')) '\BeyondCompare\BCompare.exe &']);
        end

        function varargout = exe_subst(varargin)
            system([fileparts(mfilename('fullpath')) '\VSubst\VSubst.exe &']);
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


% export_fig func
%APPEND_PDFS Appends/concatenates multiple PDF files
%
% Example:
%   append_pdfs(output, input1, input2, ...)
%   append_pdfs(output, input_list{:})
%   append_pdfs test.pdf temp1.pdf temp2.pdf
%
% This function appends multiple PDF files to an existing PDF file, or
% concatenates them into a PDF file if the output file doesn't yet exist.
%
% This function requires that you have ghostscript installed on your
% system. Ghostscript can be downloaded from: http://www.ghostscript.com
%
% IN:
%    output - string of output file name (including the extension, .pdf).
%             If it exists it is appended to; if not, it is created.
%    input1 - string of an input file name (including the extension, .pdf).
%             All input files are appended in order.
%    input_list - cell array list of input file name strings. All input
%                 files are appended in order.

% Copyright: Oliver Woodford, 2011

% Thanks to Reinhard Knoll for pointing out that appending multiple pdfs in
% one go is much faster than appending them one at a time.

% Thanks to Michael Teo for reporting the issue of a too long command line.
% Issue resolved on 5/5/2011, by passing gs a command file.

% Thanks to Martin Wittmann for pointing out the quality issue when
% appending multiple bitmaps.
% Issue resolved (to best of my ability) 1/6/2011, using the prepress
% setting

function append_pdfs(varargin)
% Are we appending or creating a new file
append = exist(varargin{1}, 'file') == 2;
if append
    output = [tempname '.pdf'];
else
    output = varargin{1};
    varargin = varargin(2:end);
end
% Create the command file
cmdfile = [tempname '.txt'];
fh = fopen(cmdfile, 'w');
fprintf(fh, '-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="%s" -f', output);
fprintf(fh, ' "%s"', varargin{:});
fclose(fh);
% Call ghostscript
ghostscript(['@"' cmdfile '"']);
% Delete the command file
delete(cmdfile);
% Rename the file if needed
if append
    movefile(output, varargin{1});
end
end % end func

%COPYFIG Create a copy of a figure, without changing the figure
%
% Examples:
%   fh_new = copyfig(fh_old)
%
% This function will create a copy of a figure, but not change the figure,
% as copyobj sometimes does, e.g. by changing legends.
%
% IN:
%    fh_old - The handle of the figure to be copied. Default: gcf.
%
% OUT:
%    fh_new - The handle of the created figure.

% Copyright (C) Oliver Woodford 2012

function fh = copyfig(fh)
% Set the default
if nargin == 0
    fh = gcf;
end
% Is there a legend?
if isempty(findall(fh, 'Type', 'axes', 'Tag', 'legend'))
    % Safe to copy using copyobj
    fh = copyobj(fh, 0);
else
    % copyobj will change the figure, so save and then load it instead
    tmp_nam = [tempname '.fig'];
    hgsave(fh, tmp_nam);
    fh = hgload(tmp_nam);
    delete(tmp_nam);
end
return
end % end func

%EPS2PDF  Convert an eps file to pdf format using ghostscript
%
% Examples:
%   eps2pdf source dest
%   eps2pdf(source, dest, crop)
%   eps2pdf(source, dest, crop, append)
%   eps2pdf(source, dest, crop, append, gray)
%   eps2pdf(source, dest, crop, append, gray, quality)
%
% This function converts an eps file to pdf format. The output can be
% optionally cropped and also converted to grayscale. If the output pdf
% file already exists then the eps file can optionally be appended as a new
% page on the end of the eps file. The level of bitmap compression can also
% optionally be set.
%
% This function requires that you have ghostscript installed on your
% system. Ghostscript can be downloaded from: http://www.ghostscript.com
%
%IN:
%   source - filename of the source eps file to convert. The filename is
%            assumed to already have the extension ".eps".
%   dest - filename of the destination pdf file. The filename is assumed to
%          already have the extension ".pdf".
%   crop - boolean indicating whether to crop the borders off the pdf.
%          Default: true.
%   append - boolean indicating whether the eps should be appended to the
%            end of the pdf as a new page (if the pdf exists already).
%            Default: false.
%   gray - boolean indicating whether the output pdf should be grayscale or
%          not. Default: false.
%   quality - scalar indicating the level of image bitmap quality to
%             output. A larger value gives a higher quality. quality > 100
%             gives lossless output. Default: ghostscript prepress default.

% Copyright (C) Oliver Woodford 2009-2011

% Suggestion of appending pdf files provided by Matt C at:
% http://www.mathworks.com/matlabcentral/fileexchange/23629

% Thank you to Fabio Viola for pointing out compression artifacts, leading
% to the quality setting.
% Thank you to Scott for pointing out the subsampling of very small images,
% which was fixed for lossless compression settings.

% 9/12/2011 Pass font path to ghostscript.

function eps2pdf(source, dest, crop, append, gray, quality)
% Intialise the options string for ghostscript
options = ['-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="' dest '"'];
% Set crop option
if nargin < 3 || crop
    options = [options ' -dEPSCrop'];
end
% Set the font path
fp = font_path();
if ~isempty(fp)
    options = [options ' -sFONTPATH="' fp '"'];
end
% Set the grayscale option
if nargin > 4 && gray
    options = [options ' -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray'];
end
% Set the bitmap quality
if nargin > 5 && ~isempty(quality)
    options = [options ' -dAutoFilterColorImages=false -dAutoFilterGrayImages=false'];
    if quality > 100
        options = [options ' -dColorImageFilter=/FlateEncode -dGrayImageFilter=/FlateEncode -c ".setpdfwrite << /ColorImageDownsampleThreshold 10 /GrayImageDownsampleThreshold 10 >> setdistillerparams"'];
    else
        options = [options ' -dColorImageFilter=/DCTEncode -dGrayImageFilter=/DCTEncode'];
        v = 1 + (quality < 80);
        quality = 1 - quality / 100;
        s = sprintf('<< /QFactor %.2f /Blend 1 /HSample [%d 1 1 %d] /VSample [%d 1 1 %d] >>', quality, v, v, v, v);
        options = sprintf('%s -c ".setpdfwrite << /ColorImageDict %s /GrayImageDict %s >> setdistillerparams"', options, s, s);
    end
end
% Check if the output file exists
if nargin > 3 && append && exist(dest, 'file') == 2
    % File exists - append current figure to the end
    tmp_nam = tempname;
    % Copy the file
    copyfile(dest, tmp_nam);
    % Add the output file names
    options = [options ' -f "' tmp_nam '" "' source '"'];
    try
        % Convert to pdf using ghostscript
        [status, message] = ghostscript(options);
    catch me
        % Delete the intermediate file
        delete(tmp_nam);
        rethrow(me);
    end
    % Delete the intermediate file
    delete(tmp_nam);
else
    % File doesn't exist or should be over-written
    % Add the output file names
    options = [options ' -f "' source '"'];
    % Convert to pdf using ghostscript
    [status, message] = ghostscript(options);
end
% Check for error
if status
    % Report error
    if isempty(message)
        error('Unable to generate pdf. Check destination directory is writable.');
    else
        error(message);
    end
end
return
end % end func

% Function to return (and create, where necessary) the font path
function fp = font_path()
fp = user_string('gs_font_path');
if ~isempty(fp)
    return
end
% Create the path
% Start with the default path
fp = getenv('GS_FONTPATH');
% Add on the typical directories for a given OS
if ispc
    if ~isempty(fp)
        fp = [fp ';'];
    end
    fp = [fp getenv('WINDIR') filesep 'Fonts'];
else
    if ~isempty(fp)
        fp = [fp ':'];
    end
    fp = [fp '/usr/share/fonts:/usr/local/share/fonts:/usr/share/fonts/X11:/usr/local/share/fonts/X11:/usr/share/fonts/truetype:/usr/local/share/fonts/truetype'];
end
user_string('gs_font_path', fp);
return
end % end func

%EXPORT_FIG  Exports figures suitable for publication
%
% Examples:
%   im = export_fig
%   [im alpha] = export_fig
%   export_fig filename
%   export_fig filename -format1 -format2
%   export_fig ... -nocrop
%   export_fig ... -transparent
%   export_fig ... -native
%   export_fig ... -m<val>
%   export_fig ... -r<val>
%   export_fig ... -a<val>
%   export_fig ... -q<val>
%   export_fig ... -<renderer>
%   export_fig ... -<colorspace>
%   export_fig ... -append
%   export_fig ... -bookmark
%   export_fig(..., handle)
%
% This function saves a figure or single axes to one or more vector and/or
% bitmap file formats, and/or outputs a rasterized version to the
% workspace, with the following properties:
%   - Figure/axes reproduced as it appears on screen
%   - Cropped borders (optional)
%   - Embedded fonts (vector formats)
%   - Improved line and grid line styles
%   - Anti-aliased graphics (bitmap formats)
%   - Render images at native resolution (optional for bitmap formats)
%   - Transparent background supported (pdf, eps, png)
%   - Semi-transparent patch objects supported (png only)
%   - RGB, CMYK or grayscale output (CMYK only with pdf, eps, tiff)
%   - Variable image compression, including lossless (pdf, eps, jpg)
%   - Optionally append to file (pdf, tiff)
%   - Vector formats: pdf, eps
%   - Bitmap formats: png, tiff, jpg, bmp, export to workspace 
%   
% This function is especially suited to exporting figures for use in
% publications and presentations, because of the high quality and
% portability of media produced.
%
% Note that the background color and figure dimensions are reproduced
% (the latter approximately, and ignoring cropping & magnification) in the
% output file. For transparent background (and semi-transparent patch
% objects), use the -transparent option or set the figure 'Color' property
% to 'none'. To make axes transparent set the axes 'Color' property to
% 'none'. Pdf, eps and png are the only file formats to support a
% transparent background, whilst the png format alone supports transparency
% of patch objects.
%
% The choice of renderer (opengl, zbuffer or painters) has a large impact
% on the quality of output. Whilst the default value (opengl for bitmaps,
% painters for vector formats) generally gives good results, if you aren't
% satisfied then try another renderer.  Notes: 1) For vector formats (eps,
% pdf), only painters generates vector graphics. 2) For bitmaps, only
% opengl can render transparent patch objects correctly. 3) For bitmaps,
% only painters will correctly scale line dash and dot lengths when
% magnifying or anti-aliasing. 4) Fonts may be substitued with Courier when
% using painters.
%
% When exporting to vector format (pdf & eps) and bitmap format using the
% painters renderer, this function requires that ghostscript is installed
% on your system. You can download this from:
%   http://www.ghostscript.com
% When exporting to eps it additionally requires pdftops, from the Xpdf
% suite of functions. You can download this from:
%   http://www.foolabs.com/xpdf
%
%IN:
%   filename - string containing the name (optionally including full or
%              relative path) of the file the figure is to be saved as. If
%              a path is not specified, the figure is saved in the current
%              directory. If no name and no output arguments are specified,
%              the default name, 'export_fig_out', is used. If neither a
%              file extension nor a format are specified, a ".png" is added
%              and the figure saved in that format.
%   -format1, -format2, etc. - strings containing the extensions of the
%                              file formats the figure is to be saved as.
%                              Valid options are: '-pdf', '-eps', '-png',
%                              '-tif', '-jpg' and '-bmp'. All combinations
%                              of formats are valid.
%   -nocrop - option indicating that the borders of the output are not to
%             be cropped.
%   -transparent - option indicating that the figure background is to be
%                  made transparent (png, pdf and eps output only).
%   -m<val> - option where val indicates the factor to magnify the
%             on-screen figure pixel dimensions by when generating bitmap
%             outputs. Default: '-m1'.
%   -r<val> - option val indicates the resolution (in pixels per inch) to
%             export bitmap and vector outputs at, keeping the dimensions
%             of the on-screen figure. Default: '-r864' (for vector output
%             only). Note that the -m option overides the -r option for
%             bitmap outputs only.
%   -native - option indicating that the output resolution (when outputting
%             a bitmap format) should be such that the vertical resolution
%             of the first suitable image found in the figure is at the
%             native resolution of that image. To specify a particular
%             image to use, give it the tag 'export_fig_native'. Notes:
%             This overrides any value set with the -m and -r options. It
%             also assumes that the image is displayed front-to-parallel
%             with the screen. The output resolution is approximate and
%             should not be relied upon. Anti-aliasing can have adverse
%             effects on image quality (disable with the -a1 option).
%   -a1, -a2, -a3, -a4 - option indicating the amount of anti-aliasing to
%                        use for bitmap outputs. '-a1' means no anti-
%                        aliasing; '-a4' is the maximum amount (default).
%   -<renderer> - option to force a particular renderer (painters, opengl
%                 or zbuffer) to be used over the default: opengl for
%                 bitmaps; painters for vector formats.
%   -<colorspace> - option indicating which colorspace color figures should
%                   be saved in: RGB (default), CMYK or gray. CMYK is only
%                   supported in pdf, eps and tiff output.
%   -q<val> - option to vary bitmap image quality (in pdf, eps and jpg
%             files only).  Larger val, in the range 0-100, gives higher
%             quality/lower compression. val > 100 gives lossless
%             compression. Default: '-q95' for jpg, ghostscript prepress
%             default for pdf & eps. Note: lossless compression can
%             sometimes give a smaller file size than the default lossy
%             compression, depending on the type of images.
%   -append - option indicating that if the file (pdfs only) already
%             exists, the figure is to be appended as a new page, instead
%             of being overwritten (default).
%   -bookmark - option to indicate that a bookmark with the name of the
%               figure is to be created in the output file (pdf only).
%   handle - The handle of the figure, axes or uipanels (can be an array of
%            handles, but the objects must be in the same figure) to be
%            saved. Default: gcf.
%
%OUT:
%   im - MxNxC uint8 image array of the figure.
%   alpha - MxN single array of alphamatte values in range [0,1], for the
%           case when the background is transparent.
%
%   Some helpful examples and tips can be found at:
%      http://sites.google.com/site/oliverwoodford/software/export_fig
%
%   See also PRINT, SAVEAS.

% Copyright (C) Oliver Woodford 2008-2014

% The idea of using ghostscript is inspired by Peder Axensten's SAVEFIG
% (fex id: 10889) which is itself inspired by EPS2PDF (fex id: 5782).
% The idea for using pdftops came from the MATLAB newsgroup (id: 168171).
% The idea of editing the EPS file to change line styles comes from Jiro
% Doke's FIXPSLINESTYLE (fex id: 17928).
% The idea of changing dash length with line width came from comments on
% fex id: 5743, but the implementation is mine :)
% The idea of anti-aliasing bitmaps came from Anders Brun's MYAA (fex id:
% 20979).
% The idea of appending figures in pdfs came from Matt C in comments on the
% FEX (id: 23629)

% Thanks to Roland Martin for pointing out the colour MATLAB
% bug/feature with colorbar axes and transparent backgrounds.
% Thanks also to Andrew Matthews for describing a bug to do with the figure
% size changing in -nodisplay mode. I couldn't reproduce it, but included a
% fix anyway.
% Thanks to Tammy Threadgill for reporting a bug where an axes is not
% isolated from gui objects.

% 23/02/12: Ensure that axes limits don't change during printing
% 14/03/12: Fix bug in fixing the axes limits (thanks to Tobias Lamour for
%           reporting it).
% 02/05/12: Incorporate patch of Petr Nechaev (many thanks), enabling
%           bookmarking of figures in pdf files.
% 09/05/12: Incorporate patch of Arcelia Arrieta (many thanks), to keep
%           tick marks fixed.
% 12/12/12: Add support for isolating uipanels. Thanks to michael for
%           suggesting it.
% 25/09/13: Add support for changing resolution in vector formats. Thanks
%           to Jan Jaap Meijer for suggesting it.
% 07/05/14: Add support for '~' at start of path. Thanks to Sally Warner
%           for suggesting it.

function [im, alpha] = export_fig(varargin)
% Make sure the figure is rendered correctly _now_ so that properties like
% axes limits are up-to-date.
drawnow;
% Parse the input arguments
[fig, options] = parse_args(nargout, varargin{:});
% Isolate the subplot, if it is one
cls = all(ismember(get(fig, 'Type'), {'axes', 'uipanel'}));
if cls
    % Given handles of one or more axes, so isolate them from the rest
    fig = isolate_axes(fig);
else
    % Check we have a figure
    if ~isequal(get(fig, 'Type'), 'figure');
        error('Handle must be that of a figure, axes or uipanel');
    end
    % Get the old InvertHardcopy mode
    old_mode = get(fig, 'InvertHardcopy');
end
% Hack the font units where necessary (due to a font rendering bug in
% print?). This may not work perfectly in all cases. Also it can change the
% figure layout if reverted, so use a copy.
magnify = options.magnify * options.aa_factor;
if isbitmap(options) && magnify ~= 1
    fontu = findobj(fig, 'FontUnits', 'normalized');
    if ~isempty(fontu)
        % Some normalized font units found
        if ~cls
            fig = copyfig(fig);
            set(fig, 'Visible', 'off');
            fontu = findobj(fig, 'FontUnits', 'normalized');
            cls = true;
        end
        set(fontu, 'FontUnits', 'points');
    end
end
% MATLAB "feature": axes limits and tick marks can change when printing
Hlims = findall(fig, 'Type', 'axes');
if ~cls
    % Record the old axes limit and tick modes
    Xlims = make_cell(get(Hlims, 'XLimMode'));
    Ylims = make_cell(get(Hlims, 'YLimMode'));
    Zlims = make_cell(get(Hlims, 'ZLimMode'));
    Xtick = make_cell(get(Hlims, 'XTickMode'));
    Ytick = make_cell(get(Hlims, 'YTickMode'));
    Ztick = make_cell(get(Hlims, 'ZTickMode'));
end
% Set all axes limit and tick modes to manual, so the limits and ticks can't change
set(Hlims, 'XLimMode', 'manual', 'YLimMode', 'manual', 'ZLimMode', 'manual', 'XTickMode', 'manual', 'YTickMode', 'manual', 'ZTickMode', 'manual');
% Set to print exactly what is there
set(fig, 'InvertHardcopy', 'off');
% Set the renderer
switch options.renderer
    case 1
        renderer = '-opengl';
    case 2
        renderer = '-zbuffer';
    case 3
        renderer = '-painters';
    otherwise
        renderer = '-opengl'; % Default for bitmaps
end
% Do the bitmap formats first
if isbitmap(options)
    % Get the background colour
    if options.transparent && (options.png || options.alpha)
        % Get out an alpha channel
        % MATLAB "feature": black colorbar axes can change to white and vice versa!
        hCB = findobj(fig, 'Type', 'axes', 'Tag', 'Colorbar');
        if isempty(hCB)
            yCol = [];
            xCol = [];
        else
            yCol = get(hCB, 'YColor');
            xCol = get(hCB, 'XColor');
            if iscell(yCol)
                yCol = cell2mat(yCol);
                xCol = cell2mat(xCol);
            end
            yCol = sum(yCol, 2);
            xCol = sum(xCol, 2);
        end
        % MATLAB "feature": apparently figure size can change when changing
        % colour in -nodisplay mode
        pos = get(fig, 'Position');
        % Set the background colour to black, and set size in case it was
        % changed internally
        tcol = get(fig, 'Color');
        set(fig, 'Color', 'k', 'Position', pos);
        % Correct the colorbar axes colours
        set(hCB(yCol==0), 'YColor', [0 0 0]);
        set(hCB(xCol==0), 'XColor', [0 0 0]);
        % Print large version to array
        B = print2array(fig, magnify, renderer);
        % Downscale the image
        B = downsize(single(B), options.aa_factor);
        % Set background to white (and set size)
        set(fig, 'Color', 'w', 'Position', pos);
        % Correct the colorbar axes colours
        set(hCB(yCol==3), 'YColor', [1 1 1]);
        set(hCB(xCol==3), 'XColor', [1 1 1]);
        % Print large version to array
        A = print2array(fig, magnify, renderer);
        % Downscale the image
        A = downsize(single(A), options.aa_factor);
        % Set the background colour (and size) back to normal
        set(fig, 'Color', tcol, 'Position', pos);
        % Compute the alpha map
        alpha = round(sum(B - A, 3)) / (255 * 3) + 1;
        A = alpha;
        A(A==0) = 1;
        A = B ./ A(:,:,[1 1 1]);
        clear B
        % Convert to greyscale
        if options.colourspace == 2
            A = rgb2grey(A);
        end
        A = uint8(A);
        % Crop the background
        if options.crop
            [alpha, v] = crop_background(alpha, 0);
            A = A(v(1):v(2),v(3):v(4),:);
        end
        if options.png
            % Compute the resolution
            res = options.magnify * get(0, 'ScreenPixelsPerInch') / 25.4e-3;
            % Save the png
            imwrite(A, [options.name '.png'], 'Alpha', double(alpha), 'ResolutionUnit', 'meter', 'XResolution', res, 'YResolution', res);
            % Clear the png bit
            options.png = false;
        end
        % Return only one channel for greyscale
        if isbitmap(options)
            A = check_greyscale(A);
        end
        if options.alpha
            % Store the image
            im = A;
            % Clear the alpha bit
            options.alpha = false;
        end
        % Get the non-alpha image
        if isbitmap(options)
            alph = alpha(:,:,ones(1, size(A, 3)));
            A = uint8(single(A) .* alph + 255 * (1 - alph));
            clear alph
        end
        if options.im
            % Store the new image
            im = A;
        end
    else
        % Print large version to array
        if options.transparent
            % MATLAB "feature": apparently figure size can change when changing
            % colour in -nodisplay mode
            pos = get(fig, 'Position');
            tcol = get(fig, 'Color');
            set(fig, 'Color', 'w', 'Position', pos);
            A = print2array(fig, magnify, renderer);
            set(fig, 'Color', tcol, 'Position', pos);
            tcol = 255;
        else
            [A, tcol] = print2array(fig, magnify, renderer);
        end
        % Crop the background
        if options.crop
            A = crop_background(A, tcol);
        end
        % Downscale the image
        A = downsize(A, options.aa_factor);
        if options.colourspace == 2
            % Convert to greyscale
            A = rgb2grey(A);
        else
            % Return only one channel for greyscale
            A = check_greyscale(A);
        end
        % Outputs
        if options.im
            im = A;
        end
        if options.alpha
            im = A;
            alpha = zeros(size(A, 1), size(A, 2), 'single');
        end
    end
    % Save the images
    if options.png
        res = options.magnify * get(0, 'ScreenPixelsPerInch') / 25.4e-3;
        imwrite(A, [options.name '.png'], 'ResolutionUnit', 'meter', 'XResolution', res, 'YResolution', res);
    end
    if options.bmp
        imwrite(A, [options.name '.bmp']);
    end
    % Save jpeg with given quality
    if options.jpg
        quality = options.quality;
        if isempty(quality)
            quality = 95;
        end
        if quality > 100
            imwrite(A, [options.name '.jpg'], 'Mode', 'lossless');
        else
            imwrite(A, [options.name '.jpg'], 'Quality', quality);
        end
    end
    % Save tif images in cmyk if wanted (and possible)
    if options.tif
        if options.colourspace == 1 && size(A, 3) == 3
            A = double(255 - A);
            K = min(A, [], 3);
            K_ = 255 ./ max(255 - K, 1);
            C = (A(:,:,1) - K) .* K_;
            M = (A(:,:,2) - K) .* K_;
            Y = (A(:,:,3) - K) .* K_;
            A = uint8(cat(3, C, M, Y, K));
            clear C M Y K K_
        end
        append_mode = {'overwrite', 'append'};
        imwrite(A, [options.name '.tif'], 'Resolution', options.magnify*get(0, 'ScreenPixelsPerInch'), 'WriteMode', append_mode{options.append+1});
    end
end
% Now do the vector formats
if isvector(options)
    % Set the default renderer to painters
    if ~options.renderer
        renderer = '-painters';
    end
    % Generate some filenames
    tmp_nam = [tempname '.eps'];
    if options.pdf
        pdf_nam = [options.name '.pdf'];
    else
        pdf_nam = [tempname '.pdf'];
    end
    % Generate the options for print
    p2eArgs = {renderer, sprintf('-r%d', options.resolution)};
    if options.colourspace == 1
        p2eArgs = [p2eArgs {'-cmyk'}];
    end
    if ~options.crop
        p2eArgs = [p2eArgs {'-loose'}];
    end
    try
        % Generate an eps
        print2eps(tmp_nam, fig, p2eArgs{:});
        % Remove the background, if desired
        if options.transparent && ~isequal(get(fig, 'Color'), 'none')
            eps_remove_background(tmp_nam, 1 + using_hg2(fig));
        end
        % Add a bookmark to the PDF if desired
        if options.bookmark
            fig_nam = get(fig, 'Name');
            if isempty(fig_nam)
                warning('export_fig:EmptyBookmark', 'Bookmark requested for figure with no name. Bookmark will be empty.');
            end
            add_bookmark(tmp_nam, fig_nam);
        end
        % Generate a pdf
        eps2pdf(tmp_nam, pdf_nam, 1, options.append, options.colourspace==2, options.quality);
    catch ex
        % Delete the eps
        delete(tmp_nam);
        rethrow(ex);
    end
    % Delete the eps
    delete(tmp_nam);
    if options.eps
        try
            % Generate an eps from the pdf
            pdf2eps(pdf_nam, [options.name '.eps']);
        catch ex
            if ~options.pdf
                % Delete the pdf
                delete(pdf_nam);
            end
            rethrow(ex);
        end
        if ~options.pdf
            % Delete the pdf
            delete(pdf_nam);
        end
    end
end
if cls
    % Close the created figure
    close(fig);
else
    % Reset the hardcopy mode
    set(fig, 'InvertHardcopy', old_mode);
    % Reset the axes limit and tick modes
    for a = 1:numel(Hlims)
        set(Hlims(a), 'XLimMode', Xlims{a}, 'YLimMode', Ylims{a}, 'ZLimMode', Zlims{a}, 'XTickMode', Xtick{a}, 'YTickMode', Ytick{a}, 'ZTickMode', Ztick{a});
    end
end
return
end % end func

function [fig, options] = parse_args(nout, varargin)
% Parse the input arguments
% Set the defaults
fig = get(0, 'CurrentFigure');
options = struct('name', 'export_fig_out', ...
                 'crop', true, ...
                 'transparent', false, ...
                 'renderer', 0, ... % 0: default, 1: OpenGL, 2: ZBuffer, 3: Painters
                 'pdf', false, ...
                 'eps', false, ...
                 'png', false, ...
                 'tif', false, ...
                 'jpg', false, ...
                 'bmp', false, ...
                 'colourspace', 0, ... % 0: RGB/gray, 1: CMYK, 2: gray
                 'append', false, ...
                 'im', nout == 1, ...
                 'alpha', nout == 2, ...
                 'aa_factor', 0, ...
                 'magnify', [], ...
                 'resolution', [], ...
                 'bookmark', false, ...
                 'quality', []);
native = false; % Set resolution to native of an image

% Go through the other arguments
for a = 1:nargin-1
    if all(ishandle(varargin{a}))
        fig = varargin{a};
    elseif ischar(varargin{a}) && ~isempty(varargin{a})
        if varargin{a}(1) == '-'
            switch lower(varargin{a}(2:end))
                case 'nocrop'
                    options.crop = false;
                case {'trans', 'transparent'}
                    options.transparent = true;
                case 'opengl'
                    options.renderer = 1;
                case 'zbuffer'
                    options.renderer = 2;
                case 'painters'
                    options.renderer = 3;
                case 'pdf'
                    options.pdf = true;
                case 'eps'
                    options.eps = true;
                case 'png'
                    options.png = true;
                case {'tif', 'tiff'}
                    options.tif = true;
                case {'jpg', 'jpeg'}
                    options.jpg = true;
                case 'bmp'
                    options.bmp = true;
                case 'rgb'
                    options.colourspace = 0;
                case 'cmyk'
                    options.colourspace = 1;
                case {'gray', 'grey'}
                    options.colourspace = 2;
                case {'a1', 'a2', 'a3', 'a4'}
                    options.aa_factor = str2double(varargin{a}(3));
                case 'append'
                    options.append = true;
                case 'bookmark'
                    options.bookmark = true;
                case 'native'
                    native = true;
                otherwise
                    val = str2double(regexp(varargin{a}, '(?<=-(m|M|r|R|q|Q))(\d*\.)?\d+(e-?\d+)?', 'match'));
                    if ~isscalar(val)
                        error('option %s not recognised', varargin{a});
                    end
                    switch lower(varargin{a}(2))
                        case 'm'
                            options.magnify = val;
                        case 'r'
                            options.resolution = val;
                        case 'q'
                            options.quality = max(val, 0);
                    end
            end
        else
            [p, options.name, ext] = fileparts(varargin{a});
            if ~isempty(p)
                options.name = [p filesep options.name];
            end
            switch lower(ext)
                case {'.tif', '.tiff'}
                    options.tif = true;
                case {'.jpg', '.jpeg'}
                    options.jpg = true;
                case '.png'
                    options.png = true;
                case '.bmp'
                    options.bmp = true;
                case '.eps'
                    options.eps = true;
                case '.pdf'
                    options.pdf = true;
                otherwise
                    options.name = varargin{a};
            end
        end
    end
end

% Set default anti-aliasing now we know the renderer
if options.aa_factor == 0
    options.aa_factor = 1 + 2 * (~using_hg2(fig) | (options.renderer == 3));
end

% Convert user dir '~' to full path
if numel(options.name) > 2 && options.name(1) == '~' && (options.name(2) == '/' || options.name(2) == '\')
    options.name = fullfile(char(java.lang.System.getProperty('user.home')), options.name(2:end));
end

% Compute the magnification and resolution
if isempty(options.magnify)
    if isempty(options.resolution)
        options.magnify = 1;
        options.resolution = 864;
    else
        options.magnify = options.resolution ./ get(0, 'ScreenPixelsPerInch');
    end
elseif isempty(options.resolution)
    options.resolution = 864;
end  

% Check we have a figure handle
if isempty(fig)
    error('No figure found');
end

% Set the default format
if ~isvector(options) && ~isbitmap(options)
    options.png = true;
end

% Check whether transparent background is wanted (old way)
if isequal(get(ancestor(fig(1), 'figure'), 'Color'), 'none')
    options.transparent = true;
end

% If requested, set the resolution to the native vertical resolution of the
% first suitable image found
if native && isbitmap(options)
    % Find a suitable image
    list = findobj(fig, 'Type', 'image', 'Tag', 'export_fig_native');
    if isempty(list)
        list = findobj(fig, 'Type', 'image', 'Visible', 'on');
    end
    for hIm = list(:)'
        % Check height is >= 2
        height = size(get(hIm, 'CData'), 1);
        if height < 2
            continue
        end
        % Account for the image filling only part of the axes, or vice
        % versa
        yl = get(hIm, 'YData');
        if isscalar(yl)
            yl = [yl(1)-0.5 yl(1)+height+0.5];
        else
            if ~diff(yl)
                continue
            end
            yl = yl + [-0.5 0.5] * (diff(yl) / (height - 1));
        end
        hAx = get(hIm, 'Parent');
        yl2 = get(hAx, 'YLim');
        % Find the pixel height of the axes
        oldUnits = get(hAx, 'Units');
        set(hAx, 'Units', 'pixels');
        pos = get(hAx, 'Position');
        set(hAx, 'Units', oldUnits);
        if ~pos(4)
            continue
        end
        % Found a suitable image
        % Account for stretch-to-fill being disabled
        pbar = get(hAx, 'PlotBoxAspectRatio');
        pos = min(pos(4), pbar(2)*pos(3)/pbar(1));
        % Set the magnification to give native resolution
        options.magnify = (height * diff(yl2)) / (pos * diff(yl));
        break
    end
end
return
end % end func

function A = downsize(A, factor)
% Downsample an image
if factor == 1
    % Nothing to do
    return
end
try
    % Faster, but requires image processing toolbox
    A = imresize(A, 1/factor, 'bilinear');
catch
    % No image processing toolbox - resize manually
    % Lowpass filter - use Gaussian as is separable, so faster
    % Compute the 1d Gaussian filter
    filt = (-factor-1:factor+1) / (factor * 0.6);
    filt = exp(-filt .* filt);
    % Normalize the filter
    filt = single(filt / sum(filt));
    % Filter the image
    padding = floor(numel(filt) / 2);
    for a = 1:size(A, 3)
        A(:,:,a) = conv2(filt, filt', single(A([ones(1, padding) 1:end repmat(end, 1, padding)],[ones(1, padding) 1:end repmat(end, 1, padding)],a)), 'valid');
    end
    % Subsample
    A = A(1+floor(mod(end-1, factor)/2):factor:end,1+floor(mod(end-1, factor)/2):factor:end,:);
end
return
end % end func

function A = rgb2grey(A)
A = cast(reshape(reshape(single(A), [], 3) * single([0.299; 0.587; 0.114]), size(A, 1), size(A, 2)), class(A));
return
end % end func

function A = check_greyscale(A)
% Check if the image is greyscale
if size(A, 3) == 3 && ...
        all(reshape(A(:,:,1) == A(:,:,2), [], 1)) && ...
        all(reshape(A(:,:,2) == A(:,:,3), [], 1))
    A = A(:,:,1); % Save only one channel for 8-bit output
end
return
end % end func

function [A, v] = crop_background(A, bcol)
% Map the foreground pixels
[h, w, c] = size(A);
if isscalar(bcol) && c > 1
    bcol = bcol(ones(1, c));
end
bail = false;
for l = 1:w
    for a = 1:c
        if ~all(A(:,l,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for r = w:-1:l
    for a = 1:c
        if ~all(A(:,r,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for t = 1:h
    for a = 1:c
        if ~all(A(t,:,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for b = h:-1:t
    for a = 1:c
        if ~all(A(b,:,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
% Crop the background, leaving one boundary pixel to avoid bleeding on
% resize
v = [max(t-1, 1) min(b+1, h) max(l-1, 1) min(r+1, w)];
A = A(v(1):v(2),v(3):v(4),:);
return
end % end func

function eps_remove_background(fname, count)
% Remove the background of an eps file
% Open the file
fh = fopen(fname, 'r+');
if fh == -1
    error('Not able to open file %s.', fname);
end
% Read the file line by line
while count
    % Get the next line
    l = fgets(fh);
    if isequal(l, -1)
        break; % Quit, no rectangle found
    end
    % Check if the line contains the background rectangle
    if isequal(regexp(l, ' *0 +0 +\d+ +\d+ +r[fe] *[\n\r]+', 'start'), 1)
        % Set the line to whitespace and quit
        l(1:regexp(l, '[\n\r]', 'start', 'once')-1) = ' ';
        fseek(fh, -numel(l), 0);
        fprintf(fh, l);
        % Reduce the count
        count = count - 1;
    end
end
% Close the file
fclose(fh);
return
end % end func

function b = isvector(options)
b = options.pdf || options.eps;
return
end % end func

function b = isbitmap(options)
b = options.png || options.tif || options.jpg || options.bmp || options.im || options.alpha;
return
end % end func

% Helper function
function A = make_cell(A)
if ~iscell(A)
    A = {A};
end
return
end % end func

function add_bookmark(fname, bookmark_text)
% Adds a bookmark to the temporary EPS file after %%EndPageSetup
% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Include standard pdfmark prolog to maximize compatibility
fstrm = strrep(fstrm, '%%BeginProlog', sprintf('%%%%BeginProlog\n/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse'));
% Add page bookmark
fstrm = strrep(fstrm, '%%EndPageSetup', sprintf('%%%%EndPageSetup\n[ /Title (%s) /OUT pdfmark',bookmark_text));

% Write out the updated file
fh = fopen(fname, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname);
end
try
    fwrite(fh, fstrm, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
return
end % end func

function fix_lines(fname, fname2)
%FIX_LINES  Improves the line style of eps files generated by print
%
% Examples:
%   fix_lines fname
%   fix_lines fname fname2
%
% This function improves the style of lines in eps files generated by
% MATLAB's print function, making them more similar to those seen on
% screen. Grid lines are also changed from a dashed style to a dotted
% style, for greater differentiation from dashed lines.
% 
% The function also places embedded fonts after the postscript header, in
% versions of MATLAB which place the fonts first (R2006b and earlier), in
% order to allow programs such as Ghostscript to find the bounding box
% information.
%
% IN:
%   fname - Name or path of source eps file.
%   fname2 - Name or path of destination eps file. Default: same as fname.

% Copyright: (C) Oliver Woodford, 2008-2010

% The idea of editing the EPS file to change line styles comes from Jiro
% Doke's FIXPSLINESTYLE (fex id: 17928)
% The idea of changing dash length with line width came from comments on
% fex id: 5743, but the implementation is mine :)

% Thank you to Sylvain Favrot for bringing the embedded font/bounding box
% interaction in older versions of MATLAB to my attention.
% Thank you to D Ko for bringing an error with eps files with tiff previews
% to my attention.
% Thank you to Laurence K for suggesting the check to see if the file was
% opened.

% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Move any embedded fonts after the postscript header
if strcmp(fstrm(1:15), '%!PS-AdobeFont-')
    % Find the start and end of the header
    ind = regexp(fstrm, '[\n\r]%!PS-Adobe-');
    [ind2 ind2] = regexp(fstrm, '[\n\r]%%EndComments[\n\r]+');
    % Put the header first
    if ~isempty(ind) && ~isempty(ind2) && ind(1) < ind2(1)
        fstrm = fstrm([ind(1)+1:ind2(1) 1:ind(1) ind2(1)+1:end]);
    end
end

% Make sure all line width commands come before the line style definitions,
% so that dash lengths can be based on the correct widths
% Find all line style sections
ind = [regexp(fstrm, '[\n\r]SO[\n\r]'),... % This needs to be here even though it doesn't have dots/dashes!
       regexp(fstrm, '[\n\r]DO[\n\r]'),...
       regexp(fstrm, '[\n\r]DA[\n\r]'),...
       regexp(fstrm, '[\n\r]DD[\n\r]')];
ind = sort(ind);
% Find line width commands
[ind2 ind3] = regexp(fstrm, '[\n\r]\d* w[\n\r]');
% Go through each line style section and swap with any line width commands
% near by
b = 1;
m = numel(ind);
n = numel(ind2);
for a = 1:m
    % Go forwards width commands until we pass the current line style
    while b <= n && ind2(b) < ind(a)
        b = b + 1;
    end
    if b > n
        % No more width commands
        break;
    end
    % Check we haven't gone past another line style (including SO!)
    if a < m && ind2(b) > ind(a+1)
        continue;
    end
    % Are the commands close enough to be confident we can swap them?
    if (ind2(b) - ind(a)) > 8
        continue;
    end
    % Move the line style command below the line width command
    fstrm(ind(a)+1:ind3(b)) = [fstrm(ind(a)+4:ind3(b)) fstrm(ind(a)+1:ind(a)+3)];
    b = b + 1;
end

% Find any grid line definitions and change to GR format
% Find the DO sections again as they may have moved
ind = int32(regexp(fstrm, '[\n\r]DO[\n\r]'));
if ~isempty(ind)
    % Find all occurrences of what are believed to be axes and grid lines
    ind2 = int32(regexp(fstrm, '[\n\r] *\d* *\d* *mt *\d* *\d* *L[\n\r]'));
    if ~isempty(ind2)
        % Now see which DO sections come just before axes and grid lines
        ind2 = repmat(ind2', [1 numel(ind)]) - repmat(ind, [numel(ind2) 1]);
        ind2 = any(ind2 > 0 & ind2 < 12); % 12 chars seems about right
        ind = ind(ind2);
        % Change any regions we believe to be grid lines to GR
        fstrm(ind+1) = 'G';
        fstrm(ind+2) = 'R';
    end
end

% Isolate line style definition section
first_sec = strfind(fstrm, '% line types:');
[second_sec remaining] = strtok(fstrm(first_sec+1:end), '/');
[remaining remaining] = strtok(remaining, '%');

% Define the new styles, including the new GR format
% Dot and dash lengths have two parts: a constant amount plus a line width
% variable amount. The constant amount comes after dpi2point, and the
% variable amount comes after currentlinewidth. If you want to change
% dot/dash lengths for a one particular line style only, edit the numbers
% in the /DO (dotted lines), /DA (dashed lines), /DD (dot dash lines) and
% /GR (grid lines) lines for the style you want to change.
new_style = {'/dom { dpi2point 1 currentlinewidth 0.08 mul add mul mul } bdef',... % Dot length macro based on line width
             '/dam { dpi2point 2 currentlinewidth 0.04 mul add mul mul } bdef',... % Dash length macro based on line width
             '/SO { [] 0 setdash 0 setlinecap } bdef',... % Solid lines
             '/DO { [1 dom 1.2 dom] 0 setdash 0 setlinecap } bdef',... % Dotted lines
             '/DA { [4 dam 1.5 dam] 0 setdash 0 setlinecap } bdef',... % Dashed lines
             '/DD { [1 dom 1.2 dom 4 dam 1.2 dom] 0 setdash 0 setlinecap } bdef',... % Dot dash lines
             '/GR { [0 dpi2point mul 4 dpi2point mul] 0 setdash 1 setlinecap } bdef'}; % Grid lines - dot spacing remains constant

if nargin < 2
    % Overwrite the input file
    fname2 = fname;
end

% Save the file with the section replaced
fh = fopen(fname2, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname2);
end
try
    fwrite(fh, fstrm(1:first_sec), 'char*1');
    fwrite(fh, second_sec, 'char*1');
    fprintf(fh, '%s\r', new_style{:});
    fwrite(fh, remaining, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
return
end % end func

%GHOSTSCRIPT  Calls a local GhostScript executable with the input command
%
% Example:
%   [status result] = ghostscript(cmd)
%
% Attempts to locate a ghostscript executable, finally asking the user to
% specify the directory ghostcript was installed into. The resulting path
% is stored for future reference.
% 
% Once found, the executable is called with the input command string.
%
% This function requires that you have Ghostscript installed on your
% system. You can download this from: http://www.ghostscript.com
%
% IN:
%   cmd - Command string to be passed into ghostscript.
%
% OUT:
%   status - 0 iff command ran without problem.
%   result - Output from ghostscript.

% Copyright: Oliver Woodford, 2009-2013

% Thanks to Jonas Dorn for the fix for the title of the uigetdir window on
% Mac OS.
% Thanks to Nathan Childress for the fix to the default location on 64-bit
% Windows systems.
% 27/4/11 - Find 64-bit Ghostscript on Windows. Thanks to Paul Durack and
% Shaun Kline for pointing out the issue
% 4/5/11 - Thanks to David Chorlian for pointing out an alternative
% location for gs on linux.
% 12/12/12 - Add extra executable name on Windows. Thanks to Ratish
% Punnoose for highlighting the issue.
% 28/6/13 - Fix error using GS 9.07 in Linux. Many thanks to Jannick
% Steinbring for proposing the fix.
% 24/10/13 - Fix error using GS 9.07 in Linux. Many thanks to Johannes
% for the fix.
% 23/01/2014 - Add full path to ghostscript.txt in warning. Thanks to Koen
% Vermeer for raising the issue.

function varargout = ghostscript(cmd)
% Initialize any required system calls before calling ghostscript
shell_cmd = '';
if isunix
    shell_cmd = 'export LD_LIBRARY_PATH=""; '; % Avoids an error on Linux with GS 9.07
end
if ismac
    shell_cmd = 'export DYLD_LIBRARY_PATH=""; ';  % Avoids an error on Mac with GS 9.07
end
% Call ghostscript
[varargout{1:nargout}] = system(sprintf('%s"%s" %s', shell_cmd, gs_path, cmd));
return
end % end func

function path_ = gs_path
% Return a valid path
% Start with the currently set path
path_ = user_string('ghostscript');
% Check the path works
if check_gs_path(path_)
    return
end
% Check whether the binary is on the path
if ispc
    bin = {'gswin32c.exe', 'gswin64c.exe', 'gs'};
else
    bin = {'gs'};
end
for a = 1:numel(bin)
    path_ = bin{a};
    if check_store_gs_path(path_)
        return
    end
end
% Search the obvious places
if ispc
    default_location = 'C:\Program Files\gs\';
    dir_list = dir(default_location);
    if isempty(dir_list)
        default_location = 'C:\Program Files (x86)\gs\'; % Possible location on 64-bit systems 
        dir_list = dir(default_location);
    end
    executable = {'\bin\gswin32c.exe', '\bin\gswin64c.exe'};
    ver_num = 0;
    % If there are multiple versions, use the newest
    for a = 1:numel(dir_list)
        ver_num2 = sscanf(dir_list(a).name, 'gs%g');
        if ~isempty(ver_num2) && ver_num2 > ver_num
            for b = 1:numel(executable)
                path2 = [default_location dir_list(a).name executable{b}];
                if exist(path2, 'file') == 2
                    path_ = path2;
                    ver_num = ver_num2;
                end
            end
        end
    end
    if check_store_gs_path(path_)
        return
    end
else
    executable = {'/usr/bin/gs', '/usr/local/bin/gs'};
    for a = 1:numel(executable)
        path_ = executable{a};
        if check_store_gs_path(path_)
            return
        end
    end
end
% Ask the user to enter the path
while 1
    if strncmp(computer, 'MAC', 3) % Is a Mac
        % Give separate warning as the uigetdir dialogue box doesn't have a
        % title
        uiwait(warndlg('Ghostscript not found. Please locate the program.'))
    end
    base = uigetdir('/', 'Ghostcript not found. Please locate the program.');
    if isequal(base, 0)
        % User hit cancel or closed window
        break;
    end
    base = [base filesep];
    bin_dir = {'', ['bin' filesep], ['lib' filesep]};
    for a = 1:numel(bin_dir)
        for b = 1:numel(bin)
            path_ = [base bin_dir{a} bin{b}];
            if exist(path_, 'file') == 2
                if check_store_gs_path(path_)
                    return
                end
            end
        end
    end
end
error('Ghostscript not found. Have you installed it from www.ghostscript.com?');
end % end func

function good = check_store_gs_path(path_)
% Check the path is valid
good = check_gs_path(path_);
if ~good
    return
end
% Update the current default path to the path found
if ~user_string('ghostscript', path_)
    warning('Path to ghostscript installation could not be saved. Enter it manually in %s.', fullfile(fileparts(which('user_string.m')), '.ignore', 'ghostscript.txt'));
    return
end
return
end % end func

function good = check_gs_path(path_)
% Check the path is valid
shell_cmd = '';
if ismac
    shell_cmd = 'export DYLD_LIBRARY_PATH=""; ';  % Avoids an error on Mac with GS 9.07
end
[good, message] = system(sprintf('%s"%s" -h', shell_cmd, path_));
good = good == 0;
return
end % end func

%IM2GIF Convert a multiframe image to an animated GIF file
%
% Examples:
%   im2gif infile
%   im2gif infile outfile
%   im2gif(A, outfile)
%   im2gif(..., '-nocrop')
%   im2gif(..., '-nodither')
%   im2gif(..., '-ncolors', n)
%   im2gif(..., '-loops', n)
%   im2gif(..., '-delay', n) 
%   
% This function converts a multiframe image to an animated GIF.
%
% To create an animation from a series of figures, export to a multiframe
% TIFF file using export_fig, then convert to a GIF, as follows:
%
%    for a = 2 .^ (3:6)
%       peaks(a);
%       export_fig test.tif -nocrop -append
%    end
%    im2gif('test.tif', '-delay', 0.5);
%
%IN:
%   infile - string containing the name of the input image.
%   outfile - string containing the name of the output image (must have the
%             .gif extension). Default: infile, with .gif extension.
%   A - HxWxCxN array of input images, stacked along fourth dimension, to
%       be converted to gif.
%   -nocrop - option indicating that the borders of the output are not to
%             be cropped.
%   -nodither - option indicating that dithering is not to be used when
%               converting the image.
%   -ncolors - option pair, the value of which indicates the maximum number
%              of colors the GIF can have. This can also be a quantization
%              tolerance, between 0 and 1. Default/maximum: 256.
%   -loops - option pair, the value of which gives the number of times the
%            animation is to be looped. Default: 65535.
%   -delay - option pair, the value of which gives the time, in seconds,
%            between frames. Default: 1/15.

% Copyright (C) Oliver Woodford 2011

function im2gif(A, varargin)

% Parse the input arguments
[A, options] = parse_args2(A, varargin{:});

if options.crop ~= 0
    % Crop
    A = crop_borders(A);
end

% Convert to indexed image
[h, w, c, n] = size(A);
A = reshape(permute(A, [1 2 4 3]), h, w*n, c);
map = unique(reshape(A, h*w*n, c), 'rows');
if size(map, 1) > 256
    dither_str = {'dither', 'nodither'};
    dither_str = dither_str{1+(options.dither==0)};
    if options.ncolors <= 1
        [B, map] = rgb2ind(A, options.ncolors, dither_str);
        if size(map, 1) > 256
            [B, map] = rgb2ind(A, 256, dither_str);
        end
    else
        [B, map] = rgb2ind(A, min(round(options.ncolors), 256), dither_str);
    end
else
    if max(map(:)) > 1
        map = double(map) / 255;
        A = double(A) / 255;
    end
    B = rgb2ind(im2double(A), map);
end
B = reshape(B, h, w, 1, n);

% Bug fix to rgb2ind
map(B(1)+1,:) = im2double(A(1,1,:));

% Save as a gif
imwrite(B, map, options.outfile, 'LoopCount', round(options.loops(1)), 'DelayTime', options.delay);
return
end % end func

%% Parse the input arguments
function [A, options] = parse_args2(A, varargin)
% Set the defaults
options = struct('outfile', '', ...
                 'dither', true, ...
                 'crop', true, ...
                 'ncolors', 256, ...
                 'loops', 65535, ...
                 'delay', 1/15);

% Go through the arguments
a = 0;
n = numel(varargin);
while a < n
    a = a + 1;
    if ischar(varargin{a}) && ~isempty(varargin{a})
        if varargin{a}(1) == '-'
            opt = lower(varargin{a}(2:end));
            switch opt
                case 'nocrop'
                    options.crop = false;
                case 'nodither'
                    options.dither = false;
                otherwise
                    if ~isfield(options, opt)
                        error('Option %s not recognized', varargin{a});
                    end
                    a = a + 1;
                    if ischar(varargin{a}) && ~ischar(options.(opt))
                        options.(opt) = str2double(varargin{a});
                    else
                        options.(opt) = varargin{a};
                    end
            end
        else
            options.outfile = varargin{a};
        end
    end
end

if isempty(options.outfile)
    if ~ischar(A)
        error('No output filename given.');
    end
    % Generate the output filename from the input filename
    [path, outfile] = fileparts(A);
    options.outfile = fullfile(path, [outfile '.gif']);
end

if ischar(A)
    % Read in the image
    A = imread_rgb(A);
end
return
end % end func

%% Read image to uint8 rgb array
function [A, alpha] = imread_rgb(name)
% Get file info
info = imfinfo(name);
% Special case formats
switch lower(info(1).Format)
    case 'gif'
        [A, map] = imread(name, 'frames', 'all');
        if ~isempty(map)
            map = uint8(map * 256 - 0.5); % Convert to uint8 for storage
            A = reshape(map(uint32(A)+1,:), [size(A) size(map, 2)]); % Assume indexed from 0
            A = permute(A, [1 2 5 4 3]);
        end
    case {'tif', 'tiff'}
        A = cell(numel(info), 1);
        for a = 1:numel(A)
            [A{a}, map] = imread(name, 'Index', a, 'Info', info);
            if ~isempty(map)
                map = uint8(map * 256 - 0.5); % Convert to uint8 for storage
                A{a} = reshape(map(uint32(A{a})+1,:), [size(A) size(map, 2)]); % Assume indexed from 0
            end
            if size(A{a}, 3) == 4
                % TIFF in CMYK colourspace - convert to RGB
                if isfloat(A{a})
                    A{a} = A{a} * 255;
                else
                    A{a} = single(A{a});
                end
                A{a} = 255 - A{a};
                A{a}(:,:,4) = A{a}(:,:,4) / 255;
                A{a} = uint8(A(:,:,1:3) .* A{a}(:,:,[4 4 4]));
            end
        end
        A = cat(4, A{:});
    otherwise
        [A, map, alpha] = imread(name);
        A = A(:,:,:,1); % Keep only first frame of multi-frame files
        if ~isempty(map)
            map = uint8(map * 256 - 0.5); % Convert to uint8 for storage
            A = reshape(map(uint32(A)+1,:), [size(A) size(map, 2)]); % Assume indexed from 0
        elseif size(A, 3) == 4
            % Assume 4th channel is an alpha matte
            alpha = A(:,:,4);
            A = A(:,:,1:3);
        end
end
return
end % end func

%% Crop the borders
function A = crop_borders(A)
[h, w, c, n] = size(A);
bcol = A(ceil(end/2),1,:,1);
bail = false;
for l = 1:w
    for a = 1:c
        if ~all(col(A(:,l,a,:)) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bcol = A(ceil(end/2),w,:,1);
bail = false;
for r = w:-1:l
    for a = 1:c
        if ~all(col(A(:,r,a,:)) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bcol = A(1,ceil(end/2),:,1);
bail = false;
for t = 1:h
    for a = 1:c
        if ~all(col(A(t,:,a,:)) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bcol = A(h,ceil(end/2),:,1);
bail = false;
for b = h:-1:t
    for a = 1:c
        if ~all(col(A(b,:,a,:)) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
A = A(t:b,l:r,:,:);
return
end % end func

function A = col(A)
A = A(:);
return
end % end func


%ISOLATE_AXES Isolate the specified axes in a figure on their own
%
% Examples:
%   fh = isolate_axes(ah)
%   fh = isolate_axes(ah, vis)
%
% This function will create a new figure containing the axes/uipanels
% specified, and also their associated legends and colorbars. The objects
% specified must all be in the same figure, but they will generally only be
% a subset of the objects in the figure.
%
% IN:
%    ah - An array of axes and uipanel handles, which must come from the
%         same figure.
%    vis - A boolean indicating whether the new figure should be visible.
%          Default: false.
%
% OUT:
%    fh - The handle of the created figure.

% Copyright (C) Oliver Woodford 2011-2013

% Thank you to Rosella Blatt for reporting a bug to do with axes in GUIs
% 16/3/2012 Moved copyfig to its own function. Thanks to Bob Fratantonio
% for pointing out that the function is also used in export_fig.m.
% 12/12/12 - Add support for isolating uipanels. Thanks to michael for
% suggesting it.
% 08/10/13 - Bug fix to allchildren suggested by Will Grant (many thanks!).
% 05/12/13 - Bug fix to axes having different units. Thanks to Remington
% Reid for reporting the issue.

function fh = isolate_axes(ah, vis)
% Make sure we have an array of handles
if ~all(ishandle(ah))
    error('ah must be an array of handles');
end
% Check that the handles are all for axes or uipanels, and are all in the same figure
fh = ancestor(ah(1), 'figure');
nAx = numel(ah);
for a = 1:nAx
    if ~ismember(get(ah(a), 'Type'), {'axes', 'uipanel'})
        error('All handles must be axes or uipanel handles.');
    end
    if ~isequal(ancestor(ah(a), 'figure'), fh)
        error('Axes must all come from the same figure.');
    end
end
% Tag the objects so we can find them in the copy
old_tag = get(ah, 'Tag');
if nAx == 1
    old_tag = {old_tag};
end
set(ah, 'Tag', 'ObjectToCopy');
% Create a new figure exactly the same as the old one
fh = copyfig(fh); %copyobj(fh, 0);
if nargin < 2 || ~vis
    set(fh, 'Visible', 'off');
end
% Reset the object tags
for a = 1:nAx
    set(ah(a), 'Tag', old_tag{a});
end
% Find the objects to save
ah = findall(fh, 'Tag', 'ObjectToCopy');
if numel(ah) ~= nAx
    close(fh);
    error('Incorrect number of objects found.');
end
% Set the axes tags to what they should be
for a = 1:nAx
    set(ah(a), 'Tag', old_tag{a});
end
% Keep any legends and colorbars which overlap the subplots
lh = findall(fh, 'Type', 'axes', '-and', {'Tag', 'legend', '-or', 'Tag', 'Colorbar'});
nLeg = numel(lh);
if nLeg > 0
    set([ah(:); lh(:)], 'Units', 'normalized');
    ax_pos = get(ah, 'OuterPosition');
    if nAx > 1
        ax_pos = cell2mat(ax_pos(:));
    end
    ax_pos(:,3:4) = ax_pos(:,3:4) + ax_pos(:,1:2);
    leg_pos = get(lh, 'OuterPosition');
    if nLeg > 1;
        leg_pos = cell2mat(leg_pos);
    end
    leg_pos(:,3:4) = leg_pos(:,3:4) + leg_pos(:,1:2);
    ax_pos = shiftdim(ax_pos, -1);
    % Overlap test
    M = bsxfun(@lt, leg_pos(:,1), ax_pos(:,:,3)) & ...
        bsxfun(@lt, leg_pos(:,2), ax_pos(:,:,4)) & ...
        bsxfun(@gt, leg_pos(:,3), ax_pos(:,:,1)) & ...
        bsxfun(@gt, leg_pos(:,4), ax_pos(:,:,2));
    ah = [ah; lh(any(M, 2))];
end
% Get all the objects in the figure
axs = findall(fh);
% Delete everything except for the input objects and associated items
delete(axs(~ismember(axs, [ah; allchildren(ah); allancestors(ah)])));
return
end % end func

function ah = allchildren(ah)
ah = findall(ah);
if iscell(ah)
    ah = cell2mat(ah);
end
ah = ah(:);
return
end % end func

function ph = allancestors(ah)
ph = [];
for a = 1:numel(ah)
    h = get(ah(a), 'parent');
    while h ~= 0
        ph = [ph; h];
        h = get(h, 'parent');
    end
end
return
end % end func

%PDF2EPS  Convert a pdf file to eps format using pdftops
%
% Examples:
%   pdf2eps source dest
%
% This function converts a pdf file to eps format.
%
% This function requires that you have pdftops, from the Xpdf suite of
% functions, installed on your system. This can be downloaded from:
% http://www.foolabs.com/xpdf  
%
%IN:
%   source - filename of the source pdf file to convert. The filename is
%            assumed to already have the extension ".pdf".
%   dest - filename of the destination eps file. The filename is assumed to
%          already have the extension ".eps".

% Copyright (C) Oliver Woodford 2009-2010

% Thanks to Aldebaro Klautau for reporting a bug when saving to
% non-existant directories.

function pdf2eps(source, dest)
% Construct the options string for pdftops
options = ['-q -paper match -eps -level2 "' source '" "' dest '"'];
% Convert to eps using pdftops
[status, message] = pdftops(options);
% Check for error
if status
    % Report error
    if isempty(message)
        error('Unable to generate eps. Check destination directory is writable.');
    else
        error(message);
    end
end
% Fix the DSC error created by pdftops
fid = fopen(dest, 'r+');
if fid == -1
    % Cannot open the file
    return
end
fgetl(fid); % Get the first line
str = fgetl(fid); % Get the second line
if strcmp(str(1:min(13, end)), '% Produced by')
    fseek(fid, -numel(str)-1, 'cof');
    fwrite(fid, '%'); % Turn ' ' into '%'
end
fclose(fid);
return
end % end func

function varargout = pdftops(cmd)
%PDFTOPS  Calls a local pdftops executable with the input command
%
% Example:
%   [status result] = pdftops(cmd)
%
% Attempts to locate a pdftops executable, finally asking the user to
% specify the directory pdftops was installed into. The resulting path is
% stored for future reference.
% 
% Once found, the executable is called with the input command string.
%
% This function requires that you have pdftops (from the Xpdf package)
% installed on your system. You can download this from:
% http://www.foolabs.com/xpdf
%
% IN:
%   cmd - Command string to be passed into pdftops.
%
% OUT:
%   status - 0 iff command ran without problem.
%   result - Output from pdftops.

% Copyright: Oliver Woodford, 2009-2010

% Thanks to Jonas Dorn for the fix for the title of the uigetdir window on
% Mac OS.
% Thanks to Christoph Hertel for pointing out a bug in check_xpdf_path
% under linux.
% 23/01/2014 - Add full path to pdftops.txt in warning.

% Call pdftops
[varargout{1:nargout}] = system(sprintf('"%s" %s', xpdf_path, cmd));
return
end % end func

function path_ = xpdf_path
% Return a valid path
% Start with the currently set path
path_ = user_string('pdftops');
% Check the path works
if check_xpdf_path(path_)
    return
end
% Check whether the binary is on the path
if ispc
    bin = 'pdftops.exe';
else
    bin = 'pdftops';
end
if check_store_xpdf_path(bin)
    path_ = bin;
    return
end
% Search the obvious places
if ispc
    path_ = 'C:\Program Files\xpdf\pdftops.exe';
else
    path_ = '/usr/local/bin/pdftops';
end
if check_store_xpdf_path(path_)
    return
end
% Ask the user to enter the path
while 1
    if strncmp(computer,'MAC',3) % Is a Mac
        % Give separate warning as the uigetdir dialogue box doesn't have a
        % title
        uiwait(warndlg('Pdftops not found. Please locate the program, or install xpdf-tools from http://users.phg-online.de/tk/MOSXS/.'))
    end
    base = uigetdir('/', 'Pdftops not found. Please locate the program.');
    if isequal(base, 0)
        % User hit cancel or closed window
        break;
    end
    base = [base filesep];
    bin_dir = {'', ['bin' filesep], ['lib' filesep]};
    for a = 1:numel(bin_dir)
        path_ = [base bin_dir{a} bin];
        if exist(path_, 'file') == 2
            break;
        end
    end
    if check_store_xpdf_path(path_)
        return
    end
end
error('pdftops executable not found.');
end % end func

function good = check_store_xpdf_path(path_)
% Check the path is valid
good = check_xpdf_path(path_);
if ~good
    return
end
% Update the current default path to the path found
if ~user_string('pdftops', path_)
    warning('Path to pdftops executable could not be saved. Enter it manually in %s.', fullfile(fileparts(which('user_string.m')), '.ignore', 'pdftops.txt'));
    return
end
return
end % end func

function good = check_xpdf_path(path_)
% Check the path is valid
[good, message] = system(sprintf('"%s" -h', path_));
% system returns good = 1 even when the command runs
% Look for something distinct in the help text
good = ~isempty(strfind(message, 'PostScript'));
return
end % end func

%PRINT2ARRAY  Exports a figure to an image array
%
% Examples:
%   A = print2array
%   A = print2array(figure_handle)
%   A = print2array(figure_handle, resolution)
%   A = print2array(figure_handle, resolution, renderer)
%   [A bcol] = print2array(...)
%
% This function outputs a bitmap image of the given figure, at the desired
% resolution.
%
% If renderer is '-painters' then ghostcript needs to be installed. This
% can be downloaded from: http://www.ghostscript.com
%
% IN:
%   figure_handle - The handle of the figure to be exported. Default: gcf.
%   resolution - Resolution of the output, as a factor of screen
%                resolution. Default: 1.
%   renderer - string containing the renderer paramater to be passed to
%              print. Default: '-opengl'.
%
% OUT:
%   A - MxNx3 uint8 image of the figure.
%   bcol - 1x3 uint8 vector of the background color

% Copyright (C) Oliver Woodford 2008-2012

% 05/09/11: Set EraseModes to normal when using opengl or zbuffer
%           renderers. Thanks to Pawel Kocieniewski for reporting the
%           issue.
% 21/09/11: Bug fix: unit8 -> uint8! Thanks to Tobias Lamour for reporting
%           the issue.
% 14/11/11: Bug fix: stop using hardcopy(), as it interfered with figure
%           size and erasemode settings. Makes it a bit slower, but more
%           reliable. Thanks to Phil Trinh and Meelis Lootus for reporting
%           the issues.
% 09/12/11: Pass font path to ghostscript.
% 27/01/12: Bug fix affecting painters rendering tall figures. Thanks to
%           Ken Campbell for reporting it.
% 03/04/12: Bug fix to median input. Thanks to Andy Matthews for reporting
%           it.
% 26/10/12: Set PaperOrientation to portrait. Thanks to Michael Watts for
%           reporting the issue.

function [A, bcol] = print2array(fig, res, renderer)
% Generate default input arguments, if needed
if nargin < 2
    res = 1;
    if nargin < 1
        fig = gcf;
    end
end
% Warn if output is large
old_mode = get(fig, 'Units');
set(fig, 'Units', 'pixels');
px = get(fig, 'Position');
set(fig, 'Units', old_mode);
npx = prod(px(3:4)*res)/1e6;
if npx > 30
    % 30M pixels or larger!
    warning('MATLAB:LargeImage', 'print2array generating a %.1fM pixel image. This could be slow and might also cause memory problems.', npx);
end
% Retrieve the background colour
bcol = get(fig, 'Color');
% Set the resolution parameter
res_str = ['-r' num2str(ceil(get(0, 'ScreenPixelsPerInch')*res))];
% Generate temporary file name
tmp_nam = [tempname '.tif'];
if nargin > 2 && strcmp(renderer, '-painters')
    % Print to eps file
    tmp_eps = [tempname '.eps'];
    print2eps(tmp_eps, fig, renderer, '-loose');
    try
        % Initialize the command to export to tiff using ghostscript
        cmd_str = ['-dEPSCrop -q -dNOPAUSE -dBATCH ' res_str ' -sDEVICE=tiff24nc'];
        % Set the font path
        fp = font_path();
        if ~isempty(fp)
            cmd_str = [cmd_str ' -sFONTPATH="' fp '"'];
        end
        % Add the filenames
        cmd_str = [cmd_str ' -sOutputFile="' tmp_nam '" "' tmp_eps '"'];
        % Execute the ghostscript command
        ghostscript(cmd_str);
    catch me
        % Delete the intermediate file
        delete(tmp_eps);
        rethrow(me);
    end
    % Delete the intermediate file
    delete(tmp_eps);
    % Read in the generated bitmap
    A = imread(tmp_nam);
    % Delete the temporary bitmap file
    delete(tmp_nam);
    % Set border pixels to the correct colour
    if isequal(bcol, 'none')
        bcol = [];
    elseif isequal(bcol, [1 1 1])
        bcol = uint8([255 255 255]);
    else
        for l = 1:size(A, 2)
            if ~all(reshape(A(:,l,:) == 255, [], 1))
                break;
            end
        end
        for r = size(A, 2):-1:l
            if ~all(reshape(A(:,r,:) == 255, [], 1))
                break;
            end
        end
        for t = 1:size(A, 1)
            if ~all(reshape(A(t,:,:) == 255, [], 1))
                break;
            end
        end
        for b = size(A, 1):-1:t
            if ~all(reshape(A(b,:,:) == 255, [], 1))
                break;
            end
        end
        bcol = uint8(median(single([reshape(A(:,[l r],:), [], size(A, 3)); reshape(A([t b],:,:), [], size(A, 3))]), 1));
        for c = 1:size(A, 3)
            A(:,[1:l-1, r+1:end],c) = bcol(c);
            A([1:t-1, b+1:end],:,c) = bcol(c);
        end
    end
else
    if nargin < 3
        renderer = '-opengl';
    end
    err = false;
    % Set paper size
    old_pos_mode = get(fig, 'PaperPositionMode');
    old_orientation = get(fig, 'PaperOrientation');
    set(fig, 'PaperPositionMode', 'auto', 'PaperOrientation', 'portrait');
    try
        % Print to tiff file
        print(fig, renderer, res_str, '-dtiff', tmp_nam);
        % Read in the printed file
        A = imread(tmp_nam);
        % Delete the temporary file
        delete(tmp_nam);
    catch ex
        err = true;
    end
    % Reset paper size
    set(fig, 'PaperPositionMode', old_pos_mode, 'PaperOrientation', old_orientation);
    % Throw any error that occurred
    if err
        rethrow(ex);
    end
    % Set the background color
    if isequal(bcol, 'none')
        bcol = [];
    else
        bcol = bcol * 255;
        if isequal(bcol, round(bcol))
            bcol = uint8(bcol);
        else
            bcol = squeeze(A(1,1,:));
        end
    end
end
% Check the output size is correct
if isequal(res, round(res))
    px = [px([4 3])*res 3];
    if ~isequal(size(A), px)
        % Correct the output size
        A = A(1:min(end,px(1)),1:min(end,px(2)),:);
    end
end
return
end % end func


%PRINT2EPS  Prints figures to eps with improved line styles
%
% Examples:
%   print2eps filename
%   print2eps(filename, fig_handle)
%   print2eps(filename, fig_handle, options)
%
% This function saves a figure as an eps file, with two improvements over
% MATLAB's print command. First, it improves the line style, making dashed
% lines more like those on screen and giving grid lines their own dotted
% style. Secondly, it substitutes original font names back into the eps
% file, where these have been changed by MATLAB, for up to 11 different
% fonts.
%
%IN:
%   filename - string containing the name (optionally including full or
%              relative path) of the file the figure is to be saved as. A
%              ".eps" extension is added if not there already. If a path is
%              not specified, the figure is saved in the current directory.
%   fig_handle - The handle of the figure to be saved. Default: gcf.
%   options - Additional parameter strings to be passed to print.

% Copyright (C) Oliver Woodford 2008-2014

% The idea of editing the EPS file to change line styles comes from Jiro
% Doke's FIXPSLINESTYLE (fex id: 17928)
% The idea of changing dash length with line width came from comments on
% fex id: 5743, but the implementation is mine :)

% 14/11/2011: Fix a MATLAB bug rendering black or white text incorrectly.
%             Thanks to Mathieu Morlighem for reporting the issue and
%             obtaining a fix from TMW.
% 08/12/11: Added ability to correct fonts. Several people have requested
%           this at one time or another, and also pointed me to printeps
%           (fex id: 7501), so thank you to them. My implementation (which
%           was not inspired by printeps - I'd already had the idea for my
%           approach) goes slightly further in that it allows multiple
%           fonts to be swapped.
% 14/12/11: Fix bug affecting font names containing spaces. Thanks to David
%           Szwer for reporting the issue.
% 25/01/12: Add a font not to be swapped. Thanks to Anna Rafferty and Adam
%           Jackson for reporting the issue. Also fix a bug whereby using a
%           font alias can lead to another font being swapped in.
% 10/04/12: Make the font swapping case insensitive.
% 26/10/12: Set PaperOrientation to portrait. Thanks to Michael Watts for
%           reporting the issue.
% 26/10/12: Fix issue to do with swapping fonts changing other fonts and
%           sizes we don't want, due to listeners. Thanks to Malcolm Hudson
%           for reporting the issue.
% 22/03/13: Extend font swapping to axes labels. Thanks to Rasmus Ischebeck
%           for reporting the issue.
% 23/07/13: Bug fix to font swapping. Thank to George for reporting the
%           issue.
% 13/08/13: Fix MATLAB feature of not exporting white lines correctly.
%           Thanks to Sebastian Heßlinger for reporting it.

function print2eps(name, fig, varargin)
options = {'-depsc2'};
if nargin < 2
    fig = gcf;
elseif nargin > 2
    options = [options varargin];
end
% Construct the filename
if numel(name) < 5 || ~strcmpi(name(end-3:end), '.eps')
    name = [name '.eps']; % Add the missing extension
end
% Set paper size
old_pos_mode = get(fig, 'PaperPositionMode');
old_orientation = get(fig, 'PaperOrientation');
set(fig, 'PaperPositionMode', 'auto', 'PaperOrientation', 'portrait');
% Find all the used fonts in the figure
font_handles = findall(fig, '-property', 'FontName');
fonts = get(font_handles, 'FontName');
if ~iscell(fonts)
    fonts = {fonts};
end
% Map supported font aliases onto the correct name
fontsl = lower(fonts);
for a = 1:numel(fonts)
    f = fontsl{a};
    f(f==' ') = [];
    switch f
        case {'times', 'timesnewroman', 'times-roman'}
            fontsl{a} = 'times-roman';
        case {'arial', 'helvetica'}
            fontsl{a} = 'helvetica';
        case {'newcenturyschoolbook', 'newcenturyschlbk'}
            fontsl{a} = 'newcenturyschlbk';
        otherwise
    end
end
fontslu = unique(fontsl);
% Determine the font swap table
matlab_fonts = {'Helvetica', 'Times-Roman', 'Palatino', 'Bookman', 'Helvetica-Narrow', 'Symbol', ...
                'AvantGarde', 'NewCenturySchlbk', 'Courier', 'ZapfChancery', 'ZapfDingbats'};
matlab_fontsl = lower(matlab_fonts);
require_swap = find(~ismember(fontslu, matlab_fontsl));
unused_fonts = find(~ismember(matlab_fontsl, fontslu));
font_swap = cell(3, min(numel(require_swap), numel(unused_fonts)));
fonts_new = fonts;
for a = 1:size(font_swap, 2)
    font_swap{1,a} = find(strcmp(fontslu{require_swap(a)}, fontsl));
    font_swap{2,a} = matlab_fonts{unused_fonts(a)};
    font_swap{3,a} = fonts{font_swap{1,a}(1)};
    fonts_new(font_swap{1,a}) = {font_swap{2,a}};
end
% Swap the fonts
if ~isempty(font_swap)
    fonts_size = get(font_handles, 'FontSize');
    if iscell(fonts_size)
        fonts_size = cell2mat(fonts_size);
    end
    M = false(size(font_handles));
    % Loop because some changes may not stick first time, due to listeners
    c = 0;
    update = zeros(1000, 1);
    for b = 1:10 % Limit number of loops to avoid infinite loop case
        for a = 1:numel(M)
            M(a) = ~isequal(get(font_handles(a), 'FontName'), fonts_new{a}) || ~isequal(get(font_handles(a), 'FontSize'), fonts_size(a));
            if M(a)
                set(font_handles(a), 'FontName', fonts_new{a}, 'FontSize', fonts_size(a));
                c = c + 1;
                update(c) = a;
            end
        end
        if ~any(M)
            break;
        end
    end
    % Compute the order to revert fonts later, without the need of a loop
    [update, M] = unique(update(1:c));
    [M, M] = sort(M);
    update = reshape(update(M), 1, []);
end
% MATLAB bug fix - black and white text can come out inverted sometimes
% Find the white and black text
white_text_handles = findobj(fig, 'Type', 'text');
M = get(white_text_handles, 'Color');
if iscell(M)
    M = cell2mat(M);
end
M = sum(M, 2);
black_text_handles = white_text_handles(M == 0);
white_text_handles = white_text_handles(M == 3);
% Set the font colors slightly off their correct values
set(black_text_handles, 'Color', [0 0 0] + eps);
set(white_text_handles, 'Color', [1 1 1] - eps);
% MATLAB bug fix - white lines can come out funny sometimes
% Find the white lines
white_line_handles = findobj(fig, 'Type', 'line');
M = get(white_line_handles, 'Color');
if iscell(M)
    M = cell2mat(M);
end
white_line_handles = white_line_handles(sum(M, 2) == 3);
% Set the line color slightly off white
set(white_line_handles, 'Color', [1 1 1] - 0.00001);
% Print to eps file
print(fig, options{:}, name);
% Reset the font and line colors
set(black_text_handles, 'Color', [0 0 0]);
set(white_text_handles, 'Color', [1 1 1]);
set(white_line_handles, 'Color', [1 1 1]);
% Reset paper size
set(fig, 'PaperPositionMode', old_pos_mode, 'PaperOrientation', old_orientation);
% Correct the fonts
if ~isempty(font_swap)
    % Reset the font names in the figure
    for a = update
        set(font_handles(a), 'FontName', fonts{a}, 'FontSize', fonts_size(a));
    end
    % Replace the font names in the eps file
    font_swap = font_swap(2:3,:);
    try
        swap_fonts(name, font_swap{:});
    catch
        warning('swap_fonts() failed. This is usually because the figure contains a large number of patch objects. Consider exporting to a bitmap format in this case.');
        return
    end
end
if using_hg2(fig)
    % Move the bounding box to the top of the file
    try
        move_bb(name);
    catch
        warning('move_bb() failed. This is usually because the figure contains a large number of patch objects. Consider exporting to a bitmap format in this case.');
    end
else
    % Fix the line styles
    try
        fix_lines(name);
    catch
        warning('fix_lines() failed. This is usually because the figure contains a large number of patch objects. Consider exporting to a bitmap format in this case.');
    end
end
end % end func

function swap_fonts(fname, varargin)
% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Replace the font names
for a = 1:2:numel(varargin)
    %fstrm = regexprep(fstrm, [varargin{a} '-?[a-zA-Z]*\>'], varargin{a+1}(~isspace(varargin{a+1})));
    fstrm = regexprep(fstrm, varargin{a}, varargin{a+1}(~isspace(varargin{a+1})));
end

% Write out the updated file
fh = fopen(fname, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname2);
end
try
    fwrite(fh, fstrm, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
end % end func

function move_bb(fname)
% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Find the bounding box
[s, e] = regexp(fstrm, '%%BoundingBox: [\w\s()]*%%');
if numel(s) == 2
    fstrm = fstrm([1:s(1)-1 s(2):e(2)-2 e(1)-1:s(2)-1 e(2)-1:end]);
end

% Write out the updated file
fh = fopen(fname, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname2);
end
try
    fwrite(fh, fstrm, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
end % end func

%USER_STRING  Get/set a user specific string
%
% Examples:
%   string = user_string(string_name)
%   saved = user_string(string_name, new_string)
%
% Function to get and set a string in a system or user specific file. This
% enables, for example, system specific paths to binaries to be saved.
%
% IN:
%   string_name - String containing the name of the string required. The
%                 string is extracted from a file called (string_name).txt,
%                 stored in the same directory as user_string.m.
%   new_string - The new string to be saved under the name given by
%                string_name.
%
% OUT:
%   string - The currently saved string. Default: ''.
%   saved - Boolean indicating whether the save was succesful

% Copyright (C) Oliver Woodford 2011-2013

% This method of saving paths avoids changing .m files which might be in a
% version control system. Instead it saves the user dependent paths in
% separate files with a .txt extension, which need not be checked in to
% the version control system. Thank you to Jonas Dorn for suggesting this
% approach.

% 10/01/2013 - Access files in text, not binary mode, as latter can cause
% errors. Thanks to Christian for pointing this out.

function string = user_string(string_name, string)
if ~ischar(string_name)
    error('string_name must be a string.');
end
% Create the full filename
string_name = fullfile(fileparts(mfilename('fullpath')), '.ignore', [string_name '.txt']);
if nargin > 1
    % Set string
    if ~ischar(string)
        error('new_string must be a string.');
    end
    % Make sure the save directory exists
    dname = fileparts(string_name);
    if ~exist(dname, 'dir')
        % Create the directory
        try
            if ~mkdir(dname)                
                string = false;
                return
            end
        catch
            string = false;
            return
        end
        % Make it hidden
        try
            fileattrib(dname, '+h');
        catch
        end
    end
    % Write the file
    fid = fopen(string_name, 'wt');
    if fid == -1
        string = false;
        return
    end
    try
        fprintf(fid, '%s', string);
    catch
        fclose(fid);
        string = false;
        return
    end
    fclose(fid);
    string = true;
else
    % Get string
    fid = fopen(string_name, 'rt');
    if fid == -1
        string = '';
        return
    end
    string = fgetl(fid);
    fclose(fid);
end
return
end % end func

%USING_HG2 Determine if the HG2 graphics pipeline is used
%
%   tf = using_hg2(fig)
%
%IN:
%   fig - handle to the figure in question.
%
%OUT:
%   tf - boolean indicating whether the HG2 graphics pipeline is being used
%        (true) or not (false).

function tf = using_hg2(fig)
try
    tf = ~graphicsversion(fig, 'handlegraphics');
catch
    tf = false;
end
end % end func
% the end of export_fig functions
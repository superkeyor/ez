classdef ez
    % author=jerryzhujian9@gmail.com, June 15 2014, 07:59:26 PM CDT
    % usage: 
    % add this file to search path of matlab (e.g. put in userpath)
    % import ez.* GetDir()
    % or ez.method without import: ez.GetDir()
    %
    % help method to see more information
    %       showhelp, setdefault
    %       clear(), clean(), view(var)
    %
    %       ifelse(test,s1,s2)
    %
    %       sleep([seconds])
    %
    %       error(msg), print(sth), pprint(sth[, color])
    %       writeline(line[,file]), logon, logoff
    %
    %       moment()
    %
    %       cwd(), pwd(), csd(), csf(), parentdir(path) pr(), whichdir(mfilename)
    %       isdirlike(path), isfilelike(path), 
    %       isdir(path), isfile(path), exists(path)
    %       abspath(), addpath(path), splitpath(path) sp(), joinpath(path1, path2) jp(), trimdir(path), cd(path)
    %       stepfolder(step)
    % 
    %       typeof(sth), type(sth), str(sth), num(sth), len(sth)
    %       ls([[path, ]regex, fullpath, dotfile]), fls([[path, ]regex,dotf]), lsd([[path, ]regex, fullpath ,dotfolder])
    %
    %       trim(str,how[,chars])
    %       join(sep,string1,string2) or join(sep,array)
    %       replace(cellArray, item, replacement)
    %
    %       mkdir(path), rm(path), cp(src, dest), mv(src, dest), rn(src, dest), lns(src, dest)
    %       execute(cmd), open(path)
    %
    %       Alert(msg), result = Confirm(msg), results = Inputs(values[, defaults, title]), 
    %       GetDir([title, path]), 
    %       [result, pathName] = GetFile([pattern[, title, multiple]]), [result, pathName] = SetFile([defaultFileName[, title]])
    %       wintop([fig]), winclose, winfind
    %
    %       GetVal(baseVarName)
    %
    %       obsolete as of Sat, Dec 08 2018: switching to Table i/o functions
    %       cell2csv(csvFile,cellArray)
    %       result = csv2cell(csvFile)
    %       [raw,num,txt] = xls2cell_windows_w_excel(xlsFile)
    %
    %       readx, savex, header, append
    %
    %       gmail(email, subject, content, sender, user, pass) 
    %
    %       export(), ps2pdf()
    %       exe_   portable exe
    %
    %       backward compatabilities: union, unique, ismember, setdiff, intersect, setxor       
    %
    %       result = toolboxExists({,})
    %       result = compare(A,B)
    %       printstruct(S)
    %       v2m()
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

        function showhelp()
            % show caller's help info
            ST = dbstack('-completenames');
            if isempty(ST), fprintf('\nYou must call this within a function\n\n'); return; end
            eval(sprintf('help %s', ST(2).name));
        end

        function setdefault(paircell)
            % setdefault(paircell)
            % sets a default value for a variable, does not returns anything
            % if an arg is passed a value, default value will be ignored
            % useful for define a function as in the following example:
            % 
            % value could be number, character, or even a function ez.ls('path/to/sth')
            % do not have to list all args; not applicable to varargin
            % 
            % function result = funcname(para1,para2,para3,varargin)
            %       setdefault({'para1',3,'para2','abc'});
            %       % or (the ; could be , or omitted)
            %       setdefault({'para1',3;
            %                   'para2','abc'});
            %       blabla...
            % end
            if (size(paircell,1)==1), paircell = reshape(paircell, 2, length(paircell)/2)'; end

            for i = 1:size(paircell,1)
                variable = paircell{i,1}; defaultValue = paircell{i,2};
                varExist = evalin('caller',sprintf('exist(''%s'',''var'')',variable));  % '' to escape
                if ~varExist
                    assignin('caller',variable,defaultValue);
                end
            end
        end

        function clean()
            % new version of matlab issues warning
            % ez.m could not be cleared because it contains MATLAB code that is currently executing
            S = warning('off','MATLAB:lang:cannotClearExecutingFunction');
            
            % clear command window, all variables. close all figures. show workspace/variables window
            clc;         % clear command window
            evalin('base','clear all');  % clear base workspace as well
            close all;   % close all figures
            % workspace;   % show/activate workspace/variables window
            commandwindow; % refocus to command window
            
            warning(S.state,'MATLAB:lang:cannotClearExecutingFunction');
        end

        function clear()
            % new version of matlab issues warning
            % ez.m could not be cleared because it contains MATLAB code that is currently executing
            S = warning('off','MATLAB:lang:cannotClearExecutingFunction');
            
            % clear command window, all variables. close all figures. show workspace/variables window
            clc;         % clear command window
            evalin('base','clear all');  % clear base workspace as well
            close all;   % close all figures
            % workspace;   % show/activate workspace/variables window
            commandwindow; % refocus to command window
            
            warning(S.state,'MATLAB:lang:cannotClearExecutingFunction');
        end

        function varargout = view(varargin)
            % Open workspace variable in Variables editor or other graphical editing tool, a wrapper of openvar()
            [varargout{1:nargout}] = openvar(varargin{:}); 
        end

        function result = ifelse(test,s1,s2)
            % Usage:
            %  >> result = ifelse(test, s1, s2);
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

        function varargout = makenames(varargin)
            % Construct valid MATLAB identifiers from input strings, alias of matlab.lang.makeValidName
            [varargout{1:nargout}] = matlab.lang.makeValidName(varargin{:}); 
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

        function lines = readlines(file)
            % (file)
            % read file into a nx1 cell
            % line's trailing space trimmed and newline character removed
            fid = fopen(file);
            lines = {};
            i = 1;
            while ~feof(fid)
                line = fgetl(fid); % read line by line
                lines{i,1}=ez.trim(line,2);
                i = i+1;
            end
            fclose(fid);
        end

        function writeline(line,file)
            % (line[,file])
            % Inputs:
            %   line, a line in string type  (num2str, mat2str)
            %   file--optional, file path, defaults to "output.txt" in the current working directory
            % Append a line to file and also display the line on screen
            % returns nothing

            if ~exist('file','var'), file = 'output.txt'; end

            fid = fopen(file,'a');
            fprintf(fid,'%s\n',line);
            fclose(fid);

            % show on screen
            fprintf('%s\n',line);
        end

        function logon(file)
            if nargin<1, file='diary.log'; end
            diary(file);
            fprintf('log on at %s\n',ez.moment());
        end

        function logoff()
            fprintf('log off at %s\n',ez.moment());
            diary off;
        end
        
        function varargout = print(varargin)
            % Print message, append a new line, a wrapper of fprintf()
            [varargout{1:nargout}] = fprintf(varargin{:});
            fprintf('\n');
        end

        function pprint(sth, color)
            % print(sth[, color]), color is optional, default to 'purple', auto append a new line
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
            % csd() current script dir
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
            % csf() current script file
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

        function varargout = cd(varargin)
            % cd(varargin)
            % changes directory, the same as cd()
            [varargout{1:nargout}] = cd(varargin{:}); 
        end
        
        function ce()
            % ez.cd(ez.csd())
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                result = fileparts(theStack.file);
            catch
                result = pwd;
            end
            cd(result); 
        end

        function cf()
            % ez.cd(ez.csd())
            try
                theStacks = dbstack('-completenames');
                theStack = theStacks(2);
                result = fileparts(theStack.file);
            catch
                result = pwd;
            end
            cd(result); 
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

        function varargout = pr(varargin)
            [varargout{1:nargout}] = ez.parentdir(varargin{:}); 
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

        function varargout = abspath(varargin)
            % abspath(varargin)
            [varargout{1:nargout}] = GetFullPath(varargin{:}); 
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

        function varargout = sp(varargin)
            [varargout{1:nargout}] = ez.splitpath(varargin{:}); 
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

        function varargout = jp(varargin)
            [varargout{1:nargout}] = ez.joinpath(varargin{:}); 
        end

        function result = trim(s,varargin)
            % Merge multiple spaces to single space in the middle, and remove trailing/leading spaces
            % trim(s [, how [,chars]])
            %     s: a string 
            %     how: a num 1=left only; 
            %                2=right only; 
            %                3=left and right; 
            %                4 (default)=left and right and merge middle
            %     chars: if not given (default), space
            %              if given, remove consecutive character instead
            % eg, 'Hi        buddy        what is up    Bro'  --> 'Hi buddy what's up bro'
            %     trim(s,3,'\')
            %     ' Hi        buddy        what is up    Bro\\' --> ' Hi        buddy        what's up    Bro'
            % 
            
            % nargin refers to all incoming args, not just the ones in varargin
            % in the case of (s), nargin = 1
            if nargin == 1
                how = 4;
                chars = ' ';
            elseif nargin == 2
                how = varargin{1};
                chars = ' ';
            elseif nargin == 3
                how = varargin{1};
                chars = varargin{2};
            end % end if nargin

            if strcmp(chars,' '), chars='\s'; end

            if how==1
                expression = sprintf('^(%s)+',chars);
            elseif how==2
                expression = sprintf('(%s)+$',chars);
            elseif how==3
                expression = sprintf('^(%s)+|(%s)+$',chars,chars);
            elseif how==4
                expression = sprintf('(?<=[(%s)])(%s)*|^(%s)+|(%s)+$',chars,chars,chars,chars);
            end % end if how

            result = regexprep(s, expression, '');
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
            % len(varargin), wrapper of length()
            % returns the len of an array
            % if the dimension is >= 2, still perform length() but remind user
            
            % isvector works with cell too
            % isvector() better serves the purpose here than ndims() 
            %   because ndims([1]) or ndims([1 2 3]) returns 2!   
            %   treating as 1xn array, so two dims
            %   isemtpy() needed, because isvector([]) returns 0
            if (~isempty(varargin{:})) && (~isvector(varargin{:}))
                %   if  warning will print out stack trace
                %   which could be resouce-consuming if caught in a loop
                warning('length() called, but more than 2 dims found; make sure returned length is what you want in every situation'); 
            end
            [varargout{1:nargout}] = length(varargin{:}); 
        end

        function result = ls(rootdir, expstr, fullpath, dotfile)
            % ls(), ls(path), ls(regex), ls(path, regex), ls(path, regex, fullpath), ls(rootdir, expstr, fullpath, dotfile)
            % if path is missing, refers to current working directory
            % dotfile refers to a file whose name starts with a dot, eg, .DS_Store ._file
            % returns a nx1 cell of files in directory with fullpath (default fullpath=true) and without dotfile (default dotfile=false)
            % ls(path,regex) regex is case sensitive by default
            switch nargin
                case 0
                    rootdir = pwd;
                    expstr = '.*';
                    recursive = false;
                    fullpath = true;
                    dotfile = false;
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
                    dotfile = false;
                case 2
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = false;
                    fullpath = true;
                    dotfile = false;
                case 3
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = false;
                    fullpath = fullpath;
                    dotfile = false;
                case 4
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = false;
                    fullpath = fullpath;
                    dotfile = dotfile;                    
            end
            result = regexpdir(rootdir, expstr, recursive);

            if ~fullpath, result = cellfun(@GetFileName,result,'UniformOutput',false); end
            function result = GetFileName(e)
                parts = regexp(e,filesep,'split');
                result = parts{end};
            end % end sub-function

            % deal with dotfile posthoc
            if ~dotfile, result = result(cell2mat(cellfun(@IsNotDotFile,result,'UniformOutput',false))); end
            function res = IsNotDotFile(f)
                % no matter whether f is fullpath or not
                parts = regexp(f,filesep,'split');
                fileName = parts{end};
                % use strncmpi instead of fileName(1) to avoid error when fileName='';
                res = ~strncmpi(fileName,'.',1);
            end % end sub-function    
        end

        function result = fls(rootdir, expstr, dotf)
            % fls(), fls(path), fls(regex), fls(path, regex), fls(rootdir, expstr, dotf)
            % if path is missing, refers to current working directory
            % dotf refers to a file/folder whose name starts with a dot, eg, .DS_Store ._file .ignore/ (default dotf=false)
            % returns a nx1 cell of files in directory with fullpath recursively without dotf
            % fls(path,regex) regex is case sensitive by default
            switch nargin
                case 0
                    rootdir = pwd;
                    expstr = '.*';
                    recursive = true;
                    dotf = false;
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
                    dotf = false;
                case 2
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = true;
                    dotf = false;
                case 3
                    rootdir = rootdir;
                    expstr = expstr;
                    recursive = true;
                    dotf = dotf;
            end
            result = regexpdir(rootdir, expstr, recursive);

            % deal with dotf posthoc
            if ~dotf, result = result(cell2mat(cellfun(@IsNotDotF,result,'UniformOutput',false))); end
            function res = IsNotDotF(f)
                % no matter whether f is fullpath or not
                parts = regexp(f,filesep,'split');
                % use strncmpi instead of p(1) to avoid error when p=''; length >=2 to ignore '' or '.'
                res = ~any(cell2mat(cellfun(@(p) (length(p)>=2)&&strncmpi(p,'.',1)&&~strcmp(p,'..'),parts,'UniformOutput',false)));
            end % end sub-function    
        end

        function result = lsd(path,regex,fullpath,dotfolder)
            % ls directory, lsd(), lsd(path), lsd(regex), lsd(path, regex), lsd(path, regex, fullpath), lsd(path,regex,fullpath,dotfolder)
            % path defaults to pwd, not recursive; support case-sensitive regex, default .*
            % returns a nx1 cell with all subfolder's names (only names, sorted ascending), or an empty 0 x 1 cell.
            % fullpath defaults to false
            switch nargin
                case 0
                    path = pwd;
                    regex = '.*';
                    fullpath = false;
                    dotfolder = false;
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
                    dotfolder = false;
                case 2
                    path = path;
                    regex = regex;
                    fullpath = false;
                    dotfolder = false;
                case 3
                    path = path;
                    regex = regex;
                    fullpath = fullpath;
                    dotfolder = false;
                case 4
                    path = path;
                    regex = regex;
                    fullpath = fullpath;
                    dotfolder = dotfolder;
            end
            listing = dir(path);
            issub = [listing(:).isdir]; % returns logical vector
            folderNames = {listing(issub).name}';
            folderNames(ismember(folderNames,{'.','..'})) = []; % get rid of . ..
            ind = cellfun(@(x)( ~isempty(x) ), regexp(folderNames, regex));
            result = folderNames(ind);
            result = sort(result); % ascending order

            if fullpath, result = cellfun(@(e) fullfile(path,e),result,'UniformOutput',false); end

            % deal with dotfolder posthoc
            if ~dotfolder, result = result(cell2mat(cellfun(@IsNotDotFolder,result,'UniformOutput',false))); end
            function res = IsNotDotFolder(f)
                % no matter whether f is fullpath or not
                parts = regexp(f,filesep,'split');
                % use strncmpi instead of p(1) to avoid error when p=''; length >=2 to ignore '' or '.'
                res = ~any(cell2mat(cellfun(@(p) (length(p)>=2)&&strncmpi(p,'.',1)&&~strcmp(p,'..'),parts,'UniformOutput',false)));
            end % end sub-function        
        end

        function [res] = matchn(nx1,indexn)
           % reorder nx1 cell or matrix, originally designed for ez.lsd() results
           % input: nx1 cell or matrix. 
           %        indexn [1 4 2 3]
           % Eg, 1 2 3 4 5 6 7 8 -> 1 4 2 3 5 8 6 7
           ind = bsxfun(@plus,indexn',[1:length(indexn):length(nx1)]-1);
           ind = ind(:);
           res = nx1(ind);
        end
        
        function [path, status] = mkdir(path,print2screen)
            % mkdir(path)
            % makes a new dir, path could be absolute or relative, returns true or false
            % creates all neccessay parent folders (e.g. 'a/b/c', creates a b for c)
            % if folder exits, does nothing and returns success/true
            
            ez.setdefault({'print2screen',true});
            if isdir(path)
                status = true;
            else
                status = mkdir(path);
                if print2screen, disp([path ' created']); end
            end

            % % mkdir(path)
            % % makes a new dir, path could be absolute or relative, returns true or false
            % % creates all neccessay parent folders (e.g. 'a/b/c', creates a b for c)
            % % if folder exits, still creates and returns success
            % S = warning('off', 'MATLAB:MKDIR:DirectoryExists');
            % status = mkdir(path);
            % disp([path ' created']);
            % warning(S.state, 'MATLAB:MKDIR:DirectoryExists');
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

        function [status,result] = lns(src,dest)
            % lns(src,dest)
            % create a soft link
            % when src is a file, dest could be a target file or a target dir
            [status,result] = system(['ln -s ' src ' ' dest],'-echo');
        end

        function res = getos()
            % return 'osx','linux','windows', check with strcmp()
            if ismac
                res = 'mac';
            elseif isunix
                res = 'linux';
            elseif ispc
                res = 'windows';
            else
                res = '';
            end
        end

        function [status,result] = execute(command,print2screen)
            % [status,result] = execute(command)
            % execute operating system command and returns output
            % also displays (echoes) the command output in the MATLAB Command Window

            ez.setdefault({'print2screen',true});
            if print2screen
                % '-echo' also displays (echoes) the command output in the MATLAB Command Window
                [status,result] = system(command,'-echo');
            else
                [status,result] = system(command);
            end
        end

        function updateself(force)
            % force, only works for linux
            if nargin<1, force=false; end

            if ismac 
                system('bash ~/Dropbox/Apps/Matlab/ez/publish.sh','-echo');
                system('bash ~/Dropbox/Apps/Matlab/SPM/publish.sh','-echo');
                try 
                    fn = tempname;
                    fid = fopen(fn,'w');
fprintf(fid,' # how to run these commands \n');
fprintf(fid,' # bcomp @''bcompsync.txt'' -silent  \n');
fprintf(fid,' # for more help: bcomp -h \n');
fprintf(fid,'  \n');
fprintf(fid,' # log normal append:"bcompsync.log" \n');
fprintf(fid,' option confirm:yes-to-all \n');
fprintf(fid,' criteria timestamp:2sec size \n');
fprintf(fid,'  \n');
fprintf(fid,' filter "-._*;-._*.*;-.*;-.*.*;-*/;s0*.xlsx;*.m;*.mat;*.nii" \n');
fprintf(fid,' load "/Users/jerry/Dropbox/Work/Postdoc/IU/Data/scene" "/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/scene" \n');
fprintf(fid,' sync mirror:left->right \n');
fprintf(fid,'  \n');
fprintf(fid,' filter "-._*;-._*.*;-.*;-.*.*;-*/;s0*.xlsx;*.m;*.mat;*.nii" \n');
fprintf(fid,' load "/Users/jerry/Dropbox/Work/Postdoc/IU/Data/metabolic/PC & PE (PDI)/jerry" "/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/nbk_metab" \n');
fprintf(fid,' sync mirror:left->right \n');
fprintf(fid,'  \n');
fprintf(fid,' filter "-._*;-._*.*;-.*;-.*.*;-*/;g0*.xlsx;*.m;*.mat" \n');
fprintf(fid,' load "/Users/jerry/Dropbox/Work/Postdoc/IU/Data/nbk" "/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/nbk" \n');
fprintf(fid,' sync mirror:left->right \n');
fprintf(fid,'  \n');
fprintf(fid,' filter "-.gitignore;-.DS_Store;-._*;-.*;-.ignore/;-.git/;-*/" \n');
fprintf(fid,' load "/Users/jerry/Dropbox/Apps/Matlab/ez" "/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/ez" \n');
fprintf(fid,' sync mirror:left->right \n');
fprintf(fid,'  \n');
fprintf(fid,' filter "-.gitignore;-.DS_Store;-._*;-.*;-jobmail.m;-./extensions/xjview96/example2.img;-./extensions/xjview96/*.mat;-./extensions/xjview96/example2.hdr;-./extensions/xjview96/example1.img;-./extensions/xjview96/example1.hdr;-./extensions/xjview96/ch2bet.img;-./extensions/xjview96/ch2bet.hdr;-./extensions/xjview96/ch2.img;-./extensions/xjview96/ch2.hdr;-./extensions/xjview96/brodmann.img;-./extensions/xjview96/brodmann.hdr;-./extensions/xjview96/aal.img;-./extensions/xjview96/aal.hdr;-.ignore/;-.git/;-./spms/;-./template/;-./extensions/Talairach/;-./extensions/WFU_PickAtlas_3.0.5b/;-./extensions/spunt-bspmview-20180918/;-./extensions/mricron_2016_05_02/;-./extensions/MRIcroGL_2018_11_11/;-./extensions/FITv2.0d/;-./extensions/afni_matlab/;-./extensions/marsbar-0.44/;-./extensions/BrainNetViewer_20150807/;-./extensions/BCT_2016_01_16/;-./extensions/BASCO2.0_modified/" \n');
fprintf(fid,' load "/Users/jerry/Dropbox/Apps/Matlab/SPM" "/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/SPMJobs12" \n');
fprintf(fid,' sync mirror:left->right \n');
                    fclose(fid);
                    system(sprintf('/usr/local/bin/bcomp @''%s'' ', fn),'-echo');
                    ez.rm(fn);
                end
            elseif isunix
                if ~force
                    oldpwd = pwd;
                    cd('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/ez');
                    ! git fetch origin master
                    ! git reset --hard origin/master
                    ! git pull origin master
                    cd('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/SPMJobs12');
                    ! git fetch origin master
                    ! git reset --hard origin/master
                    ! git pull origin master
                    cd(oldpwd)
                else
                    % ez could not be removed because this function is being executed
                    oldpwd = pwd;
                    S = warning('off','MATLAB:lang:cannotClearExecutingFunction');
                    rmdir('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/SPMJobs12','s');
                    rmdir('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/ez','s');
                    warning(S.state,'MATLAB:lang:cannotClearExecutingFunction');
                    cd('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/zhu');
                    ! git clone https://github.com/jerryzhujian9/ez.git
                    ! git clone https://github.com/jerryzhujian9/SPMJobs12.git
                    restoredefaultpath;
                    clear RESTOREDEFAULTPATH_EXECUTED;
                    addpath('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/ez');
                    run('/geode2/projects/ln/IN-RADY-CFN4/G1/mci/aging/task/SPMJobs12/ignite.m');
                    f;
                    spm('quit');
                    cd(oldpwd)
                end
            end
        end

        function open(path)
            % Opens a file or directory outside matlab with default external program
            % works for both mac and windows (under windows, a wrapper of winopen())
            % open(path)
            if (ispc)
                winopen(path);
            elseif (ismac)
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

        function wintop(fig)
            % toggle figure win (default=gcf) on top
            % this is different from .WindowStyle='modal' where mouse cannot click elsewhere
            if ~exist('fig','var'), fig = gcf; end
            isOnTop  = WinOnTop(fig,[]);
            if isOnTop
                WinOnTop(fig, false);
            else
                WinOnTop(fig, true);
            end
        end % end function

        function winclose(regexname)
            % regexname: figure name in regex (case sensitive). 
            % if not provided, close all force
            % if not found, nothing happens
            if ~exist('regexname','var'), 
                close all force;
            else 
                % 0=root object (screen)
                h = findall(0,'type','figure','-regexp','name',regexname);
                close(h);  % h empty is fine
            end
        end

        function h=winfind(regexname)
            % regexname: figure name in regex (case sensitive)
            % returns a Figure array (empty if not found), index using h(1)

            % 0=root object (screen)
            h = findall(0,'type','figure','-regexp','name',regexname);
        end

        function varargout = winmove(varargin)
            % alias of movegui, move to the specified screen location and preserves the figure's size
            % ([h,] position) 
            % position: [left, top] or 'north', 'south', 'east', 'west', 'northeast', 'northwest', 'southeast', 'southwest', 'center', 'onscreen'
            % Note: how to get screen size 
            %       get(0,'units'); get(0,'screensize')
            %       (On Windows systems, a pixel is 1/96th of an inch, 96DPI; Mac, 72DPI; Linux, determined by system resolution)
            [varargout{1:nargout}] = movegui(varargin{:}); 
        end
        
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
            % obsolete as of Sat, Dec 08 2018: switching to Table i/o functions
            % cell2csv(csvFile,cellArray)
            % write the content of a cell array to a csv file, comma separated
            % works with empty cells, numeric, char, string, row vector, and logical cells. 
            % row vector such as [1 2 3] will be separated by two spaces, that is "1  2  3"
            % One array can contain all of them, but only one value per cell.
            cell2csvModified(csvFile,cellArray,',',1997,'.'); %csv,cell,value separator,excel year,decimal point
        end

        function result = csv2cell(csvFile)
            % obsolete as of Sat, Dec 08 2018: switching to Table i/o functions
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
                    if isempty(x)
                        result = []; 
                    else
                        result = x;
                    end
                else
                    result = str2num(x);
                end % end if
            end % end sub-function    
        end

        function [raw,num,txt] = xls2cell_windows_w_excel(varargin)
            % obsolete as of Sat, Dec 08 2018: switching to Table i/o functions
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

        function varargout = readx(varargin)
            % illegal char (eg, .) in variable names will be replace with _ (warning suppressed)
            
            % Variable names were modified to make them valid MATLAB identifiers. The original names are saved in the VariableDescriptions property.
            S = warning('OFF', 'MATLAB:table:ModifiedVarnames');
            [varargout{1:nargout}] = readtable(varargin{:}); 
            warning(S.state, 'MATLAB:table:ModifiedVarnames');
        end
        
        function savex(T,file)
            % underlying is java https://www.mathworks.com/matlabcentral/fileexchange/38591
            % fall back to writetable
            %     underlying is writetable, but on Linux and Mac platforms, the xlsread function or the Import Tool cannot open spreadsheet files written by the writetable function.
            %     Resave the xlsx file with Excel
            %     writetable only overwrites cells in excel 
            % (T,file)
            % T: table with header
            % file: file path with .xlsx (always overwrite file here)
            % 
            % for cell, first convert to table: T = ez.c2t(['header';C])
            if exist(path,'file')
                delete(path);
            end
            try
                if isempty(which('xlwrite'))
                    thePath = fullfile(fileparts(mfilename('fullpath')),'xlwrite');
                    addpath(thePath);
                    % Add Java POI Libs to matlab javapath
                    javaaddpath(fullfile(thePath,'poi_library','poi-3.8-20120326.jar'));
                    javaaddpath(fullfile(thePath,'poi_library','poi-ooxml-3.8-20120326.jar'));
                    javaaddpath(fullfile(thePath,'poi_library','poi-ooxml-schemas-3.8-20120326.jar'));
                    javaaddpath(fullfile(thePath,'poi_library','xmlbeans-2.3.0.jar'));
                    javaaddpath(fullfile(thePath,'poi_library','dom4j-1.6.1.jar'));
                    javaaddpath(fullfile(thePath,'poi_library','stax-api-1.0.1.jar'));
                end
                % xlwrite can only write cell, third para is sheet name or index
                xlwrite(file,ez.t2c(T));
            catch
                % [varargout{1:nargout}] = writetable(varargin{:}); 
                writetable(T,file);
            end % end try
        end 
        
        function varargout = writex(varargin)
            [varargout{1:nargout}] = ez.savex(varargin{:}); 
        end

        function res = header(VariableNames)
            % VariableNames: cell of str, {'col_cellstr','col_double','col_cellstr2'}
            % usage:
            % xlsx = ez.header({'col_cellstr','col_double','col_cellstr2'});
            % xlsx = ez.append(xlsx, {'string',2,'[3,4]'});
            
            % https://www.mathworks.com/matlabcentral/answers/112462
            % https://www.mathworks.com/help/matlab/ref/table.html
            res = cell2table(cell(0,numel(VariableNames)),'VariableNames',VariableNames);
        end
        
        function res = append(res,rowcell)
            % append a row (in cell) to table
            % (res,rowcell)
            % res: exisiting table
            % rowcell: {'string',2,'[3,4]'}
            % col1,3 will be cellstr, col2 will be double
            % usage:
            % xlsx = ez.header({'col_cellstr','col_double','col_cellstr2'});
            % xlsx = ez.append(xlsx, {'string',2,'[3,4]'});
            res = [res; rowcell];
        end
        
        function T = c2t(C)
            % (C) to table
            % C: cell with header
            if ~iscell(C), T=C; return; end
            T = cell2table(C(2:end,:));
            T.Properties.VariableNames = matlab.lang.makeValidName(C(1,:));
        end
        
        function C = t2c(T)
            % convert to cell with header
            if ~istable(T), C=T; return; end
            C = table2cell(T);
            C = [T.Properties.VariableNames;C];
        end
        
        function gmail(email, subject, content, sender, user, pass)
            % e.g. gmail('a@b.com', 'greetings', ['line1' 10 'line2'], 'Sender Name <c@gmail.com>', 'c@gmail.com', 'password');
            % gmail({'a@b.com','c@d.com'},'done')
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
            if isempty(which('export_fig')), addpath(fullfile(fileparts(mfilename('fullpath')),'export_fig')); end
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
            % https://github.com/altmany/export_fig/blob/master/README.md

            % as of Thu, Jul 28 2016, I merged all export_fig functions to the end of this file
            % as of Tue, Nov 29 2016, I put the export_fig back for easy maintenance/update
            % % add the export_fig folder to path which is in the same folder as ez
            % % old command: addpath(genpath_exclude(fileparts(mfilename('fullpath')),{'^\..*'}));
            if isempty(which('export_fig')), addpath(fullfile(fileparts(mfilename('fullpath')),'export_fig')); end



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

        function varargout = v2m(varNameString)
            % v2m(varNameString)
            % Save a variable to .m file such that the script can re-generate the variable
            ez.setdefault({'varNameString','matlabbatch'});
            fileName = [tempname,'.m'];
            [varargout{1:nargout}] = evalin('caller', sprintf('matlab.io.saveVariablesToScript(''%s'',''%s'')',fileName,varNameString)); 
            edit(fileName);
        end
        
        function varargout = printstruct(S, varargin)
            % PRINTSTRUCT Recursively print hierarchical outline of structure contents
            % __________________________________________________________________________
            %  USAGE: pS = printstruct(S, varargin)
            %
            %    IN:   S = structure variable to print
            %  OUT*:  pS = cell array containing printed structure
            %
            %   *If defined, result will NOT display in command window
            % __________________________________________________________________________
            %  OPTIONAL VARARGIN* [entered as 'name', value pairs]:
            %   *Run printstruct w/no arguments to see default values
            %
            %   NLEVELS:        N levels to print. If negative, all levels printed.
            %   NINDENT:        number of tab indents for each line of printed struct
            %   STRUCTNAME:     top level name (if empty, variable name will be used)
            %   PRINTCONTENTS:  flag to print field values/contents as well
            %   SORTFIELDS:     flag to sort fields within each  dtype (by level)
            %   MAXARRAYLENGTH: for fields containing arrays, sets max number of values to
            %   print. Values of a 2D (m,n) array are printed if the number of
            %   elements (mxn) is less than or equal to maxarraylength. This is ignored
            %   if printcontents is set to 0.
            % _______________________________
            % EXAMPLES
            %
            %   pS = printstruct(S, 'maxarray', 100);
            %   printstruct(S, 'sortfields', 1, 'nlevels', 2, 'printcontents', 0, 'nindent', 3)
            %

            % ---------------------- Copyright (C) 2015 Bob Spunt ----------------------
            %  Created:  2015-08-13
            %  Email:    spunt@caltech.edu
            %
            %  This is a minor adaptation of the File Exchange contribution "Structure
            %  outline" written by B. Roossien <roossien@ecn.nl> and available here:
            %  http://mathworks.com/matlabcentral/fileexchange/13500-structure-outline
            %  copied from 
            %  https://github.com/spunt/printstruct 
            %  https://www.mathworks.com/matlabcentral/fileexchange/52573
            %  other solutions: 
            %  https://www.mathworks.com/matlabcentral/fileexchange/13831
            %  https://www.mathworks.com/matlabcentral/fileexchange/32879
            % __________________________________________________________________________
            def = { ...
                'nlevels',              -1,             ...
                'printcontents',         1,             ...
                'nindent',               0,             ...
                'structname',           '',             ...
                'sortfields',           1,              ...
                'maxarraylength',       75              ...
                };
            vals = setargs(def, varargin);
            if nargin==0, mfile_showhelp; fprintf('\t| - VARARGIN DEFAULTS - |\n'); disp(vals); return; end
            if iscell(S)
                if all(cellfun(@isstruct, S))
                    fprintf(' - detected cell array of structs. printing iteratively...\n\n');
                end
            else
                S = {S};
            end
            if nlevels==0, nlevels = -1; end;
            if isempty(structname), structname = inputname(1); end
            pS = [];
            for i = 1:length(S)
                cS = S{i};
                if sortfields, cS = orderfields(cS); end
                if length(cS)==1
                    str = recFieldPrint(cS, nindent, nlevels, printcontents, maxarraylength, structname, sortfields);
                    str = [cellstr(structname); str];
                else
                    str = [];
                    for i = 1:length(cS)
                        tmpstr = recFieldPrint(cS(i), nindent, nlevels, printcontents, maxarraylength, structname, sortfields);
                        str = [str; cellstr(sprintf('%s(%d)', structname, i)); tmpstr];
                        if i<length(cS), str = [str; {' '}]; end
                    end
                end
                
                if nargout==0
                    for i = 1:length(str), disp(cell2mat(str(i, 1))); end
                else
                    varargout{1} = [pS; str];
                end
            end
        end % end fun

        function tf = toolboxExists(requiredToolboxes)
        %toolboxExists takes a cell array of toolbox names and checks whether they are currently installed
        % SYNOPSIS tf = toolboxExists(requiredToolboxes)
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
end % end ez class












                      %%**************************************************.
                      %%*start internal functions section.
                      %%**************************************************.
%%**************************************************.
%%*ez.ls, fls.
%%**************************************************.
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

%%**************************************************.
%%*ez.pprint.
%%**************************************************.
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
% end of this internal function

%%**************************************************.
%%*ez.cell2csv.
%%**************************************************.
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
end % end of this internal function

%%**************************************************.
%%*ez.csv2cell.
%%**************************************************.
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
end % end of this internal function

%%**************************************************.
%%*for ez.export, not used anymore.
%%**************************************************.
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

%%**************************************************.
%%*ez.unique, union etc.
%%**************************************************.
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
end  % end of this internal function

%%**************************************************.
%%*ez.WinTop.
%%**************************************************.
function wasOnTop = WinOnTop( figureHandle, isOnTop )
%WINONTOP allows to trigger figure's "Always On Top" state
%
%% INPUT ARGUMENTS:
%
% # figureHandle - Matlab's figure handle, scalar
% # IsOnTop      - logical scalar or empty array
%
%
%% USAGE:
%
% * WinOnTop( hfigure, true );      - switch on  "always on top"
% * WinOnTop( hfigure, false );     - switch off "always on top"
% * WinOnTop( hfigure );            - equal to WinOnTop( hfigure,true);
% * WinOnTop();                     - equal to WinOnTop( gcf, true);
% * WasOnTop = WinOnTop(...);       - returns boolean value "if figure WAS on top"
% * IsOnTop = WinOnTop(hfigure,[])  - get "if figure is on top" property
%
%
%% LIMITATIONS:
%
% * java enabled
% * figure must be visible
% * figure's "WindowStyle" should be "normal"
% * figureHandle should not be casted to double, if using HG2 (R2014b+)
%
%
% Written by Igor
% i3v@mail.ru
%
% 2013.06.16 - Initial version
% 2013.06.27 - removed custom "ishandle_scalar" function call
% 2015.04.17 - adapted for changes in matlab graphics system (since R2014b)
% 2016.05.21 - another ishg2() checking mechanism 

%% Parse Inputs

if ~exist('figureHandle','var'); figureHandle = gcf; end

assert(...
          isscalar(  figureHandle ) &&...
          ishandle(  figureHandle ) &&...
          strcmp(get(figureHandle,'Type'),'figure'),...
          ...
          'WinOnTop:Bad_figureHandle_input',...
          '%s','Provided figureHandle input is not a figure handle'...
       );

assert(...
            strcmp('on',get(figureHandle,'Visible')),...
            'WinOnTop:FigInisible',...
            '%s','Figure Must be Visible'...
       );

assert(...
            strcmp('normal',get(figureHandle,'WindowStyle')),...
            'WinOnTop:FigWrongWindowStyle',...
            '%s','WindowStyle Must be Normal'...
       );
   
if ~exist('isOnTop','var'); isOnTop=true; end

assert(...
          islogical( isOnTop ) && ...
          isscalar(  isOnTop ) || ...
          isempty(   isOnTop ),  ...
          ...
          'WinOnTop:Bad_IsOnTop_input',...
          '%s','Provided IsOnTop input is neither boolean, nor empty'...
      );
  
  
%% Pre-checks

error(javachk('swing',mfilename)) % Swing components must be available.
  
  
%% Action

% Flush the Event Queue of Graphic Objects and Update the Figure Window.
drawnow expose

warnStruct=warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jFrame = get(handle(figureHandle),'JavaFrame');
warning(warnStruct.state,'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

drawnow


if ishg2(figureHandle)
    jFrame_fHGxClient = jFrame.fHG2Client;
else
    jFrame_fHGxClient = jFrame.fHG1Client;
end


wasOnTop = jFrame_fHGxClient.getWindow.isAlwaysOnTop;

if ~isempty(isOnTop)
    jFrame_fHGxClient.getWindow.setAlwaysOnTop(isOnTop);
end

end

function tf = ishg2(figureHandle)
% There's a detailed discussion, how to check "if using HG2" here:
% http://www.mathworks.com/matlabcentral/answers/136834-determine-if-using-hg2
% however, it looks like there's no perfect solution.
%
% This approach, suggested by Cris Luengo:
% http://www.mathworks.com/matlabcentral/answers/136834#answer_156739
% should work OK, assuming user is NOT passing a figure handle, casted to
% double, like this:
%
%   hf=figure();
%   WinOnTop(double(hf));
%

tf = isa(figureHandle,'matlab.ui.Figure');

end % end of this internal function

%%**************************************************.
%%*ez.compare.
%%**************************************************.
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
end % end of this internal function

%%**************************************************.
%%*ez.printstruct.
%%**************************************************.
% ==========================================================================
% SUBFUNCTIONS ------------------------------------------------------------=
% ==========================================================================
% usage:
% if nargin < 3, mfile_showhelp; return; end
function mfile_showhelp(varargin)
    % MFILE_SHOWHELP
    ST = dbstack('-completenames');
    if isempty(ST), fprintf('\nYou must call this within a function\n\n'); return; end
    eval(sprintf('help %s', ST(2).name));
end

function argstruct = setargs(defaults, optargs)
    % SETARGS Name/value parsing and assignment of varargin with default values
    %
    % This is a utility for setting the value of optional arguments to a
    % function. The first argument is required and should be a cell array of
    % "name, default value" pairs for all optional arguments. The second
    % argument is optional and should be a cell array of "name, custom value"
    % pairs for at least one of the optional arguments.
    %
    %  USAGE: argstruct = setargs(defaults, args)
    % __________________________________________________________________________
    %  OUTPUT
    %
    %   argstruct: structure containing the final argument values
    % __________________________________________________________________________
    %  INPUTS
    %
    %   defaults:
    %       cell array of "name, default value" pairs for all optional arguments
    %
    %   optargs [optional]
    %       cell array of "name, custom value" pairs for at least one of the
    %       optional arguments. this will typically be the "varargin" array.
    % __________________________________________________________________________
    %  USAGE EXAMPLE (WITHIN FUNCTION)
    %
    %     defaults    = {'arg1', 0, 'arg2', 'words', 'arg3', rand};
    %     argstruct   = setargs(defaults, varargin)
    %
    if nargin < 1, mfile_showhelp; return; end
    if nargin < 2, optargs = []; end
    defaults = reshape(defaults, 2, length(defaults)/2)';
    if ~isempty(optargs)
        if mod(length(optargs), 2)
            error('Optional inputs must be entered as Name, Value pairs, e.g., myfunction(''name'', value)');
        end
        arg = reshape(optargs, 2, length(optargs)/2)';
        for i = 1:size(arg,1)
           idx = strncmpi(defaults(:,1), arg{i,1}, length(arg{i,1}));
           if sum(idx) > 1
               error(['Input "%s" matches multiple valid inputs:' repmat('  %s', 1, sum(idx))], arg{i,1}, defaults{idx, 1});
           elseif ~any(idx)
               error('Input "%s" does not match a valid input.', arg{i,1});
           else
               defaults{idx,2} = arg{i,2};
           end
        end
    end
    for i = 1:size(defaults,1), assignin('caller', defaults{i,1}, defaults{i,2}); end
    if nargout>0, argstruct = cell2struct(defaults(:,2), defaults(:,1)); end
end
% ==========================================================================
% ADAPTED FROM FROM STRUCDISP - fileexchange/13831-structure-display -------
% ==========================================================================
function listStr  = recFieldPrint(Structure, indent, depth, printValues, maxArrayLength, structname, sortfields)
    % RECFIELDPRINT Recursive printing of a structure variable
    %   This function and its dependencies were taken from:
    %       STRUCDISP.m by
    %       Contact author: B. Roossien <roossien@ecn.nl>
    %       (c) ECN 2007-2008
    %       Version 1.3.0
    %

    if sortfields, Structure = orderfields(Structure); end

    listStr = {};
    if length(Structure) > 1
        if (printValues == 0)
            varStr = createArraySize(Structure, structname);
            listStr = [{' '}; {[structname, varStr]}];
            body = recFieldPrint(Structure(1), indent, depth, ...
                                 printValues, maxArrayLength, '', sortfields);
            listStr = [listStr; body];
        else
            for iStruc = 1 : length(Structure)
                listStr = [listStr; {' '}; {sprintf('%s(%d)', structname, iStruc)}];
                body = recFieldPrint(Structure(iStruc), indent, depth, ...
                                     printValues, maxArrayLength, '', sortfields);
                listStr = [listStr; body];
            end
        end
        return
    end

    fields      = fieldnames(Structure);
    isStruct    = structfun(@isstruct, Structure);
    strucFields = fields(isStruct == 1);
    strIndent   = getIndentation(indent + 1);
    listStr     = [listStr; {strIndent}];
    strIndent   = getIndentation(indent);
    for iField = 1 : length(strucFields)

        fieldName = cell2mat(strucFields(iField));
        Field =  Structure.(fieldName);

        % Empty structure
        if isempty(Field)
            strSize = createArraySize(Field, 'Structure');
            line = sprintf('%s   |--- %s :%s', ...
                           strIndent, fieldName, strSize);
            listStr = [listStr; {line}];
        % Scalar structure
        elseif isscalar(Field)
            line = sprintf('%s   |--- %s', strIndent, fieldName);
            % Recall this function if the tree depth is not reached yet
            if (depth < 0) || (indent + 1 < depth)
                lines = recFieldPrint(Field, indent + 1, depth, ...
                                      printValues, maxArrayLength, '', sortfields);
                listStr = [listStr; {line}; lines];
            else
                listStr = [listStr; {line}];
            end
        % Short vector structure of which the values should be printed
        elseif (isvector(Field)) &&  ...
               (printValues > 0) && ...
               (length(Field) < maxArrayLength) && ...
               ((depth < 0) || (indent + 1 < depth))
            % Use a for-loop to print all structures in the array
            for iFieldElement = 1 : length(Field)
                line = sprintf('%s   |--- %s(%g)', ...
                               strIndent, fieldName, iFieldElement);
                lines = recFieldPrint(Field(iFieldElement), indent + 1, ...
                                     depth, printValues, maxArrayLength, '', sortfields);
                listStr = [listStr; {line}; lines];
                if iFieldElement ~= length(Field)
                    listStr = [listStr; {[strIndent '   |    ']}];
                end
            end
        % Structure is a matrix or long vector
        % No values have to be printed or depth limit is reached
        else
            varStr = createArraySize(Field, 'Structure');
            line = sprintf('%s   |--- %s :%s', ...
                           strIndent, fieldName, varStr);
            lines = recFieldPrint(Field(1), indent + 1, depth, ...
                                  0, maxArrayLength, '', sortfields);
            listStr = [listStr; {line}; lines];
        end
        % Some extra blank lines to increase readability
        listStr = [listStr; {[strIndent '   |    ']}];

    end % End iField for-loop
    %% Field Filler
    % To properly align the field names, a filler is required. To know how long
    % the filler must be, the length of the longest fieldname must be found.
    % Because 'fields' is a cell array, the function 'cellfun' can be used to
    % extract the lengths of all fields.
    maxFieldLength = max(cellfun(@length, fields));
    %% Print non-structure fields without values
    % Print non-structure fields without the values. This can be done very
    % quick.
    if printValues == 0
        noStrucFields = fields(isStruct == 0);
        for iField  = 1 : length(noStrucFields)
            Field   = cell2mat(noStrucFields(iField));
            filler  = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
            listStr = [listStr; {[strIndent '   |' filler ' ' Field]}];
        end
        return
    end
    %% Select non-structure fields (to print with values)
    % Select fields that are not a structure and group them by data type. The
    % following groups are distinguished:
    %   - characters and strings
    %   - numeric arrays
    %   - logical
    %   - empty arrays
    %   - matrices
    %   - numeric scalars
    %   - cell arrays
    %   - other data types
    % Character or string (array of characters)
    isChar        = structfun(@ischar, Structure);
    charFields    = fields(isChar == 1);
    % Numeric fields
    isNumeric     = structfun(@isnumeric, Structure);
    % Numeric scalars
    isScalar      = structfun(@isscalar, Structure);
    isScalar      = isScalar .* isNumeric;
    scalarFields  = fields(isScalar == 1);
    % Numeric vectors (arrays)
    isVector      = structfun(@isvector, Structure);
    isVector      = isVector .* isNumeric .* not(isScalar);
    vectorFields  = fields(isVector == 1);
    % Logical fields
    isLogical     = structfun(@islogical, Structure);
    logicalFields = fields(isLogical == 1);
    % Empty arrays
    isEmpty       = structfun(@isempty, Structure);
    emptyFields   = fields(isEmpty == 1);
    % Numeric matrix with dimension size 2 or higher
    isMatrix      = structfun(@(x) ndims(x) >= 2, Structure);
    isMatrix      = isMatrix .* isNumeric .* not(isVector) .* not(isScalar) .* not(isEmpty);
    matrixFields  = fields(isMatrix == 1);
    % Cell array
    isCell        = structfun(@iscell, Structure);
    cellFields    = fields(isCell == 1);
    % Datatypes that are not checked for
    isOther       = not(isChar + isNumeric + isCell + isStruct + isLogical + isEmpty);
    otherFields   = fields(isOther == 1);
    %% Print non-structure fields
    % Print all the selected non structure fields
    % - Strings are printed to a certain amount of characters
    % - Vectors are printed as long as they are shorter than maxArrayLength
    % - Matrices are printed if they have less elements than maxArrayLength
    % - The values of cells are not printed
    % Start with printing strings and characters. To avoid the display screen
    % becoming a mess, the part of the string that is printed is limited to 31
    % characters. In the future this might become an optional parameter in this
    % function, but for now, it is placed in the code itself.
    % if the string is longer than 31 characters, only the first 31  characters
    % are printed, plus three dots to denote that the string is longer than
    % printed.
    maxStrLength = 31;
    for iField = 1 : length(charFields)
        Field   = cell2mat(charFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        if (size(Structure.(Field), 1) > 1) && (size(Structure.(Field), 2) > 1)
            varStr = createArraySize(Structure.(Field), 'char');
        elseif length(Field) > maxStrLength
            Val   = Structure.(Field);
            varStr = sprintf(' ''%s...''', Val(1:end));
        else
            varStr = sprintf(' ''%s''', Structure.(Field));
        end
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' :' varStr]}];
    end
    % Print empty fields
    for iField = 1 : length(emptyFields)
        Field = cell2mat(emptyFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' : [ ]' ]}];
    end
    % Print logicals. If it is a scalar, print true/false, else print vector
    % information
    for iField = 1 : length(logicalFields)
        Field = cell2mat(logicalFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        if isscalar(Structure.(Field))
            logicalValue = {'False', 'True'};
            varStr = sprintf(' %s', logicalValue{Structure.(Field) + 1});
        else
            varStr = createArraySize(Structure.(Field), 'Logic array');
        end
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' :' varStr]}];
    end
    % Print numeric scalar field. The %g format is used, so that integers,
    % floats and exponential numbers are printed in their own format.
    for iField = 1 : length(scalarFields)
        Field = cell2mat(scalarFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        varStr = sprintf(' %g', Structure.(Field));
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' :' varStr]}];
    end
    % Print numeric array. If the length of the array is smaller then
    % maxArrayLength, then the values are printed. Else, print the length of
    % the array.
    for iField = 1 : length(vectorFields)
        Field = cell2mat(vectorFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        if length(Structure.(Field)) > maxArrayLength
            varStr = createArraySize(Structure.(Field), 'Array');
        else
            varStr = sprintf('%g ', Structure.(Field));
            varStr = ['[' varStr(1:length(varStr) - 1) ']'];
        end
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' : ' varStr]}];
    end
    % Print numeric matrices. If the matrix is two-dimensional and has more
    % than maxArrayLength elements, only its size is printed.
    % If the matrix is 'small', the elements are printed in a matrix structure.
    % The top and the bottom of the matrix is indicated by a horizontal line of
    % dashes. The elements are also lined out by using a fixed format
    % (%#10.2e). Because the name of the matrix is only printed on the first
    % line, the space is occupied by this name must be filled up on the other
    % lines. This is done by defining a 'filler2'.
    % This method was developed by S. Wegerich.
    for iField = 1 : length(matrixFields)
        Field = cell2mat(matrixFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        if numel(Structure.(Field)) > maxArrayLength
            varStr = createArraySize(Structure.(Field), 'Array');
            varCell = {[strIndent '   |' filler ' ' Field ' :' varStr]};
        else
            matrixSize = size(Structure.(Field));
            filler2 = char(ones(1, maxFieldLength + 6) * 32);
            dashes = char(ones(1, 12 * matrixSize(2) + 1) * 45);
            varCell = {[strIndent '   |' filler2 dashes]};

            % first line with field name
            varStr = sprintf('%#10.2e |', Structure.(Field)(1, :));
            varCell = [varCell; {[strIndent '   |' filler ' ' ...
                                  Field ' : |' varStr]}];
            % second and higher number rows
            for j = 2 : matrixSize(1)
                varStr = sprintf('%#10.2e |', Structure.(Field)(j, :));
                varCell = [varCell; {[strIndent '   |' filler2 '|' varStr]}];
            end
            varCell = [varCell; {[strIndent '   |' filler2 dashes]}];

        end

        listStr = [listStr; varCell];
    end
    % Print cell array information, i.e. the size of the cell array. The
    % content of the cell array is not printed.
    for iField = 1 : length(cellFields)
        Field = cell2mat(cellFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        varStr = createArraySize(Structure.(Field), 'Cell');
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' :' varStr]}];
    end
    % Print unknown datatypes. These include objects and user-defined classes
    for iField = 1 : length(otherFields)
        Field = cell2mat(otherFields(iField));
        filler = char(ones(1, maxFieldLength - length(Field) + 2) * 45);
        varStr = createArraySize(Structure.(Field), 'Unknown');
        listStr = [listStr; {[strIndent '   |' filler ' ' Field ' :' varStr]}];
    end
    end
function str    = getIndentation(indent)
        x = '   |    ';
        str = '';

        for i = 1 : indent
            str = cat(2, str, x);
        end
    end
function varStr = createArraySize(varName, type)
        varSize = size(varName);

        arraySizeStr = sprintf('%gx', varSize);
        arraySizeStr(length(arraySizeStr)) = [];

        varStr = [' [' arraySizeStr ' ' type ']'];
    end
% end of this internal function

%%**************************************************.
%%*ez.join.
%%**************************************************.
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
end % end of this internal function

%%**************************************************.
%%*ez.abspath.
%%**************************************************.
function File = GetFullPath(File, Style)
% GetFullPath - Get absolute canonical path of a file or folder
% Absolute path names are safer than relative paths, when e.g. a GUI or TIMER
% callback changes the current directory. Only canonical paths without "." and
% ".." can be recognized uniquely.
% Long path names (>259 characters) require a magic initial key "\\?\" to be
% handled by Windows API functions, e.g. for Matlab's FOPEN, DIR and EXIST.
%
% FullName = GetFullPath(Name, Style)
% INPUT:
%   Name:  String or cell string, absolute or relative name of a file or
%          folder. The path need not exist. Unicode strings, UNC paths and long
%          names are supported.
%   Style: Style of the output as string, optional, default: 'auto'.
%          'auto': Add '\\?\' or '\\?\UNC\' for long names on demand.
%          'lean': Magic string is not added.
%          'fat':  Magic string is added for short names also.
%          The Style is ignored when not running under Windows.
%
% OUTPUT:
%   FullName: Absolute canonical path name as string or cell string.
%          For empty strings the current directory is replied.
%          '\\?\' or '\\?\UNC' is added on demand.
%
% NOTE: The M- and the MEX-version create the same results, the faster MEX
%   function works under Windows only.
%   Some functions of the Windows-API still do not support long file names.
%   E.g. the Recycler and the Windows Explorer fail even with the magic '\\?\'
%   prefix. Some functions of Matlab accept 260 characters (value of MAX_PATH),
%   some at 259 already. Don't blame me.
%   The 'fat' style is useful e.g. when Matlab's DIR command is called for a
%   folder with les than 260 characters, but together with the file name this
%   limit is exceeded. Then "dir(GetFullPath([folder, '\*.*], 'fat'))" helps.
%
% EXAMPLES:
%   cd(tempdir);                    % Assumed as 'C:\Temp' here
%   GetFullPath('File.Ext')         % 'C:\Temp\File.Ext'
%   GetFullPath('..\File.Ext')      % 'C:\File.Ext'
%   GetFullPath('..\..\File.Ext')   % 'C:\File.Ext'
%   GetFullPath('.\File.Ext')       % 'C:\Temp\File.Ext'
%   GetFullPath('*.txt')            % 'C:\Temp\*.txt'
%   GetFullPath('..')               % 'C:\'
%   GetFullPath('..\..\..')         % 'C:\'
%   GetFullPath('Folder\')          % 'C:\Temp\Folder\'
%   GetFullPath('D:\A\..\B')        % 'D:\B'
%   GetFullPath('\\Server\Folder\Sub\..\File.ext')
%                                   % '\\Server\Folder\File.ext'
%   GetFullPath({'..', 'new'})      % {'C:\', 'C:\Temp\new'}
%   GetFullPath('.', 'fat')         % '\\?\C:\Temp\File.Ext'
%
% COMPILE:
%   Automatic: InstallMex GetFullPath.c uTest_GetFullPath
%   Manual:    mex -O GetFullPath.c
%   Download:  http://www.n-simon.de/mex
% Run the unit-test uTest_GetFullPath after compiling.
%
% Tested: Matlab 6.5, 7.7, 7.8, 7.13, WinXP/32, Win7/64
%         Compiler: LCC2.4/3.8, BCC5.5, OWC1.8, MSVC2008/2010
% Assumed Compatibility: higher Matlab versions
% Author: Jan Simon, Heidelberg, (C) 2009-2016 matlab.2010(a)n(MINUS)simon.de
%
% See also: CD, FULLFILE, FILEPARTS.

% $JRev: R-G V:032 Sum:zBDFj0/m8a0f Date:15-Jan-2013 01:06:12 $
% $License: BSD (use/copy/change/redistribute on own risk, mention the author) $
% $UnitTest: uTest_GetFullPath $
% $File: Tools\GLFile\GetFullPath.m $
% History:
% 001: 20-Apr-2010 22:28, Successor of Rel2AbsPath.
% 010: 27-Jul-2008 21:59, Consider leading separator in M-version also.
% 011: 24-Jan-2011 12:11, Cell strings, '~File' under linux.
%      Check of input types in the M-version.
% 015: 31-Mar-2011 10:48, BUGFIX: Accept [] as input as in the Mex version.
%      Thanks to Jiro Doke, who found this bug by running the test function for
%      the M-version.
% 020: 18-Oct-2011 00:57, BUGFIX: Linux version created bad results.
%      Thanks to Daniel.
% 024: 10-Dec-2011 14:00, Care for long names under Windows in M-version.
%      Improved the unittest function for Linux. Thanks to Paul Sexton.
% 025: 09-Aug-2012 14:00, In MEX: Paths starting with "\\" can be non-UNC.
%      The former version treated "\\?\C:\<longpath>\file" as UNC path and
%      replied "\\?\UNC\?\C:\<longpath>\file".
% 032: 12-Jan-2013 21:16, 'auto', 'lean' and 'fat' style.

% Initialize: ==================================================================
% Do the work: =================================================================

% #############################################
% ### USE THE MUCH FASTER MEX ON WINDOWS!!! ###
% #############################################

% Difference between M- and Mex-version:
% - Mex does not work under MacOS/Unix.
% - Mex calls Windows API function GetFullPath.
% - Mex is much faster.

% Magix prefix for long Windows names:
if nargin < 2
   Style = 'auto';
end

% Handle cell strings:
% NOTE: It is faster to create a function @cell\GetFullPath.m under Linux, but
% under Windows this would shadow the fast C-Mex.
if isa(File, 'cell')
   for iC = 1:numel(File)
      File{iC} = GetFullPath(File{iC}, Style);
   end
   return;
end

% Check this once only:
isWIN    = strncmpi(computer, 'PC', 2);
MAX_PATH = 260;

% Warn once per session (disable this under Linux/MacOS):
persistent hasDataRead
if isempty(hasDataRead)
   % Test this once only - there is no relation to the existence of DATAREAD!
   %if isWIN
   %   Show a warning, if the slower Matlab version is used - commented, because
   %   this is not a problem and it might be even useful when the MEX-folder is
   %   not inlcuded in the path yet.
   %   warning('JSimon:GetFullPath:NoMex', ...
   %      ['GetFullPath: Using slow Matlab-version instead of fast Mex.', ...
   %       char(10), 'Compile: InstallMex GetFullPath.c']);
   %end
   
   % DATAREAD is deprecated in 2011b, but still available. In Matlab 6.5, REGEXP
   % does not know the 'split' command, therefore DATAREAD is preferred:
   hasDataRead = ~isempty(which('dataread'));
end

if isempty(File)  % Accept empty matrix as input:
   if ischar(File) || isnumeric(File)
      File = cd;
      return;
   else
      error(['JSimon:', mfilename, ':BadTypeInput1'], ...
         ['*** ', mfilename, ': Input must be a string or cell string']);
   end
end

if ischar(File) == 0  % Non-empty inputs must be strings
   error(['JSimon:', mfilename, ':BadTypeInput1'], ...
      ['*** ', mfilename, ': Input must be a string or cell string']);
end

if isWIN  % Windows: --------------------------------------------------------
   FSep = '\';
   File = strrep(File, '/', FSep);
   
   % Remove the magic key on demand, it is appended finally again:
   if strncmp(File, '\\?\', 4)
      if strncmpi(File, '\\?\UNC\', 8)
         File = ['\', File(7:length(File))];  % Two leading backslashes!
      else
         File = File(5:length(File));
      end
   end
   
   isUNC   = strncmp(File, '\\', 2);
   FileLen = length(File);
   if isUNC == 0                        % File is not a UNC path
      % Leading file separator means relative to current drive or base folder:
      ThePath = cd;
      if File(1) == FSep
         if strncmp(ThePath, '\\', 2)   % Current directory is a UNC path
            sepInd  = strfind(ThePath, '\');
            ThePath = ThePath(1:sepInd(4));
         else
            ThePath = ThePath(1:3);     % Drive letter only
         end
      end
      
      if FileLen < 2 || File(2) ~= ':'  % Does not start with drive letter
         if ThePath(length(ThePath)) ~= FSep
            if File(1) ~= FSep
               File = [ThePath, FSep, File];
            else                        % File starts with separator:
               File = [ThePath, File];
            end
         else                           % Current path ends with separator:
            if File(1) ~= FSep
               File = [ThePath, File];
            else                        % File starts with separator:
               ThePath(length(ThePath)) = [];
               File = [ThePath, File];
            end
         end
         
      elseif FileLen == 2 && File(2) == ':'   % "C:" current directory on C!
         % "C:" is the current directory on the C-disk, even if the current
         % directory is on another disk! This was ignored in Matlab 6.5, but
         % modern versions considers this strange behaviour.
         if strncmpi(ThePath, File, 2)
            File = ThePath;
         else
            try
               File = cd(cd(File));
            catch    % No MException to support Matlab6.5...
               if exist(File, 'dir')  % No idea what could cause an error then!
                  rethrow(lasterror);
               else  % Reply "K:\" for not existing disk:
                  File = [File, FSep];
               end
            end
         end
      end
   end
   
else         % Linux, MacOS: ---------------------------------------------------
   FSep = '/';
   File = strrep(File, '\', FSep);
   
   if strcmp(File, '~') || strncmp(File, '~/', 2)  % Home directory:
      HomeDir = getenv('HOME');
      if ~isempty(HomeDir)
         File(1) = [];
         File    = [HomeDir, File];
      end
      
   elseif strncmpi(File, FSep, 1) == 0
      % Append relative path to current folder:
      ThePath = cd;
      if ThePath(length(ThePath)) == FSep
         File = [ThePath, File];
      else
         File = [ThePath, FSep, File];
      end
   end
end

% Care for "\." and "\.." - no efficient algorithm, but the fast Mex is
% recommended at all!
if ~isempty(strfind(File, [FSep, '.']))
   if isWIN
      if strncmp(File, '\\', 2)  % UNC path
         index = strfind(File, '\');
         if length(index) < 4    % UNC path without separator after the folder:
            return;
         end
         Drive            = File(1:index(4));
         File(1:index(4)) = [];
      else
         Drive     = File(1:3);
         File(1:3) = [];
      end
   else  % Unix, MacOS:
      isUNC   = false;
      Drive   = FSep;
      File(1) = [];
   end
   
   hasTrailFSep = (File(length(File)) == FSep);
   if hasTrailFSep
      File(length(File)) = [];
   end
   
   if hasDataRead
      if isWIN  % Need "\\" as separator:
         C = dataread('string', File, '%s', 'delimiter', '\\');  %#ok<REMFF1>
      else
         C = dataread('string', File, '%s', 'delimiter', FSep);  %#ok<REMFF1>
      end
   else  % Use the slower REGEXP, when DATAREAD is not available anymore:
      C = regexp(File, FSep, 'split');
   end
   
   % Remove '\.\' directly without side effects:
   C(strcmp(C, '.')) = [];
   
   % Remove '\..' with the parent recursively:
   R = 1:length(C);
   for dd = reshape(find(strcmp(C, '..')), 1, [])
      index    = find(R == dd);
      R(index) = [];
      if index > 1
         R(index - 1) = [];
      end
   end
   
   if isempty(R)
      File = Drive;
      if isUNC && ~hasTrailFSep
         File(length(File)) = [];
      end
      
   elseif isWIN
      % If you have CStr2String, use the faster:
      %   File = CStr2String(C(R), FSep, hasTrailFSep);
      File = sprintf('%s\\', C{R});
      if hasTrailFSep
         File = [Drive, File];
      else
         File = [Drive, File(1:length(File) - 1)];
      end
      
   else  % Unix:
      File = [Drive, sprintf('%s/', C{R})];
      if ~hasTrailFSep
         File(length(File)) = [];
      end
   end
end

% "Very" long names under Windows:
if isWIN
   if ~ischar(Style)
      error(['JSimon:', mfilename, ':BadTypeInput2'], ...
         ['*** ', mfilename, ': Input must be a string or cell string']);
   end
   
   if (strncmpi(Style, 'a', 1) && length(File) >= MAX_PATH) || ...
         strncmpi(Style, 'f', 1)
      % Do not use [isUNC] here, because this concerns the input, which can
      % '.\File', while the current directory is an UNC path.
      if strncmp(File, '\\', 2)  % UNC path
         File = ['\\?\UNC', File(2:end)];
      else
         File = ['\\?\', File];
      end
   end
end
end % end of this internal function

                      %%**************************************************.
                      %%*jerry ez end.
                      %%**************************************************.
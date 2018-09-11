%%
function DieboldPublications

close all;
clear all;
clc;

%% Select data to load

PathName = '/Users/averygreen/Documents/CNSE/Diebold Lab/Zotero/Diebold Publication Sections/';
oldfolder = cd(PathName);
FileName = dir;
FileName = {FileName.name}';
FirstFile = strcmp(FileName,'Advanced X-Ray Microscopy of TSV Structures.csv');
FirstFile = find(FirstFile);
FileName = FileName(FirstFile:end);


if ischar(FileName)
    FileNameTemp = FileName;
    FileName = cell(1);
    FileName{1} = FileNameTemp;
end

if length(FileName) == 7,
    FileNameTemp = {FileName{4},...
        FileName{3},...
        FileName{2},...
        FileName{7},...
        FileName{5},...
        FileName{1},...
        FileName{6}};
    FileName = FileNameTemp;
end

test = 1;

%% Load up data. Will write later.

AllEntries = struct('FileName','','Entries',cell(1));

for i = 1:length(FileName)
    
    AllEntries(i).FileName = FileName{i}(1:end-4);
    
    NewFile = fopen(strcat(PathName, FileName{i}));
    C = textscan(NewFile, '%q','Delimiter',',');
    fclose(NewFile);
    
    NoEntries = length(C{1})/87 - 1;
    
    Key = cell(88,1);
    Key(1:87) = C{1}(1:87);
    
    Entries = cell(88,NoEntries);
    
    for j = 1:NoEntries
        Entries(1:87,j) = C{1}(87*j+1:87*(j+1));
        
        Entries{4,j} = ReformatAuthors(Entries{4,j});
        
        if length(Entries{12,j}) == 10
            Entries{12,j} = datestr(Entries{12,j}, 'mmm dd, yyyy');
            Entries{88,j} = datenum(Entries{12,j}, 'mmm dd, yyyy');
        elseif length(Entries{12,j}) == 7
            Entries{12,j} = datestr(Entries{12,j}, 'mmm, yyyy');
            Entries{88,j} = datenum(Entries{12,j}, 'mmm, yyyy');
        elseif length(Entries{12,j}) == 4
            Entries{88,j} = datenum(Entries{12,j}, 'yyyy');
        end
        
        test = 1;
    end
    
    [Dates Order] = sort([Entries{88,:}], 'descend');
    Entries = Entries(:, Order);
    
    AllEntries(i).Entries = Entries;
    
    test = 1;
    
end

test = 1;

%% Create netsted structure containing all entries formatted for site
%{
    Field 1 = Optical Properties of 2D and Topological Materials
    Field 2 = Mueller Matrix based Scatterometry
    Field 3 = High K- Metal Gate and Interconnect Barrier Characterization
    Field 4 = X-Ray Based Transistor Fin Metrology
    Field 5 = Optical Properties/ Semiconductors, Dielectrics, and Metals
    Field 6 = Advanced X-Ray Microscopy of TSV Structures
    Field 7 = Reference materials Measurements and Advanced TEM
%}

for i = 1:length(AllEntries)
    
    SiteEntriesUnformatted(i).section = AllEntries(i).FileName;
    SiteEntriesUnformatted(i).strings = {AllEntries(i).Entries{5,:};AllEntries(i).Entries{4,:}};
    
    SiteEntriesFormatted(i).section = horzcat('<b>',SiteEntriesUnformatted(i).section,'</b>');
    SiteEntriesFormatted(i).strings = SiteEntriesUnformatted(i).strings;
    SiteEntriesFormatted(i).strings(1,:) = ReplaceSubscripts(SiteEntriesFormatted(i).strings(1,:));
    
    for j = 1:size(SiteEntriesFormatted(i).strings,2)
        SiteEntriesFormatted(i).strings{1,j} = horzcat('<i>',SiteEntriesFormatted(i).strings{1,j},'</i>');
        
        if strcmp(AllEntries(i).Entries{2,j}, 'conferencePaper')
            
            %Conference
            SiteEntriesUnformatted(i).strings{3,j} = 'Conference:';
            SiteEntriesFormatted(i).strings{3,j} = horzcat('<b>Conference:</b> ');
            if isempty(AllEntries(i).Entries{72,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j}, AllEntries(i).Entries{72,j});
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j}, AllEntries(i).Entries{72,j});
            end
            
            %Page Number(s)
            if isempty(AllEntries(i).Entries{16,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},', pp. ',AllEntries(i).Entries{16,j});
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},', pp. ',AllEntries(i).Entries{16,j});            
            end
            
            %Date
            if isempty(AllEntries(i).Entries{12,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},' (',AllEntries(i).Entries{12,j},')');
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},' (',AllEntries(i).Entries{12,j},')');
            end
            
            %Link
            if isempty(AllEntries(i).Entries{10,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},'(Abstract)');
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},' <a href="',AllEntries(i).Entries{10,j},'" target="_blank">(Abstract)</a>');
            end
            
        elseif strcmp(AllEntries(i).Entries{2,j}, 'journalArticle')
            
            %Journal
            if isempty(AllEntries(i).Entries{21,j})
                SiteEntriesUnformatted(i).strings{3,j} = AllEntries(i).Entries{6,j};
                SiteEntriesFormatted(i).strings{3,j} = AllEntries(i).Entries{6,j};
            else
                SiteEntriesUnformatted(i).strings{3,j} = AllEntries(i).Entries{21,j};
                SiteEntriesFormatted(i).strings{3,j} = AllEntries(i).Entries{21,j};
            end
            
            %Volume
            if isempty(AllEntries(i).Entries{19,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},' ',AllEntries(i).Entries{19,j});
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},' <b>',AllEntries(i).Entries{19,j},'</b>');
            end
            
            %Issue
            if isempty(AllEntries(i).Entries{18,j})
            else               
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},'(',AllEntries(i).Entries{18,j},')');
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},'(',AllEntries(i).Entries{18,j},')');
            end
            
            %Year
            if isempty(AllEntries(i).Entries{3,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},', (',AllEntries(i).Entries{3,j},')');
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},', (',AllEntries(i).Entries{3,j},')');
            end
            
            %Page Number(s)
            if isempty(AllEntries(i).Entries{16,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},', pp. ',AllEntries(i).Entries{16,j});
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},', pp. ',AllEntries(i).Entries{16,j});
            end
            
            %Link
            if isempty(AllEntries(i).Entries{10,j})
            else
                SiteEntriesUnformatted(i).strings{3,j} = horzcat(SiteEntriesUnformatted(i).strings{3,j},' (Abstract)');
                SiteEntriesFormatted(i).strings{3,j} = horzcat(SiteEntriesFormatted(i).strings{3,j},' <a href="',AllEntries(i).Entries{10,j},'" target="_blank">(Abstract)</a>');              
            end
            
            test = 1;
            
        end
        
    end
     
    test = 1;
    
end


%% Write formatted list
cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Zotero/');

NewFile = fopen('Formatted Publications.txt', 'w+');

for i = 1:length(SiteEntriesFormatted)
    
    fprintf(NewFile, '%s\n\n<ul>\n', SiteEntriesFormatted(i).section);
    
    for j = 1:size(SiteEntriesFormatted(i).strings,2)
        
        fprintf(NewFile, '<li>\n%s\n%s\n%s\n</li>\n',...
            SiteEntriesFormatted(i).strings{1,j},...
            SiteEntriesFormatted(i).strings{2,j},...
            SiteEntriesFormatted(i).strings{3,j});
        
%         fprintf(NewFile, '<li>\n%s', SiteEntriesFormatted(i).strings{1,j});
%         fprintf(NewFile, '\n%s', SiteEntriesFormatted(i).strings{2,j});
%         fprintf(NewFile, '\n%s\n</li>\n', SiteEntriesFormatted(i).strings{3,j});
        
%         fprintf('<a href = "%s">%s</a>\n',site,title)
    end
    
    fprintf(NewFile, '</ul>\n\n\n');
    
end

test = 1;

fclose(NewFile);

cd(oldfolder);

end

%%
function AuthorList = ReformatAuthors(UnformattedAuthors)

AuthorCellTemp = textscan(UnformattedAuthors,'%s', 'Delimiter', ';');
AuthorCell = cell(length(AuthorCellTemp{1}),2);
AuthorCell(:,1) = AuthorCellTemp{1};
for k = 1:size(AuthorCell,1)
    AuthorCellTemp = textscan(AuthorCell{k,1},'%s','Delimiter',',');
    AuthorCell{k,1} = AuthorCellTemp{1}{2};
    AuthorCell{k,2} = AuthorCellTemp{1}{1};
end

AuthorList = '';
if size(AuthorCell,1) == 1
    
    AuthorList = horzcat(AuthorCell{1,1}, ' ', AuthorCell{1,2});
    
elseif size(AuthorCell,1) == 2
    
    AuthorList = horzcat(AuthorCell{1,1}, ' ', AuthorCell{1,2}, ' and ', AuthorCell{2,1}, ' ', AuthorCell{2,2});
    
else
    
    for k = 1:size(AuthorCell,1)-1
        AuthorList = horzcat(AuthorList, AuthorCell{k,1});
        AuthorList = horzcat(AuthorList, ' ');
        AuthorList = horzcat(AuthorList, AuthorCell{k,2});
        AuthorList = horzcat(AuthorList, ', ');
    end
    
    AuthorList = horzcat(AuthorList, 'and ');
    AuthorList = horzcat(AuthorList, AuthorCell{end,1});
    AuthorList = horzcat(AuthorList, ' ');
    AuthorList = horzcat(AuthorList, AuthorCell{end,2});
    
end

test = 1;

end

%%
function FormattedSubs = ReplaceSubscripts(UnformattedSubs)

[num,txt,raw] = xlsread('/Users/averygreen/Documents/CNSE/Diebold Lab/Zotero/elementTable.xlsx');

Elements = txt(:,4);

ElementsInt = cellfun(@(x) horzcat(x,'[2-9]'),Elements,'UniformOutput',false);

Elementsx = cellfun(@(x) horzcat(x,'x(?![a-z])'),Elements,'UniformOutput',false);
Elementsy = cellfun(@(x) horzcat(x,'y(?![a-z])'),Elements,'UniformOutput',false);
Elements1mx = cellfun(@(x) horzcat(x,'1-x(?![a-z])'),Elements,'UniformOutput',false);
Elements1mx2 = cellfun(@(x) horzcat(x,'1 − x(?![a-z])'),Elements,'UniformOutput',false);
Elements1my = cellfun(@(x) horzcat(x,'1-y(?![a-z])'),Elements,'UniformOutput',false);
TestCases = [Elementsx,Elementsy,Elements1mx,Elements1mx2,Elements1my];
clear Elementsx Elementsy Elements1mx Elements1mx2 Elements1my


% ReplaceInt = cellfun(@(x) horzcat(x,'<sub>%i</sub>'),Elements,'UniformOutput',false);
% ReplaceUInt = cellfun(@(x) horzcat(x,'<sub>%u</sub>'),Elements,'UniformOutput',false);

Replacex = cellfun(@(x) horzcat(x,'<sub>x</sub>'),Elements,'UniformOutput',false);
Replacey = cellfun(@(x) horzcat(x,'<sub>y</sub>'),Elements,'UniformOutput',false);
Replace1mx = cellfun(@(x) horzcat(x,'<sub>1-x</sub>'),Elements,'UniformOutput',false);
Replace1mx2 = cellfun(@(x) horzcat(x,'<sub>1-x</sub>'),Elements,'UniformOutput',false);
Replace1my = cellfun(@(x) horzcat(x,'<sub>1-y</sub>'),Elements,'UniformOutput',false);
Replacements = [Replacex,Replacey,Replace1mx,Replace1mx2,Replace1my];
clear Replacex Replacey Replace1mx Replace1mx2 Replace1my


FormattedSubs = UnformattedSubs;
for i = 1:length(FormattedSubs)
    
    %Replace element integer combo
    [matchstart,matchend] = regexp(FormattedSubs{i},ElementsInt,'Start');
    
    matchdims = cell2mat(cellfun(@(x) length(x), matchstart, 'UniformOutput',false));
    
    if max(matchdims) > 1
        test = 1;
    end
    
    Info = zeros(1,3);
    for j = find(matchdims)'
        for k = 1:matchdims(j)
            Info = [Info;j,matchstart{j}(k),matchend{j}(k)];
        end
    end
    Info(1,:) = [];
    
    if ~isempty(Info)
        Info = sortrows(Info,2);
        Info = flipud(Info);
        
        for j = 1:size(Info,1)
            FormattedSubs{i} = horzcat(FormattedSubs{i}(1:Info(j,2)-1),Elements{Info(j,1)},'<sub>',FormattedSubs{i}(Info(j,3)),'</sub>',FormattedSubs{i}(Info(j,3)+1:end));
        end
        
        test = 1;
    end
    
    %Replace composition subs
    FormattedSubs{i} = regexprep(FormattedSubs{i}, TestCases, Replacements);
    
    test = 1;
    
end

test = 1;

end

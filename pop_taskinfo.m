% pop_taskinfo() - BIDS task information
%
% Usage:
%     STUDY = pop_taskinfo(STUDY);
%
% Inputs:
%   STUDY - EEGLAB study
%
%
% Authors: Arnaud Delorme, Dung Truong SCCN, INC, UCSD, 2020

% Copyright (C) Arnaud Delorme, 2020
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

function [STUDY,com] = pop_taskinfo(STUDY)
    %% Default settings
    bg = [0.65 0.76 1];
    fg = [0 0 0.4];
    fontSize = 12;
    tfHeight = 0.04;
    
    f = figure('MenuBar', 'None', 'ToolBar', 'None', 'Name', 'BIDS task information -- pop_taskinfo()', 'Color', bg, 'IntegerHandle','off');
    f.Position(3) = 1000;
    f.Position(4) = 700;
    halfWidth = 0.5;

    %% Generic task info
    leftMargin = 0.02;
    fullWidth = halfWidth - leftMargin - 0.04;
    tfWidth = 0.35*fullWidth;
    efWidth = 0.63*fullWidth;
    efLeftMargin = leftMargin + tfWidth + 0.01;
    top = 0.92;
    uicontrol('Style', 'text', 'string', 'Add BIDS task information', 'fontweight', 'bold', 'fontsize',13,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top halfWidth 0.05]);
    top = top - 0.03;
    uicontrol('Style', 'text', 'string', 'Experiment name','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'Name','fontsize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]); 
    top = top - tfHeight - 0.01;
    uicontrol('Style', 'text', 'string', 'README (short introduction to the experiment):','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top fullWidth tfHeight]);
    top = top - tfHeight*2.2;
    uicontrol('Style', 'edit', 'string', '', 'tag', 'README','fontsize',fontSize, 'HorizontalAlignment', 'left', 'max', 3,'Units', 'normalized', 'Position', [leftMargin top fullWidth tfHeight*2.5]);
    top = top - tfHeight - 0.01;
    uicontrol('Style', 'text', 'string', 'Participant task information (description of the experiment):','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top fullWidth tfHeight]);
    top = top - tfHeight*2.7;
    uicontrol('Style', 'edit', 'string', '', 'tag', 'TaskDescription','fontsize',fontSize, 'HorizontalAlignment', 'left', 'max', 3,'Units', 'normalized', 'Position', [leftMargin top fullWidth tfHeight*3]);
    top = top - tfHeight - 0.01;
    uicontrol('Style', 'text', 'string', 'Participant instructions (exact as possible):','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top fullWidth tfHeight]);
    top = top - tfHeight*2.7;
    uicontrol('Style', 'edit', 'string', '', 'tag', 'Instructions', 'HorizontalAlignment', 'left', 'max', 3,'Units', 'normalized', 'Position', [leftMargin top fullWidth tfHeight*3]);
    top = top - tfHeight - 0.02;
    uicontrol('Style', 'text', 'string', 'Authors','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'Authors','fontsize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]); 
    top = top - tfHeight - 0.005;
    uicontrol('Style', 'text', 'string', 'References and links','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'ReferencesAndLinks','fontsize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]); 
    top = top - tfHeight - 0.005;
    cm = uicontextmenu(f);
    m1 = uimenu(cm,'Text','Lookup CognitiveAtlas TermURL','MenuSelectedFcn',{@btnCB,'http://www.cognitiveatlas.org/tasks/a/'});
    tooltip = sprintf('URL of the corresponding Cognitive Atlas term that describes the task.\nRight click to lookup.');
    uicontrol('Style', 'text', 'string', 'Task-relevant Cognitive Atlas term', 'Tooltip',tooltip,'UIContextMenu', cm,'fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top-0.005 tfWidth tfHeight+0.01]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'CogAtlasID','fontsize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]);
    top = top - tfHeight - 0.005;
    cm = uicontextmenu(f);
    m1 = uimenu(cm,'Text','Lookup CogPO TermURL','MenuSelectedFcn',{@btnCB,'http://wiki.cogpo.org/index.php?title=Main_Page'});
    tooltip = sprintf('URL of the corresponding CogPO term that describes the task.\nRight click to lookup.');
    uicontrol('Style', 'text', 'string', 'Task-relevant CogPO term', 'Tooltip',tooltip,'UIContextMenu', cm,'fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top 0.35*fullWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'CogPOID','Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]);
    top = top - tfHeight - 0.005;
    uicontrol('Style', 'text', 'string', 'Institution','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'InstitutionName','Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]); 
    top = top - tfHeight - 0.005;
    uicontrol('Style', 'text', 'string', 'Department','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'InstitutionalDepartmentName','Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]);    
    top = top - tfHeight - 0.005;    
    uicontrol('Style', 'text', 'string', 'Institution address','fontsize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg, 'HorizontalAlignment','left','Units', 'normalized', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '', 'tag', 'InstitutionAddress','Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight]);        
    uicontrol(f, 'Style', 'pushbutton', 'String', 'Help', 'FontSize',fontSize, 'Units', 'normalized', 'Position', [0.05 0.02 0.15 0.04], 'Callback', @helpCB); 
    uicontrol(f, 'Style', 'pushbutton', 'String', 'Ok', 'FontSize',fontSize, 'Units', 'normalized', 'Position', [0.80 0.02 0.15 0.04], 'Callback', @okCB); 
    uicontrol(f, 'Style', 'pushbutton', 'String', 'Cancel', 'FontSize',fontSize, 'Units', 'normalized', 'Position', [0.64 0.02 0.15 0.04], 'Callback', @cancelCB); 

    %% EEG specific info
    leftMargin = halfWidth;
    fullWidth = halfWidth - 0.03;
    tfWidth = 0.4*fullWidth;
    efWidth = 0.6*fullWidth;
    efLeftMargin = leftMargin + tfWidth + 0.01;
    top = 0.92;
    uicontrol('Style', 'text', 'string', 'Add BIDS EEG acquisition information', 'Units', 'normalized','FontSize',13,'FontWeight','bold','BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top 0.4 0.05]);
    top = top-0.03;
    uicontrol('Style', 'text', 'string', 'Cap manufacturer', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'CapManufacturer', 'FontSize',fontSize, 'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'Cap model', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'CapManufacturersModelName', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'EEG reference location', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'EEGreference', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'EEG ground', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'EEGGround', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'Electrode placements (10-20, 10-10, custom)', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight+0.01]);
    uicontrol('Style', 'edit', 'string', '','tag', 'EEGEEGPlacementScheme', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'EEG amplifier maker', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'Manufacturer', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB); 
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'EEG amplifier model', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight], 'Callback', @editedCB);
    uicontrol('Style', 'edit', 'string', '','tag', 'ManufacturersModelName', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB); 
    top = top-0.06;    
    uicontrol('Style', 'text', 'string', 'EEG amplifier serial #', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'DeviceSerialNumber', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);    
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'EEG acquisition software version', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight]);
    uicontrol('Style', 'edit', 'string', '','tag', 'SoftwareVersions', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);    
    top = top-0.06;
    tooltip = 'Format: "Filter name", "key", val, ...';
    uicontrol('Style', 'text', 'string', 'Hardware filters (see tooltip for format)', 'Tooltip', tooltip, 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight+0.002]);
    uicontrol('Style', 'edit', 'string', '','tag', 'HardwareFilters','FontSize',fontSize, 'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB);   
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'Software filters (see tooltip for format)', 'Tooltip', tooltip, 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth tfHeight+0.002]);
    uicontrol('Style', 'edit', 'string', '','tag', 'SoftwareFilters', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth tfHeight], 'Callback', @editedCB); 
    top = top-0.06;
    uicontrol('Style', 'text', 'string', 'Line frequency (Hz)', 'Units', 'normalized','FontSize',fontSize,'BackgroundColor',bg,'ForegroundColor',fg,'HorizontalAlignment','left', 'Position', [leftMargin top tfWidth 0.05]);
    uicontrol('Style', 'popupmenu', 'string', {'Select','50','60'},'tag', 'PowerLineFrequency', 'FontSize',fontSize,'Units', 'normalized', 'Position', [efLeftMargin top efWidth 0.05], 'Callback', @editedCB);
    
%% history
com = sprintf('pop_taskinfo(ALLEG);');

%% Helper functions
    function btnCB(src,event, url)
       web(url);
    end
    function helpCB(src,event)
        pophelp('pop_taskinfo');
    end
    function okCB(src,event)
        bids = [];
        tInfo = [];
        % preserve current BIDS info if have
        if isfield(STUDY, 'BIDS')
            bids = STUDY.BIDS;
            if isfield(bids, 'tInfo')
                tInfo = bids.tInfo;
            end
        end
        % update tInfo from input fields
        objs = findall(f);
        for i=1:numel(objs)
            if ~isempty(objs(i).Tag)
                if ~isempty(objs(i).String)
                    tInfo.(objs(i).Tag) = objs(i).String;
                end
            end
        end
        % update STUDY BIDS structure
        bids.tInfo = tInfo;
        STUDY.BIDS = bids;
        close(f);
    end
    function cancelCB(src, event)
        close(f);
    end
end
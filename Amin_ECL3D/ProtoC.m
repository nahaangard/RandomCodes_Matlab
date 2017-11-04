function varargout = ProtoC(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProtoC_OpeningFcn, ...
                   'gui_OutputFcn',  @ProtoC_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function ProtoC_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

function varargout = ProtoC_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function InitialPot_Edit_Callback(hObject, eventdata, handles)

function InitialPot_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FinalPot_Edit_Callback(hObject, eventdata, handles)

function FinalPot_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ScanRate_Edit_Callback(hObject, eventdata, handles)

function ScanRate_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Segments_Edit_Callback(hObject, eventdata, handles)

function Segments_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Cycles_Edit_Callback(hObject, eventdata, handles)

function Cycles_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function IntegTime_Edit_Callback(hObject, eventdata, handles)

function IntegTime_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DelaySpectras_Edit_Callback(hObject, eventdata, handles)

function DelaySpectras_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DelayTrig_Edit_Callback(hObject, eventdata, handles)

function DelayTrig_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MeshSize_Edit_Callback(hObject, eventdata, handles)

function MeshSize_Edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TimeTick_Callback(hObject, eventdata, handles)

function SurfTick_Callback(hObject, eventdata, handles)

function SurfCtopTick_Callback(hObject, eventdata, handles)

function MeshTick_Callback(hObject, eventdata, handles)

function Plot_Callback(hObject, eventdata, handles)

% Variables

handles=guidata(hObject);
Matrix=handles.Matrix;
Low_Pot=str2double(get(handles.InitialPot_Edit,'string'));
High_Pot=str2double(get(handles.FinalPot_Edit,'string'));
ScanRate=str2double(get(handles.ScanRate_Edit,'string'));
Segments=str2double(get(handles.Segments_Edit,'string'));
Cycles=str2double(get(handles.Cycles_Edit,'string'));
MeshSize=str2double(get(handles.MeshSize_Edit,'string'));
integ_Time=str2double(get(handles.IntegTime_Edit,'string'));
Delay_2=str2double(get(handles.DelaySpectras_Edit,'string'));
Ins_Delay=str2double(get(handles.DelayTrig_Edit,'string'));
Spectra_Time=integ_Time+Delay_2;
S=handles.S;
Counter=0;

% Core algorithm
colordef('black');
Wavelength=(Matrix(1:end,1));
Accumulations=(2:1:length(Matrix(1,1:end)));
Time_Axis=((Accumulations.*(Spectra_Time))-...
    (Ins_Delay+Spectra_Time));Time_Backup=Time_Axis;
Time_Axis(Time_Axis<0)=nan;
[row,col]=find(isnan(Time_Axis)); Matrix_Backup=Matrix;
Matrix(:,(col:max(col)+1))=nan;
Potential=(Time_Axis.*ScanRate);
Initial_point=max(col)+1;
%
[X,Y]=meshgrid(Time_Axis(1,Initial_point:MeshSize:end),Wavelength(1:MeshSize:end));
[V,W]=meshgrid(Potential(1,Initial_point:MeshSize:end),Wavelength(1:MeshSize:end));
Z=Matrix(1:MeshSize:end,Initial_point+1:MeshSize:end);
handles.W=W;handles.V=V;handles.Z=Z;
% Time graph

TimeTick=get(handles.TimeTick,'Value');
if TimeTick == 1
    Counter=Counter+1;
figure('name','Amin''s 3D-ECL Plotter - Time Graph','numbertitle','off');
surf(Y,X,Z);
% movegui('northeast');
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Time (s)');
zlabel('Intensity (Counts)');
title('Time Graph');
set(gca,'ytick',0:5:30);
shading(S)
end

% Potential Conversion

P=Potential;
[~,top]=min(abs(Potential-High_Pot));
top_Pot=P(top);
Step_Pot=ScanRate*Spectra_Time;
for i=(top+1):1:length(P)
P(i)=P(i-1)-(Step_Pot);
end
% yAxis Alignment
y1=min(P);y2=max(P);ystep=0.5; % Ticklabels increments
y=round([(y1:ystep:y2),(y2-ystep:-ystep:y1)]*100)/100; % Rounding yAxis ticklabels 
c=cellstr(num2str(y'));


% potential graph - surf

SurfTick=get(handles.SurfTick,'Value');
if SurfTick == 1
    Counter=Counter+1;
figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
surf(W,V,Z);
% movegui('southeast');
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Potential (E vs. V)');
zlabel('Intensity (Counts)');
title('Potential Graph');
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
shading(S)
end

% potential graph - surfCtop

SurfCtopTick=get(handles.SurfCtopTick,'Value');
if SurfCtopTick == 1
    Counter=Counter+1;
figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
surfctop(W,V,Z);
% movegui('southeast');
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Potential (E vs. V)');
zlabel('Intensity (Counts)');
title('Potential Graph');
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
shading(S)
end

% potential graph - mesh

MeshTick=get(handles.MeshTick,'Value');
if MeshTick == 1
    Counter=Counter+1;
figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
mesh(W,V,Z);
% movegui('northwest');
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Potential (E vs. V)');
zlabel('Intensity (Counts)');
title('Potential Graph');
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
shading(S)
end

% potential graph - meshCtop

MeshCtopTick=get(handles.MeshCtopTick,'Value');
if MeshCtopTick == 1
    Counter=Counter+1;
figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
meshctop(W,V,Z);
% movegui('northwest');
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Potential (E vs. V)');
zlabel('Intensity (Counts)');
title('Potential Graph');
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
shading(S)
end

%potential graph - contour

ContourTick=get(handles.ContourTick,'Value');
if ContourTick == 1
    Counter=Counter+1;
figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
% movegui('southwest');
contourf(W,V,Z,12,'showtext','on')
grid('on');
ylabel('Potential (E vs. V)');
xlabel('Wavelength (nm)');
title ('Contour Graph');
colorbar;
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
hold off
end
handles.Counter=Counter;
guidata(hObject,handles);

function uipushtool1_ClickedCallback(hObject, eventdata, handles)
handles=guidata(hObject);
[FileName, PathName] = uigetfile('*.csv');
FileName_A=strcat(PathName,FileName);
Matrix=dlmread(FileName_A,',',2,0);
set(handles.edit10,'string','Data-File has been successfully selected!');
handles.Matrix=Matrix;
guidata(hObject,handles);

function Untitled_1_Callback(hObject, eventdata, handles)

function Open_File_Menu_Callback(hObject, eventdata, handles)
handles=guidata(hObject);
[FileName, PathName] = uigetfile('*.csv');
FileName_A=strcat(PathName,FileName);
Matrix=dlmread(FileName_A,',',2,0);
handles.Matrix=Matrix;
set(handles.edit10,'string','Data-File has been successfully selected!');
guidata(hObject,handles);

function Close_Menu_Callback(hObject, eventdata, handles)
closereq;
function MeshCtopTick_Callback(hObject, eventdata, handles)

function ContourTick_Callback(hObject, eventdata, handles)

function Axes1_Logo_CreateFcn(hObject, eventdata, handles)
axes(hObject);
imshow('logo5.jpg');

function uipanel5_SelectionChangeFcn(hObject, eventdata, handles)
handles=guidata(hObject);    
    h=get(handles.uipanel5,'SelectedObject');    
    S=get(h,'Tag');
    handles.S=S;
guidata(hObject,handles);

function edit10_Callback(hObject, eventdata, handles)

function edit10_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Cleaner_ClickedCallback(hObject, eventdata, handles)
set(handles.axes1,'HandleVisibility','off');
close all;
set(handles.axes1,'HandleVisibility','on');

function Animation_ClickedCallback(hObject, eventdata, handles)
handles=guidata(hObject);

Matrix=handles.Matrix;
Low_Pot=str2double(get(handles.InitialPot_Edit,'string'));
High_Pot=str2double(get(handles.FinalPot_Edit,'string'));
ScanRate=str2double(get(handles.ScanRate_Edit,'string'));
Segments=str2double(get(handles.Segments_Edit,'string'));
Cycles=str2double(get(handles.Cycles_Edit,'string'));
MeshSize=str2double(get(handles.MeshSize_Edit,'string'));
integ_Time=str2double(get(handles.IntegTime_Edit,'string'));
Delay_2=str2double(get(handles.DelaySpectras_Edit,'string'));
Ins_Delay=str2double(get(handles.DelayTrig_Edit,'string'));
Spectra_Time=integ_Time+Delay_2;

colordef('black');
Wavelength=(Matrix(1:end,1));
Accumulations=(2:1:length(Matrix(1,1:end)));
Time_Axis=((Accumulations.*(Spectra_Time))-...
    (Ins_Delay+Spectra_Time));Time_Backup=Time_Axis;
Time_Axis(Time_Axis<0)=nan;
[row,col]=find(isnan(Time_Axis)); Matrix_Backup=Matrix;
Matrix(:,(col:max(col)+1))=nan;
Potential=(Time_Axis.*ScanRate);
Initial_point=max(col)+1;

[V,W]=meshgrid(Potential(1,Initial_point:MeshSize:end),Wavelength(1:MeshSize:end));
Z=Matrix(1:MeshSize:end,Initial_point+1:MeshSize:end);

P=Potential;
[~,top]=min(abs(Potential-High_Pot));
top_Pot=P(top);
Step_Pot=ScanRate*Spectra_Time;
for i=(top+1):1:length(P)
P(i)=P(i-1)-(Step_Pot);
end
y1=min(P);y2=max(P);ystep=0.5; 
y=round([(y1:ystep:y2),(y2-ystep:-ystep:y1)]*100)/100; 

c=cellstr(num2str(y'));set(handles.axes1,'HandleVisibility','off');
close all;
set(handles.axes1,'HandleVisibility','on');


writerObj=VideoWriter('3DVideo.avi');
open(writerObj);

figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
surf(W,V,Z);
axis tight
set(gca,'nextplot','replacechildren');
set(gcf,'Render','zbuffer');
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Potential (E vs. V)');
zlabel('Intensity (Counts)');
title('Potential Graph');
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
shading interp;

view(-25,30);
for i=1:360
   view(-25+i,30); 
   frame = getframe(gcf);
   writeVideo(writerObj,frame);
   pause(0.06);
end
 close(writerObj);
guidata(hObject,handles);


% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(hObject, eventdata, handles)
handles=guidata(hObject);

Matrix=handles.Matrix;
Low_Pot=str2double(get(handles.InitialPot_Edit,'string'));
High_Pot=str2double(get(handles.FinalPot_Edit,'string'));
ScanRate=str2double(get(handles.ScanRate_Edit,'string'));
Segments=str2double(get(handles.Segments_Edit,'string'));
Cycles=str2double(get(handles.Cycles_Edit,'string'));
MeshSize=str2double(get(handles.MeshSize_Edit,'string'));
integ_Time=str2double(get(handles.IntegTime_Edit,'string'));
Delay_2=str2double(get(handles.DelaySpectras_Edit,'string'));
Ins_Delay=str2double(get(handles.DelayTrig_Edit,'string'));
Spectra_Time=integ_Time+Delay_2;

colordef('black');
Wavelength=(Matrix(1:end,1));
Accumulations=(2:1:length(Matrix(1,1:end)));
Time_Axis=((Accumulations.*(Spectra_Time))-...
    (Ins_Delay+Spectra_Time));Time_Backup=Time_Axis;
Time_Axis(Time_Axis<0)=nan;
[row,col]=find(isnan(Time_Axis)); Matrix_Backup=Matrix;
Matrix(:,(col:max(col)+1))=nan;
Potential=(Time_Axis.*ScanRate);
Initial_point=max(col)+1;

[V,W]=meshgrid(Potential(1,Initial_point:MeshSize:end),Wavelength(1:MeshSize:end));
Z=Matrix(1:MeshSize:end,Initial_point+1:MeshSize:end);

P=Potential;
[~,top]=min(abs(Potential-High_Pot));
top_Pot=P(top);
Step_Pot=ScanRate*Spectra_Time;
for i=(top+1):1:length(P)
P(i)=P(i-1)-(Step_Pot);
end
y1=min(P);y2=max(P);ystep=0.5; 
y=round([(y1:ystep:y2),(y2-ystep:-ystep:y1)]*100)/100; 

c=cellstr(num2str(y'));set(handles.axes1,'HandleVisibility','off');
close all;
set(handles.axes1,'HandleVisibility','on');


figure('name','Amin''s 3D-ECL Plotter - Potential Graph','numbertitle','off');
surf(W,V,Z);
colormap('hsv');
xlabel('Wavelength (nm)');
ylabel('Potential (E vs. V)');
zlabel('Intensity (Counts)');
title('Potential Graph');
set(gca,'yTick',0:ystep:length(P))
set(gca,'yticklabel',c);
shading interp;

view(-25,30);
for i=1:360
   view(-25+i,30); 
   pause(0.06);
end
 
guidata(hObject,handles);

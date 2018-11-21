function varargout = GUI_test(varargin)
% GUI_TEST MATLAB code for GUI_test.fig
%      GUI_TEST, by itself, creates textA new GUI_TEST or raises the existing
%      singleton*.
%
%      H = GUI_TEST returns the handle to textA new GUI_TEST or the handle to
%      the existing singleton*.
%
%      GUI_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TEST.M with the given input arguments.
%
%      GUI_TEST('Property','Value',...) creates textA new GUI_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above textA to modify the response to help GUI_test

% Last Modified by GUIDE v2.5 20-Nov-2018 22:47:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_test_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_test_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_test is made visible.
function GUI_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_test (see VARARGIN)

% Choose default command line output for GUI_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function sInit_Callback(hObject, eventdata, handles)
% hObject    handle to sInit (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sInit as textA
%        str2double(get(hObject,'String')) returns contents of sInit as textA double
disp('sInit changed!')


% --- Executes during object creation, after setting all properties.
function sInit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sInit (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop = 0;
guidata(hObject,handles)
Gui_PM(handles)



function tarPos_Callback(hObject, eventdata, handles)
% hObject    handle to tarPos (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tarPos as textA
%        str2double(get(hObject,'String')) returns contents of tarPos as textA double
disp('Target positions changed!')


% --- Executes during object creation, after setting all properties.
function tarPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tarPos (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uInit_Callback(hObject, eventdata, handles)
% hObject    handle to uInit (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uInit as textA
%        str2double(get(hObject,'String')) returns contents of uInit as textA double
disp('uInit changed!')

% --- Executes during object creation, after setting all properties.
function uInit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uInit (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SensingRange_Callback(hObject, eventdata, handles)
% hObject    handle to SensingRange (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SensingRange as textA
%        str2double(get(hObject,'String')) returns contents of SensingRange as textA double
disp('Sensing range changed!')


% --- Executes during object creation, after setting all properties.
function SensingRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SensingRange (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MSpace_Callback(hObject, eventdata, handles)
% hObject    handle to MSpace (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MSpace as textA
%        str2double(get(hObject,'String')) returns contents of MSpace as textA double
disp('Mission space changed!')



% --- Executes during object creation, after setting all properties.
function MSpace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MSpace (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop = 1;



function A_Val_Callback(hObject, eventdata, handles)
% hObject    handle to A_Val (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_Val as textA
%        str2double(get(hObject,'String')) returns contents of A_Val as textA double
disp('A_val changed!')


% --- Executes during object creation, after setting all properties.
function A_Val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_Val (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_Val_Callback(hObject, eventdata, handles)
% hObject    handle to B_Val (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_Val as textA
%        str2double(get(hObject,'String')) returns contents of B_Val as textA double
disp('B_val changed!')


% --- Executes during object creation, after setting all properties.
function B_Val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_Val (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have textA white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in R.
function R_Callback(hObject, eventdata, handles)
% hObject    handle to R (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of R
disp('R checkbox toggled!')
global stop;
stop = 1;



% --- Executes on button press in V_est1.
function V_est1_Callback(hObject, eventdata, handles)
% hObject    handle to V_est1 (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of V_est1
disp('V_est1 checkbox toggled!')
global stop;
stop = 1;


% --- Executes on button press in V_estN.
function V_estN_Callback(hObject, eventdata, handles)
% hObject    handle to V_estN (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of V_estN
disp('V_estN checkbox toggled!')
global stop;
stop = 1;


% --- Executes on button press in V.
function V_Callback(hObject, eventdata, handles)
% hObject    handle to V (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of V
disp('V checkbox toggled!')
global stop;
stop = 1;



% --- Executes on button press in Cooperation.
function Cooperation_Callback(hObject, eventdata, handles)
% hObject    handle to Cooperation (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Cooperation
disp('Cooperation checkbox toggled!')
global stop;
stop = 1;


% --- Executes on button press in ShortTerm.
function ShortTerm_Callback(hObject, eventdata, handles)
% hObject    handle to ShortTerm (see GCBO)
% eventdata  reserved - to be defined in textA future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('ShortTerm checkbox toggled!')
global stop;
stop = 1;

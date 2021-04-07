function varargout = intento2(varargin)
% INTENTO2 MATLAB code for intento2.fig
%      INTENTO2, by itself, creates a new INTENTO2 or raises the existing
%      singleton*.
%
%      H = INTENTO2 returns the handle to a new INTENTO2 or the handle to
%      the existing singleton*.
%
%      INTENTO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTENTO2.M with the given input arguments.
%
%      INTENTO2('Property','Value',...) creates a new INTENTO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before intento2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to intento2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help intento2

% Last Modified by GUIDE v2.5 18-Nov-2018 12:40:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @intento2_OpeningFcn, ...
    'gui_OutputFcn',  @intento2_OutputFcn, ...
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


% --- Executes just before intento2 is made visible.
function intento2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to intento2 (see VARARGIN)

% Choose default command line output for intento2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes intento2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
tec1=imread('logo.jpg');
tec2=imresize(tec1,5);
axes(handles.axes5);
imshow(tec2);


% --- Outputs from this function are returned to the command line.
function varargout = intento2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Kalhua.
function Kalhua_Callback(hObject, eventdata, handles)
% hObject    handle to Kalhua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%v=1;
%disp(v)
handles=guidata(hObject);
handles.proceso=1;
guidata(hObject, handles);

% --- Executes on button press in Proceso.
function Proceso_Callback(hObject, eventdata, handles)
% hObject    handle to Proceso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%z=get(handles.Kalhua,'Value')
handles=guidata(hObject);
z=handles.proceso;

if z~=3 && z>=0
    cam=webcam(1);
    cam.Resolution = '800x600';
    imgO=snapshot(cam);
    pause(.5)
    clear('cam')
    axes(handles.axes3);
    imshow(imgO)
    img = rgb2gray(imgO);
    img=im2bw(img,0.28); %se transforma en BW dependiendo del sabor
    img=imerode(img,[1 1 1 1]);
    img=imfill(img,'holes');
    SE=strel('rectangle',[15 25]);
    img = imopen(img,SE);
    img = bwareaopen(img, 30000);
    axes(handles.axes4);
    imshow(img)
    [t o] = bwlabel(img);
else
    cam=webcam(1);
    cam.Resolution = '800x600';
    imgO=snapshot(cam);
    pause(.5)
    clear('cam')
    axes(handles.axes3);
    imshow(imgO)
    img = rgb2gray(imgO);
    img=im2bw(img,0.2); %se transforma en BW dependiendo del sabor
    img=imerode(img,[1 1 1 1]);
    img=imfill(img,'holes');
    SE=strel('rectangle',[15 25]);
    img = imopen(img,SE);
    img = bwareaopen(img, 30000);
    axes(handles.axes4);
    imshow(img)
    [t o] = bwlabel(img);
end
if o==1
    f1=bwlabel(img);
    g1=regionprops(f1,'Area','Perimeter');
    g1 = struct2table(g1);
    
    cam=webcam(3);
    cam.Resolution = '1184x656';
    im=snapshot(cam);
    axes(handles.axes1);
    imshow(im)
    pause(.5)
    clear('cam')
    if (z==0)
        im=im2bw(im,.45);
        im = bwareaopen(im, 3000);
        se = strel('rectangle',[10,40]);
        im = imerode(im,se);
        im = imfill(im,'holes');
    elseif (z==1)
        im=im2bw(im,.48);
        im = bwareaopen(im, 3000);
        se = strel('rectangle',[10,40]);
        im = imerode(im,se);
        im = imfill(im,'holes');
    elseif (z==2)
        im=im2bw(im,.5);
        im = bwareaopen(im, 3000);
        se = strel('rectangle',[10,40]);
        im = imerode(im,se);
        im = imfill(im,'holes');
    elseif (z==3)
        im=rgb2gray(im);
        im=im2bw(im,.28);
        im = bwareaopen(im, 3000);
        se = strel('rectangle',[10,40]);
        im = imerode(im,se);
        im = imfill(im,'holes');
    end
    
    if g1.Area<1014001 && g1.Area>70000 && g1.Perimeter < 1231 && g1.Perimeter > 1000
        f=bwlabel(im); %se le pone una etiqueta a todos los objetos de la imagen
        g=regionprops(f,'Area'); %se obtiene el area de todos los objetos etiquetados
        areas=[g.Area]; % se guardan las areas de todos los objetos etiquetados
        minagua=find(130000<areas); % se guarda la posicion de los objetos que cumplan esos requisitos de area, para ver si hay una botella
        h=ismember(f,minagua); % se mantiene en la imagen solo el objeto en esa posición
        axes(handles.axes2);
        imshow(h)
        [k y]=bwlabel(h); %se verifica que exista un objeto en la imagen
        correctagua=find(210000<areas); %se busca que el objeto cumpla con los parametros de area minima de la botella
        h=ismember(f,correctagua); %se mantiene en la imagen solo el objeto que cumpla con las caracteristicas
        [k m]=bwlabel(h); %se verifica que exista un objeto en la imagen
        if m==1 && y==1 %si en las dos fotos hay un objeto, significa que tiene disolusion correcta, porque se pudo detectar el objeto y el nivel correcto porque cumple con el area de la botella
            g=regionprops(h,'BoundingBox');
            if (g.BoundingBox(3)<1200 && g.BoundingBox(3)>950 && g.BoundingBox(4)<315 && g.BoundingBox(4)>275) % se puede checar ahora si abolladuras, se utiliza bounding box y se verifica que los lados de la caja sean parecidos a los que debe medir la botella
                set(handles.text2,'String','Nivel correcto y dilusión correcta, No esta abollada');
            else
                set(handles.text2,'String','Nivel correcto y dilusión correcta, esta abollada');
            end
        elseif m==0 && y==1 %si se detecta que hay un objeto con el minimo de area pero no con el minimo necesario de botella, significa que pudo detectar el la botella por lo que la disolución es correcta, pero que no cumple con el nivel deseado, asi que el bounding box daria incorrecto por lo que no se checan abolladuras
            set(handles.text2,'String','Nivel incorrecto y dilusión correcta, abolladuras inconclusas');
        elseif m==0 && y==0 %no se detecto ningun objeto por lo que la disolusión es incorrecta así que no se puede obtener
            set(handles.text2,'String','Nivel incorrecto y dilusión incorrecta, abolladuras inconclusas');
        end
    else
        f=bwlabel(im); %se le pone una etiqueta a todos los objetos de la imagen
        g=regionprops(f,'Area'); %se obtiene el area de todos los objetos etiquetados
        areas=[g.Area]; % se guardan las areas de todos los objetos etiquetados
        minagua=find(130000<areas); % se guarda la posicion de los objetos que cumplan esos requisitos de area, para ver si hay una botella
        h=ismember(f,minagua); % se mantiene en la imagen solo el objeto en esa posición
        axes(handles.axes2);
        imshow(h)
        [k y]=bwlabel(h); %se verifica que exista un objeto en la imagen
        if y==1 %si se detecta que hay un objeto con el minimo de area pero no con el minimo necesario de botella, significa que pudo detectar el la botella por lo que la disolución es correcta, pero que no cumple con el nivel deseado, asi que el bounding box daria incorrecto por lo que no se checan abolladuras
            set(handles.text2,'String','Esta abollada, dilusion correcta y es imposible concluir nivel');
        elseif y==0 %no se detecto ningun objeto por lo que la disolusión es incorrecta así que no se puede obtener
            set(handles.text2,'String','Esta abollada, dilusion incorrecta y es imposible concluir nivel');
        end
    end
else
    cam=webcam(3);
    cam.Resolution = '1184x656';
    im=snapshot(cam);
    axes(handles.axes1);
    imshow(im)
    pause(.5)
    clear('cam')
    im=im2bw(im,1);
    axes(handles.axes2);
    imshow(im);
    set(handles.text2,'String','No hay botella');
end


% --- Executes on button press in Coco.
function Coco_Callback(hObject, eventdata, handles)
% hObject    handle to Coco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
handles.proceso=2;
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
%Limón
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
handles.proceso=3;
guidata(hObject, handles);


% --- Executes on button press in Horchata.
function Horchata_Callback(hObject, eventdata, handles)
% hObject    handle to Horchata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=0;
disp(v)

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
%Piña
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
handles.proceso=0;
guidata(hObject, handles);

% --- Executes on button press in Jamaica.
function Jamaica_Callback(hObject, eventdata, handles)
% hObject    handle to Jamaica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

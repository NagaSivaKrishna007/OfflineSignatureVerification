function varargout = gui_target(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_target_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_target_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   [])
               
               ;
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function gui_target_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
disp(hObject);
a=ones(256,256);

axes(handles.axes1);
imshow(a);
  aA='0';
    set(handles.det,'String',aA);
      aA='0';
    set(handles.CR,'String',aA);
% Update handles structure
guidata(hObject, handles);



function varargout = gui_target_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
varargout{1} = handles.output;


function Browse_Callback(hObject, eventdata, handles)


[filename, pathname] = uigetfile('*.jpg', 'Select a signature');

    if isequal(filename,0) | isequal(pathname,0)
        
       warndlg('Signature is not selected');
       
    else
  c=strcat(pathname,filename);
       a=imread(c);
       axes(handles.axes1);
       imshow(a);
       handles.inputimage = c;
       
guidata(hObject, handles);

    end


% --- Executes on button press in TARGET_DETECTION.
function TARGET_DETECTION_Callback(hObject, eventdata, handles)

inputimage = handles.inputimage ;

mycell = {'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Basava\1.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Basava\2.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Basava\3.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Basava\4.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Vamsi\1.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Vamsi\2.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Vamsi\3.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Vamsi\4.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Nikhil\1.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Nikhil\2.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Nikhil\3.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Nikhil\4.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Siva\1.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Siva\2.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Siva\3.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Siva\4.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Prudhivi\1.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Prudhivi\2.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Prudhivi\3.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Prudhivi\4.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Karthik\1.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Karthik\2.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Karthik\3.jpg',
    'C:\Users\krish\Desktop\DSAA Group-22\matPro\photos\Karthik\4.jpg',
    };
namearray = {
    'Basava','Vamsi','Nikhil','Siva','Prudhvi','Karthik',
};
x =process(inputimage);
x= imresize(x,[80 200]);
sum=0;
j=0;
max=-200;
for i = 1:length(mycell)
    
    data = mycell{i};
    y = process(data);
    
    y= imresize(y,[80 200]);


    z = corr2(x,y);
    sum=sum+z;
    if(mod(i,4)==0)
        j=j+1;
        if(max< (sum/4) )
            max=sum/4;
            name = namearray{j}; 
        end
        sum=0;
    end
end
if (max<0.1)
    disp(max)
     aA='SIGNATURE NOT DETECTED';
    set(handles.det,'String',aA);
else
    disp(max);
    aA1=num2str(max);
    set(handles.CR,'String',aA1);

    aA=strcat(name,' Signature ');
    set(handles.det,'String',aA);
    
    disp(name);
end



guidata(hObject,handles)

function CR_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function CR_Callback(hObject, eventdata, handles)


function clear_Callback(hObject, eventdata, handles)

a=ones(256,256);

axes(handles.axes1);
imshow(a);
  aA='0';
    set(handles.det,'String',aA);
      aA='0';
    set(handles.CR,'String',aA);
% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)

close all;

function det_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function det_Callback(hObject, eventdata, handles)

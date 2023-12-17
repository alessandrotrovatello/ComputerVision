clc
clear
close all
% Specifica il percorso della cartella
directory = 'C:\Users\aless\Documents\MATLAB\Computer Vision\Assignment_4\optical_flow\optical_flow\Data\sphere';
% Ottieni la lista dei file nella cartella
files = dir(fullfile(directory, '*.ppm')); % Puoi cambiare l'estensione del file secondo le tue esigenze
% Inizializza una cella per memorizzare le immagini
images = cell(1, numel(files));
percorso=cell(1,numel(files));
% Loop attraverso i file e carica le immagini
for i = 1:numel(files)
% Costruisci il percorso completo del file
    percorso{i} = fullfile(directory, files(i).name);
% Carica l'immagine dal file corrente
    images{i} = imread(percorso{i});
    images{i}=rgb2gray(images{i});
end
dim=max(size(images));
u=zeros(dim,1);
v=zeros(dim,1);
for i=1:dim
    TwoFramesLK(percorso{i},percorso{i+1},3);
end
%map punto 1: magnitude of U (sqrt of uij e vij (squared))
% ROBOTICA
% Algoritmo Denavit-Hartenverg
% Funcion(theta,betha,long,alpha)

function DH=H_DH(theta,betha,long,alpha)
% dato= whos('theta','betha','long','alpha');
DH= HRz(theta)*HTz(betha)*HTx(long)*HRx(alpha);
end
colordef('black');
colormap jet;
numberofcells=144;% The number of your cells must be a sqaure number.(64,144,169,etc.)
Columnsofmatrix=12;% This number must be the square root of above number.(8,12,13,etc.)
Rowsofmatrix=12;% This number must be the square root of above number.(8,12,13,etc.)
ox=reshape(WD(1:numberofcells,1),Columnsofmatrix,Rowsofmatrix);
wldeltaG=reshape(WD(1:numberofcells,4),Columnsofmatrix,Rowsofmatrix);
% wldeltaH=reshape(WD(1:numberofcells,5),Columnsofmatrix,Rowsofmatrix);
qy=reshape(WD(1:numberofcells,6),Columnsofmatrix,Rowsofmatrix);
hold on;
grid on;
stem3(ox,wldeltaG,qy,'MarkerEdgeColor','k',...
                'MarkerFaceColor',[0 0 0],...
                'MarkerSize',0,'color','b');
% % stem3(ox,wldeltaH,qy,'MarkerEdgeColor','k',...
%                 'MarkerFaceColor',[0 0 0],...
%                 'MarkerSize',0,'color','b');
ox_complexes=reshape(WD(145:150,1),6,1);
wl_complexes=reshape(WD(145:150,4),6,1);
qy_complexes=reshape(WD(145:150,6),6,1);
% stem3(ox_complexes,wl_complexes,qy_complexes,'MarkerEdgeColor','r',...
%                 'MarkerFaceColor',[1 0 0],...
%                 'MarkerSize',8,'color','r','linewidth',1,'marker','d');
ylabel('Wavelength (nm)','fontsize',15);
xlabel('Ox.Potential vs. Fc (V)','fontsize',15);
zlabel('ECL Efficiency (%)','fontsize',20); 
text(ox_complexes(6,1),wl_complexes(6,1),qy_complexes(6,1)+8,'Ru(bpy)3','color','g');
text(ox_complexes(5,1),wl_complexes(5,1),qy_complexes(5,1)+8,'Fan','color','g');
text(ox_complexes(4,1),wl_complexes(4,1),qy_complexes(4,1)+8,'27-38','color','g');
text(ox_complexes(3,1),wl_complexes(3,1),qy_complexes(3,1)+8,'25-33','color','g');
text(ox_complexes(2,1),wl_complexes(2,1),qy_complexes(2,1)+8,'33-76','color','g');
text(ox_complexes(1,1),wl_complexes(1,1),qy_complexes(1,1)+8,'28-99','color','g');
scatter3(ox_complexes(6,1),wl_complexes(6,1),qy_complexes(6,1),300,'fill');
scatter3(ox_complexes(5,1),wl_complexes(5,1),qy_complexes(5,1),300,'fill');
scatter3(ox_complexes(4,1),wl_complexes(4,1),qy_complexes(4,1),300,'fill');
scatter3(ox_complexes(3,1),wl_complexes(3,1),qy_complexes(3,1),300,'fill');
scatter3(ox_complexes(2,1),wl_complexes(2,1),qy_complexes(2,1),300,'fill');
scatter3(ox_complexes(1,1),wl_complexes(1,1),qy_complexes(1,1),300,'fill');

view(-25,30);
for i=1:435
 view(-25+i,30);
 pause(0.06);
 end

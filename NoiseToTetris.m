function [tetrisrects] = NoiseToTetris(tetris,scale,sqsize,xc,yc)

if(mod(sqsize,2) == 0)
    startpoint = [xc - (sqsize*scale),yc - (sqsize*scale)];
else
    startpoint = [xc - (sqsize*scale/2)-((sqsize-1)*scale),yc - (sqsize*scale/2)-((sqsize-1)*scale)];
end


for xind = 1:sqsize
    for yind = 1:sqsize
        rectcenters(:,xind,yind) = [startpoint(1)+(scale*xind-1),startpoint(2)+(scale*yind-1)];
    end
end
for i = 1:size(tetris,1)
selectedcenters(i,:) = rectcenters(:,tetris(i,1),tetris(i,2));
end
 a = 1;
 halfsize = scale/2;
for i = 1:size(tetris,1)
    tetrisrects(:,i) = [selectedcenters(i,1)-halfsize,selectedcenters(i,2)-halfsize,selectedcenters(i,1)+halfsize,selectedcenters(i,2)+halfsize];
end
end
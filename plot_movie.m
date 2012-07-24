hFig = figure('Renderer','zbuffer');

writerObj = VideoWriter('peaks.avi');
open(writerObj);
for j = 1:length(ScopeData.signals.values(:,1))
    axis([-1 1 -1 1 -1 1]);
    set(hFig,'NextPlot','replaceChildren');
    set(hFig, 'Position', [0 0 1024 768]);
    plotDCM(q2rotMat(ScopeData.signals.values(j,:)'));
    F(j) = getframe(hFig, [0 0 1024 768]);
    writeVideo(writerObj,F(j));
    clf;
end
close(writerObj);
movie(F,1,60)




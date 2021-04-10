%
%  Code written by Rony Lanssiers in 2018-2021.
%  This work can be shared and adapted as long
%  as appropriate credit is given (CC BY 4.0).
%
%  PLF_DualPlotSingleAxis (plottitle, yaxislabel, r1, y1, r2, y2)
%
%  plottitle  - graph title (string)
%  yaxislabel - y axis label (string)
%  r1         - radius fraction (vector)
%  y1         - property value at r1 (vector)
%  r2         - radius fraction (vector)
%  y2         - property value at r2 (vector)
%

function PLF_DualPlotSingleAxis (plottitle, yaxislabel, r1, y1, r2, y2)
  plot (r1, y1, 'b');
  hold on;
  if exist ('r2', 'var') && exist ('y2', 'var')
    plot (r2, y2, 'm');
  end
  title (plottitle);
  grid on;
  xlabel ('r / R_s [-]');
  xlim ([0 1]);
  xticks ([0 0.2 0.4 0.6 0.8 1]);
  ylabel (yaxislabel);
end
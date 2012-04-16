function plotx2south
% set the default plot direction of the x-axis

plotOptions = get_mtex_option('default_Plot_Options');
plotOptions = set_option(plotOptions,'rotate',270*degree);
set_mtex_option('default_Plot_Options',plotOptions);

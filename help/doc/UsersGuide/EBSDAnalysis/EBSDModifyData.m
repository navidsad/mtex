%% Modify EBSD Data
% How to correct EBSD data for measurement errors.
%
%% Open in Editor
%
%% Contents
%
%%
% First, let us import some example <mtexdata.html EBSD data> and plot
% the raw data

mtexdata aachen;
plot(ebsd)

%%
% These data consist of two indexed phases, _Iron_ and _Magnesium_ : The not
% indexed data is called phase _not Indexed_. They can be visualized by a
% spatial phase plot (also called orientation map)

close, plot(ebsd,'property','phase')

%% Selecting certain phases
% In order to restrict the data to a certain phase, the data is indexed by
% its mineral name with the following syntax

ebsd_Fe = ebsd('Fe')

%%
% In order to extract a couple of phases, the mineral names have to be
% grouped in curled parethesis.

ebsd({'Fe','Mg'})

%%
% As an example, let us plot only all not indexed data

close, plot(ebsd('notIndexed'),'facecolor','r')

%% See also
% EBSD/subsref EBSD/subsasgn
%
%% Realign / Rotate the data
%
% Sometimes it is necessary to realing the EBSD data to the correct position in the external reference frame, or to 
% change the external reference frame from one to the other. Rotations in
% MTEX can be done by rotating, shifting or flipping. This is done by the 
% commands <EBSD.rotate.html rotate>, <EBSD.fliplr.html fliplr>, <EBSD.flipud.html flipud> and
% <EBSD.shift.html shift>.

% define a rotation
rot = rotation('axis',zvector,'angle',5*degree);

% rotate the EBSD data
ebsd_rot = rotate(ebsd,rot);

% plot the rotated EBSD data
close, plot(ebsd_rot)

%%
% It should be stressed that any sort of rotation on EBSD DATASETS does not only effect the spatial
% data, i.e. the x, y values, but also the crystal orientations are rotated
% accordingly. This is true as well for the flipping commands
% <EBSD.rotate.html rotate> and <EBSD.fliplr.html fliplr>. A good test is
% to rotate a given dataset in different ways and make plots for different
% rotations. You will see that not only the picture is flipped/shifted/rotated but also the
% color of the grain changes!

ebsd_flip = fliplr(ebsd_rot);
close, plot( ebsd_flip )

%% See also
% EBSD/rotate EBSD/fliplr EBSD/flipud EBSD/shift EBSD/affinetrans

%% Restricting to a region of interest
% If one is not interested in the whole data set but only in those
% measurements inside a certain polygon, the restriction can be constructed
% as follows:

%%
% First define a region

region = [120 100;
          200 100;
          200 130; 
          120 130;
          120 100];

%%
% plot the ebsd data together with the region of interest

close, plot(ebsd)
line(region(:,1),region(:,2),'color','r','linewidth',2)

%%
% In order to restrict the ebsd data to the polygon we may use the command
% <EBSD.inpolygon.html inpolygon> to locate all EBSD data inside the region

in_region = inpolygon(ebsd,region);

%%
% and use subindexing to restrict the data

ebsd = ebsd( in_region )

%%
% plot

close, plot(ebsd)

%% Remove Inaccurate Orientation Measurements
%
% *By MAD (mean angular deviation)* in the case of Oxford Channel programs, or *by
% CI (Confidence Index)* in the case of OIM-TSL programs
%
% Most EBSD measurements contain quantities indicating inaccurate
% measurements. 

close, plot(ebsd,'property','mad')

% or

close, plot(ebsd,'property','CI')

%%
% Here we will use the MAD or CI value to identify and eliminate
% inaccurate measurements.

% extract the quantity mad 
mad = get(ebsd,'mad');

%or
% % extract the quantity ci 
ci = get(ebsd,'ci');

% plot a histogram
close, hist(mad)

%or
% plot a histogram
close, hist(ci)


%%

% take only those measurements with MAD smaller then one
ebsd_corrected = ebsd(mad<1)

% take only those measurements with CI higher then 0.1 or 0.2
ebsd_corrected = ebsd(ci>0.1 )

%%
%

close, plot(ebsd_corrected)




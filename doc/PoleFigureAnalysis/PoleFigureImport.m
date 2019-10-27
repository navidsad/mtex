%% Import Pole Figure Data
%
%%
% Importing pole figure data in MTEX means to create a
% <PoleFigure.PoleFigure.html PoleFigure> object from data files containing
% diffraction data. Once such an object has been created the data can be
% <PoleFigureCorrection.html analyzed and processed> in many ways.
% Furthermore, such a PoleFigure object is the starting point for
% <PoleFigure2ODF.html PoleFigure to ODF estimation>.
%
%% Importing pole figure data using the import wizard
%
% The <import_wizard.html import wizard> can be started either by typing
% into the command line

import_wizard

%%
% or by using the start menu item *Start/Toolboxes/MTEX/Import Wizard*.
% Pole figure data can be also imported via the <matlab:filebrowser file
% browser> by choosing *Import Data* from the context menu of the selected
% file if its file extension was previously registered with the
% <matlab:opentoline(fullfile(mtex_path,'mtex_settings.m'),25,1)
% |mtex_settings.m|>
%
%%
% The import wizard guides through the correct setup of:
%
% * <CrystalSymmetries.html crystal symmetries> associated with phases 
% * specimen symmetry and plotting conventions
% * <Miller.Miller.html Miller indices> of pole figures.
% 
% In the end, the imported wizard creates a workspace variable or generates
% a m-file loading the data automatically. Furthermore appending a template
% script allows radip data processing.
%
%% Supported Data Formats
%
% The import wizard currently supports following pole figure formats:
%
% || <loadPoleFigure_ana.html **.ana*>            || EMSE ASCII pole figure format            || 
% || <loadPoleFigure_dubna.html **.cns*>          || Dubna ASCII pole figure format, regular grid ||
% || <loadPoleFigure_cnvindex.html **.cnv*>       || Dubna ASCII pole figure format, experimental grid ||
% || <loadPoleFigure_geesthacht.html **.dat*>     || Geesthacht ASCII pole figure format.     ||
% || <loadPoleFigure_popla.html **.epf*, **.gpf*> || Popla ASCII pole figure format.          ||
% || <loadPoleFigure_labotex.html **.epf*, **.ppf*, **.pow **> || LaboTEX ASCII pole figure format ||
% || <loadPoleFigure_aachen_exp.html **.exp*>     || Aachen ASCII pole figure format.         ||
% || <loadPoleFigure_ibm.html **.ibm*>            || IBM ASCII pole figure format.            ||
% || <loadPoleFigure_juelich.html **.jul*>        || Juelich ASCII pole figure format.        ||
% || <loadPoleFigure_nja.html **.nja*>            || Seifert ASCII pole figure format.        ||
% || <loadPoleFigure_out1.html **.out*>           || Graz ASCII pole figure format.           ||
% || <loadPoleFigure_plf.html **.plf*>            || Queens Univ. ASCII pole figure format.   ||
% || <loadPoleFigure_ptx.html **.ptx, *.rpf*>     || Heilbronner ASCII pole figure format.    ||
% || <loadPoleFigure_philips.html **.txt*>        || Philips ASCII pole figure format.        ||
% || <loadPoleFigure_beartex.html **.xpe, *.xpf*> || BearTex ASCII pole figure format.        ||
% || <loadPoleFigure_slc.html **.slc*>            || SLC ASCII pole figure format.            ||
% || <loadPoleFigure_uxd.html **.uxd*>            || Bruker UXD ASCII pole figure format.     ||
% || <loadPoleFigure_xrd.html **.xrd, *.ras*>     || Bruker XRD ASCII pole figure format.     ||
% || <loadPoleFigure_xrdml.html **.xrdml*>        || PANalytical XML data format.             ||
% || <loadPoleFigure_aachen.html **.**>           || Aachen ASCII pole figure format.         ||
%
% See <PoleFigure.load.html PoleFigure.load> for further information or follow
% the hyperlinks of the table above for an example.
%
% If the interface is not automatically recognized, but the data has the
% form of an ASCII list:
%  
%  polar_1 azimuthal_1 intensity_1
%  polar_2 azimuthal_2 intensity_2
%  polar_3 azimuthal_3 intensity_3
%  .       .           .
%  .       .           .
%  .       .           .
%  polar_n azimuthal_n intensity_n
%
% an additional tool asks you to associate the columns with the
% corresponding property. See also <loadPoleFigure_generic.html
% loadPoleFigure_generic>, which provides an easy way to import diffraction
% data from such an ASCII list. The list may contain an arbitrary number of
% header lines, columns or comments and the actual order of the columns may
% be specified by options.
%
% If you have any comments, remarks or request on interfaces please contact
% us.
%
%% The Import Script
%
% Diffraction data stored in one of the formats above can also be imported
% using the command <PoleFigure.load.html PoleFigure.load>. It automatically
% detects the data format and imports the data. In dependency of the data
% format, it might be necessary to specify the Miller indices and the
% structure coefficients. The general syntax is
%
%%
% An import script generated by the |import wizard| has the following form:

cs = crystalSymmetry('32',[1.4,1.4,1.5]); % crystal symmetry

% location of the data files
fnames = {...
  fullfile(mtexDataPath,'PoleFigure','dubna','Q(10-10)_amp.cnv'),...
  fullfile(mtexDataPath,'PoleFigure','dubna','Q(10-11)(01-11)_amp.cnv')};

% crystal directions
h = {Miller(1,0,-1,0,cs),[Miller(0,1,-1,1,cs),Miller(1,0,-1,1,cs)]};

% structure coefficients
c = {1,[0.52 ,1.23]};

% load data
pf = PoleFigure.load(fnames,h,cs,'superposition',c)

%%
% Once such a import script for pole figure data has been created, it can
% be easily modified and extend, e.g.:

% plot the data
plot(pf)

%% Writing your own interface
%
% MTEX also provides a way to import data from formats currently not
% supported directly. Therefore you can to use all standard MATLAB input
% and output commands to read the pole figure information, e.g. intensities,
% specimen directions, crystal directions directly from the data files.
% Then you have to call the constructor
% <PoleFigure.PoleFigure.html PoleFigure> with these data to generate
% a PoleFigure object.
%
% Once you have written an interface that reads data from certain data
% files and generates a PoleFigure object you can integrate this method
% into MTEX by copying it into the folder |MTEX/qta/interfaces|. Then it
% will be automatically called by the methods <PoleFigure.load.html
% PoleFigure.load> and import_wizard. Examples how to write such an
% interface can be found in the directory |MTEX/qta/interfaces|.
%


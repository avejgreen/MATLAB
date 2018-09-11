function null = main()

close all;
clear all;
clc;

%Input n, thickness values, and wavelengths
NVals = struct('Air',[],'Bi2Se3Oxide',[],'Bi2Se3Bulk',[],'SiO2',[],'Si',[]);
NVals.Air = 1.0003*ones(1,36);
NVals.Mica = 1.6*ones(1,36);
NVals.Bi2Se3Oxide = [2.24555000000000 - 0.404228000000000i,2.24888200000000 - 0.366049000000000i,2.24400100000000 - 0.329055000000000i,2.23178500000000 - 0.296137000000000i,2.21406900000000 - 0.269552000000000i,2.19329300000000 - 0.250683000000000i,2.17213400000000 - 0.239999000000000i,2.15329000000000 - 0.237158000000000i,2.13967800000000 - 0.241157000000000i,2.13452200000000 - 0.247509000000000i,2.13453000000000 - 0.252369000000000i,2.13803600000000 - 0.255700000000000i,2.14426000000000 - 0.257371000000000i,2.15267300000000 - 0.257208000000000i,2.16284100000000 - 0.255009000000000i,2.17435900000000 - 0.250560000000000i,2.18680800000000 - 0.243637000000000i,2.19972600000000 - 0.234025000000000i,2.21258000000000 - 0.221539000000000i,2.22475100000000 - 0.206055000000000i,2.23552300000000 - 0.187549000000000i,2.24408700000000 - 0.166154000000000i,2.24956600000000 - 0.142226000000000i,2.25108000000000 - 0.116412000000000i,2.24784700000000 - 0.0897100000000000i,2.23934000000000 - 0.0634970000000000i,2.22547500000000 - 0.0394940000000000i,2.20684600000000 - 0.0196530000000000i,2.18498300000000 - 0.00595100000000000i,2.16288400000000 - 0.000115000000000000i,2.14644300000000 + -0.00000000000000i,2.13397400000000 + -0.00000000000000i,2.12357900000000 + -0.00000000000000i,2.11460500000000 + -0.00000000000000i,2.10669600000000 + -0.00000000000000i,2.09962500000000 + -0.00000000000000i;];
NVals.Bi2Se3Bulk = [2.34721500000000 - 3.50112200000000i,2.44874500000000 - 3.57803500000000i,2.56326200000000 - 3.64253400000000i,2.67960000000000 - 3.69103200000000i,2.78883900000000 - 3.72998200000000i,2.89125800000000 - 3.76870900000000i,2.99283500000000 - 3.81125500000000i,3.09865000000000 - 3.85622600000000i,3.21067300000000 - 3.90044700000000i,3.32870000000000 - 3.94132200000000i,3.45172300000000 - 3.97742000000000i,3.57880800000000 - 4.00822800000000i,3.70948100000000 - 4.03367500000000i,3.84376600000000 - 4.05367300000000i,3.98201400000000 - 4.06779300000000i,4.12461000000000 - 4.07509400000000i,4.27165500000000 - 4.07412400000000i,4.42268500000000 - 4.06308200000000i,4.57650500000000 - 4.04009100000000i,4.73115600000000 - 4.00352900000000i,4.88403000000000 - 3.95234100000000i,5.03212200000000 - 3.88628600000000i,5.17235200000000 - 3.80604800000000i,5.30191200000000 - 3.71320600000000i,5.41855300000000 - 3.61006900000000i,5.52077800000000 - 3.49942400000000i,5.60790700000000 - 3.38424300000000i,5.68004100000000 - 3.26742300000000i,5.73793600000000 - 3.15157300000000i,5.78284100000000 - 3.03888800000000i,5.81632400000000 - 2.93108200000000i,5.84012600000000 - 2.82938900000000i,5.85603100000000 - 2.73459300000000i,5.86577900000000 - 2.64708400000000i,5.87099900000000 - 2.56691300000000i,5.87316900000000 - 2.49385400000000i;];
NVals.SiO2 = [1.47569400000000,1.47462800000000,1.47363900000000,1.47272100000000,1.47186700000000,1.47106900000000,1.47032400000000,1.46962500000000,1.46896900000000,1.46835200000000,1.46777100000000,1.46722200000000,1.46670400000000,1.46621200000000,1.46574600000000,1.46530400000000,1.46488300000000,1.46448200000000,1.46409900000000,1.46373300000000,1.46338300000000,1.46304800000000,1.46272700000000,1.46241800000000,1.46212100000000,1.46183500000000,1.46156000000000,1.46129400000000,1.46103700000000,1.46078900000000,1.46054700000000,1.46031400000000,1.46008900000000,1.45986800000000,1.45965500000000,1.45944700000000];
NVals.Si = [5.63171600000000 - 0.285821300000000i,5.34655700000000 - 0.212582900000000i,5.13419000000000 - 0.160634600000000i,4.96260500000000 - 0.122018700000000i,4.81913900000000 - 0.0939212600000000i,4.69728900000000 - 0.0739159300000000i,4.59272700000000 - 0.0598907000000000i,4.50238500000000 - 0.0501741100000000i,4.42391700000000 - 0.0434724500000000i,4.35528000000000 - 0.0387762600000000i,4.29492700000000 - 0.0353747500000000i,4.24152700000000 - 0.0327590300000000i,4.19392100000000 - 0.0305925000000000i,4.15113400000000 - 0.0286754500000000i,4.11249400000000 - 0.0269094600000000i,4.07732400000000 - 0.0252482700000000i,4.04518300000000 - 0.0236772700000000i,4.01567700000000 - 0.0221908900000000i,3.98847100000000 - 0.0207852600000000i,3.96331000000000 - 0.0194575300000000i,3.93996900000000 - 0.0182043800000000i,3.91824200000000 - 0.0170216300000000i,3.89796000000000 - 0.0159055000000000i,3.87901700000000 - 0.0148545100000000i,3.86126100000000 - 0.0138637700000000i,3.84458500000000 - 0.0129302700000000i,3.82889500000000 - 0.0120509300000000i,3.81411400000000 - 0.0112231900000000i,3.80017700000000 - 0.0104448400000000i,3.78699700000000 - 0.00971188900000000i,3.77452000000000 - 0.00902226300000000i,3.76270800000000 - 0.00837446500000000i,3.75149300000000 - 0.00776502500000000i,3.74084000000000 - 0.00719237600000000i,3.73072000000000 - 0.00665514400000000i,3.72107900000000 - 0.00615027000000000i];


%Turn n values into polynomials
global wavelengths;
wavelengths = linspace(400e-9,750e-9,36);
NPolys = struct('AirReal',[],'AirImag',[],'Bi2Se3OxideReal',[],'Bi2Se3OxideImag',[],'Bi2Se3BulkReal',[],'Bi2Se3BulkImag',[],'SiO2Real',[],'SiO2Imag',[],'SiReal',[],'SiImag',[]);
NPolys.AirReal = getpolys(real(NVals.Air));
NPolys.AirImag = getpolys(imag(NVals.Air));
NVals.MicaReal = getpolys(real(NVals.Mica));
NVals.MicaImag = getpolys(real(NVals.Mica));
NPolys.Bi2Se3OxideReal = getpolys(real(NVals.Bi2Se3Oxide));
NPolys.Bi2Se3OxideImag = getpolys(imag(NVals.Bi2Se3Oxide));
NPolys.Bi2Se3BulkReal = getpolys(real(NVals.Bi2Se3Bulk));
NPolys.Bi2Se3BulkImag = getpolys(imag(NVals.Bi2Se3Bulk));
NPolys.SiO2Real = getpolys(real(NVals.SiO2));
NPolys.SiO2Imag = getpolys(imag(NVals.SiO2));
NPolys.SiReal = getpolys(real(NVals.Si));
NPolys.SiImag = getpolys(imag(NVals.Si));

% %Plot Polys and Points
% plotindices(NVals.Air, NPolys.AirReal, NPolys.AirImag);
% plotindices(NVals.Bi2Se3Oxide, NPolys.Bi2Se3OxideReal, NPolys.Bi2Se3OxideImag);
% plotindices(NVals.Bi2Se3Bulk, NPolys.Bi2Se3BulkReal, NPolys.Bi2Se3BulkImag);
% plotindices(NVals.SiO2, NPolys.SiO2Real, NPolys.SiO2Imag);
% plotindices(NVals.Si, NPolys.SiReal, NPolys.SiImag);

%Use n polynomials to increase refractive index resolution
wavelengths = linspace(400e-9,750e-9,176);
NVals.Air = complex(getpts(NPolys.AirReal),getpts(NPolys.AirImag));
NVals.Air = complex(getpts(NPolys.MicaReal),getpts(NPolys.MicaImag));
NVals.Bi2Se3Oxide = complex(getpts(NPolys.Bi2Se3OxideReal),getpts(NPolys.Bi2Se3OxideImag));
NVals.Bi2Se3Bulk = complex(getpts(NPolys.Bi2Se3BulkReal),getpts(NPolys.Bi2Se3BulkImag));
NVals.SiO2 = complex(getpts(NPolys.SiO2Real),getpts(NPolys.SiO2Imag));
NVals.Si = complex(getpts(NPolys.SiReal),getpts(NPolys.SiImag));

%Compute 2 layer r values (p polarized in Fujiwara, normal incidence)
rAir_Bi2Se3Bulk = gettwolayer(NVals.Air, NVals.Bi2Se3Bulk);
rAir_Bi2Se3Oxide = gettwolayer(NVals.Air, NVals.Bi2Se3Oxide);
rAir_SiO2 = gettwolayer(NVals.Air, NVals.SiO2);
rBi2Se3Oxide_Bi2Se3Bulk = gettwolayer(NVals.Bi2Se3Oxide, NVals.Bi2Se3Bulk);
rBi2Se3Bulk_SiO2 = gettwolayer(NVals.Bi2Se3Bulk, NVals.SiO2);
rSiO2_Si = gettwolayer(NVals.SiO2, NVals.Si);

%Input Thicknesses AND LOOP
global Bi2Se3BulkThick
Bi2Se3BulkThick = linspace(0,30e-9,176);
Bi2Se3OxideThick = 1.9*10^-9;

global runnumber
global plotnumber
plotnumber = 0;

for runnumber = 1:2

    
    if runnumber == 1
        SiO2Thick = 1e-9;
        
    elseif runnumber == 2
        SiO2Thick = 300e-9;
        
    end
    
    %Compute beta values
    bSiO2 = getbetasthin(NVals.SiO2,SiO2Thick);
    bBi2Se3Bulk = getbetasthick(NVals.Bi2Se3Bulk,Bi2Se3BulkThick);
    bBi2Se3Oxide = getbetasthin(NVals.Bi2Se3Oxide,Bi2Se3OxideThick);
    

    %_________________________BACKGROUND SUBSTRATE_____________________________
    
    %Compute r values
    rAir_SiO2_Si = getnextlayer(rAir_SiO2, rSiO2_Si, bSiO2);
    
    %Compute R values
    RBackground = getRvals(rAir_SiO2_Si);
    
    
    %_________________________SAMPLES WITHOUT OXIDE____________________________
    
    %Compute r values
    rAir_Bi2Se3Bulk_SiO2 = getnextlayer(rAir_Bi2Se3Bulk, rBi2Se3Bulk_SiO2, bBi2Se3Bulk);
    rAir_Bi2Se3Bulk_SiO2_Si = getnextlayer(rAir_Bi2Se3Bulk_SiO2, rSiO2_Si, bSiO2);
    
    %Compute R values
    RWithoutOxide = getRvals(rAir_Bi2Se3Bulk_SiO2_Si);
    
    %Compute contrast R values
    ContrastWithoutOxide = getcontrast(RWithoutOxide, RBackground);
    
    %Limit contrast to 10
    LimitedContrastWithoutOxide = limitcontrast(ContrastWithoutOxide, 10);
    
    %Make a plot of contrast values
    plotcontrast(LimitedContrastWithoutOxide);
    
    
    %_________________________SAMPLES WITH OXIDE_______________________________
    
    %Compute r values
    rAir_Bi2Se3Oxide_Bi2Se3Bulk = getnextlayer(rAir_Bi2Se3Oxide, rBi2Se3Oxide_Bi2Se3Bulk, bBi2Se3Oxide);
    rAir_Bi2Se3Oxide_Bi2Se3Bulk_SiO2 = getnextlayer(rAir_Bi2Se3Oxide_Bi2Se3Bulk, rBi2Se3Bulk_SiO2, bBi2Se3Bulk);
    rAir_Bi2Se3Oxide_Bi2Se3Bulk_SiO2_Si = getnextlayer(rAir_Bi2Se3Oxide_Bi2Se3Bulk_SiO2, rSiO2_Si, bSiO2);
    
    %Compute R values
    RWithOxide = getRvals(rAir_Bi2Se3Oxide_Bi2Se3Bulk_SiO2_Si);
    
    %Compute contrast R values
    ContrastWithOxide = getcontrast(RWithOxide, RBackground);
    
    %Limit contrast to 10
    LimitedContrastWithOxide = limitcontrast(ContrastWithOxide, 10);
    
    %Make a plot of contrast values
    plotcontrast(LimitedContrastWithOxide);
    
    %__________________________________________________________________________
    
    
    a = 1;
    
end
end

function poly = getpolys(nvals)
global wavelengths
poly = polyfit(wavelengths,nvals,10);
end

function pts = getpts(polys)
global wavelengths
pts = polyval(polys, wavelengths);
end

function plotindices(nvals, npolysreal, npolysimag)
global wavelengths;
figure;
hold on
[AX, H1, H2] = plotyy(wavelengths*1e9, polyval(npolysreal, wavelengths), wavelengths*1e9, -1*polyval(npolysimag, wavelengths));
set(H1,'LineStyle','--');
set(H2,'LineStyle','--');
[AX, H1, H2] = plotyy(wavelengths*1e9, real(nvals), wavelengths*1e9, -1*imag(nvals));
set(H1,'LineStyle','o');
set(H2,'LineStyle','o');
hold off
set(get(AX(1),'Ylabel'),'String','N real');
set(get(AX(2),'Ylabel'),'String','N imag');
xlabel('Wavelength (nm)');
end

function thinbetas = getbetasthin(nvals, thick)
global wavelengths
thinbetas = (2*pi*thick*nvals)./wavelengths;
end

function thickbetas = getbetasthick(nvals, thick)
global wavelengths
thickbetas = zeros(length(wavelengths),length(thick));
for a = 1:176   
    for b = 1:176
        thickbetas(a,b) = (2*pi*thick(b)*nvals(a))/wavelengths(a);       
    end   
end
end

function rvals = gettwolayer(n1, n2)
rvals = (n2-n1)./(n2+n1);
end

function rvals = getnextlayer(rlast,rnext,beta)
if size(rlast,1) == 1 && size(beta,1) == 1
    rvals = (rlast+rnext.*exp(2i.*beta))./(1+rlast.*rnext.*exp(2i.*beta));
elseif size(rlast,1) == 1
    rvals = zeros(176);
    for b = 1:176
        rvals(b,:) = (rlast+rnext.*exp(2i.*beta(b,:)))./(1+rlast.*rnext.*exp(2i.*beta(b,:)));
    end
elseif size(beta,1) == 1
    rvals = zeros(176);
    for b = 1:176
        rvals(b,:) = (rlast(b,:)+rnext.*exp(2i.*beta))./(1+rlast(b,:).*rnext.*exp(2i.*beta));
    end
else
    rvals = zeros(176);
    for b = 1:176
        rvals(b,:) = (rlast(b,:)+rnext.*exp(2i.*beta(b,:)))./(1+rlast(b,:).*rnext.*exp(2i.*beta(b,:)));
    end
end
end

function Rvals = getRvals(rvals)
Rvals = rvals.*conj(rvals);
end

%TEMPORARILY USING LOG INTENSITIES
function contrast = getcontrast(sample, background)
contrast = zeros(176);
for b = 1:176
    contrast(b,:) = (log10(sample(b,:))-log10(background))./log10(background);
end
end

%TEMPORARILY USING LOG INTENSITIES
function limitedcontrast = limitcontrast(contrast, maxcontrast)

maxcontrast = 5;
mincontrast = maxcontrast*-1;

limitedcontrast = contrast;
[r,c] = find(contrast>maxcontrast);
for i = 1:length(r)
    limitedcontrast(r(i),c(i)) = maxcontrast;
end

[r,c] = find(contrast<mincontrast);
for i = 1:length(r)
    limitedcontrast(r(i),c(i)) = mincontrast;
end

% [r,c] = find(contrast<.5);
% for i = 1:length(r)
%     limitedcontrast(r(i),c(i)) = .5;
% end
end

function plotcontrast(ContrastVals)
%Create a mesh plot
global wavelengths
global Bi2Se3BulkThick;
global plotnumber
plotnumber = plotnumber+1;
subplot(2,2,plotnumber);
mesh(Bi2Se3BulkThick*10^9,wavelengths*10^9,ContrastVals)
xlabel('Bulk Bi2Se3 Thickness (nm)');
ylabel('Wavelength (nm)');
zlabel('Relative Reflected Intensity Difference');
view(2);
colorbar;
end


function null = main()

close all;
clear all;
clc;

%Input n, thickness values, and wavelengths
global Mats;
Mats = struct;
Mats.name = 'Air';
Mats.vals = 1.0003*(zeros(1,36)+1);
Mats(2).name = 'Bi2Se3Oxide';
Mats(2).vals = [2.24555000000000 - 0.404228000000000i,2.24888200000000 - 0.366049000000000i,2.24400100000000 - 0.329055000000000i,2.23178500000000 - 0.296137000000000i,2.21406900000000 - 0.269552000000000i,2.19329300000000 - 0.250683000000000i,2.17213400000000 - 0.239999000000000i,2.15329000000000 - 0.237158000000000i,2.13967800000000 - 0.241157000000000i,2.13452200000000 - 0.247509000000000i,2.13453000000000 - 0.252369000000000i,2.13803600000000 - 0.255700000000000i,2.14426000000000 - 0.257371000000000i,2.15267300000000 - 0.257208000000000i,2.16284100000000 - 0.255009000000000i,2.17435900000000 - 0.250560000000000i,2.18680800000000 - 0.243637000000000i,2.19972600000000 - 0.234025000000000i,2.21258000000000 - 0.221539000000000i,2.22475100000000 - 0.206055000000000i,2.23552300000000 - 0.187549000000000i,2.24408700000000 - 0.166154000000000i,2.24956600000000 - 0.142226000000000i,2.25108000000000 - 0.116412000000000i,2.24784700000000 - 0.0897100000000000i,2.23934000000000 - 0.0634970000000000i,2.22547500000000 - 0.0394940000000000i,2.20684600000000 - 0.0196530000000000i,2.18498300000000 - 0.00595100000000000i,2.16288400000000 - 0.000115000000000000i,2.14644300000000 + -0.00000000000000i,2.13397400000000 + -0.00000000000000i,2.12357900000000 + -0.00000000000000i,2.11460500000000 + -0.00000000000000i,2.10669600000000 + -0.00000000000000i,2.09962500000000 + -0.00000000000000i;];
Mats(3).name = 'Bi2Se3Bulk';
Mats(3).vals = [2.34745200000000 - 3.50544200000000i,2.44969700000000 - 3.58134500000000i,2.56263200000000 - 3.64492300000000i,2.67706500000000 - 3.69474700000000i,2.78650700000000 - 3.73576000000000i,2.89032800000000 - 3.77483700000000i,2.99230000000000 - 3.81621100000000i,3.09699000000000 - 3.86019200000000i,3.20733900000000 - 3.90459400000000i,3.32421900000000 - 3.94665100000000i,3.44708300000000 - 3.98418200000000i,3.57482100000000 - 4.01596500000000i,3.70643400000000 - 4.04157300000000i,3.84138900000000 - 4.06097900000000i,3.97966600000000 - 4.07411100000000i,4.12157700000000 - 4.08049800000000i,4.26742600000000 - 4.07908900000000i,4.41712900000000 - 4.06828100000000i,4.56989500000000 - 4.04614800000000i,4.72406400000000 - 4.01080900000000i,4.87712900000000 - 3.96084500000000i,5.02597300000000 - 3.89566500000000i,5.16725300000000 - 3.81572900000000i,5.29782900000000 - 3.72256400000000i,5.41516300000000 - 3.61860100000000i,5.51757400000000 - 3.50685600000000i,5.60434300000000 - 3.39057400000000i,5.67565000000000 - 3.27289100000000i,5.73241800000000 - 3.15658200000000i,5.77610000000000 - 3.04391300000000i,5.80846600000000 - 2.93658000000000i,5.83141900000000 - 2.83572900000000i,5.84685700000000 - 2.74201200000000i,5.85657200000000 - 2.65565900000000i,5.86219000000000 - 2.57656500000000i,5.86513700000000 - 2.50435900000000i;];
Mats(4).name = 'SiO2';
Mats(4).vals = [1.47569400000000,1.47462800000000,1.47363900000000,1.47272100000000,1.47186700000000,1.47106900000000,1.47032400000000,1.46962500000000,1.46896900000000,1.46835200000000,1.46777100000000,1.46722200000000,1.46670400000000,1.46621200000000,1.46574600000000,1.46530400000000,1.46488300000000,1.46448200000000,1.46409900000000,1.46373300000000,1.46338300000000,1.46304800000000,1.46272700000000,1.46241800000000,1.46212100000000,1.46183500000000,1.46156000000000,1.46129400000000,1.46103700000000,1.46078900000000,1.46054700000000,1.46031400000000,1.46008900000000,1.45986800000000,1.45965500000000,1.45944700000000];
Mats(5).name = 'Si';
Mats(5).vals = [5.63171600000000 - 0.285821300000000i,5.34655700000000 - 0.212582900000000i,5.13419000000000 - 0.160634600000000i,4.96260500000000 - 0.122018700000000i,4.81913900000000 - 0.0939212600000000i,4.69728900000000 - 0.0739159300000000i,4.59272700000000 - 0.0598907000000000i,4.50238500000000 - 0.0501741100000000i,4.42391700000000 - 0.0434724500000000i,4.35528000000000 - 0.0387762600000000i,4.29492700000000 - 0.0353747500000000i,4.24152700000000 - 0.0327590300000000i,4.19392100000000 - 0.0305925000000000i,4.15113400000000 - 0.0286754500000000i,4.11249400000000 - 0.0269094600000000i,4.07732400000000 - 0.0252482700000000i,4.04518300000000 - 0.0236772700000000i,4.01567700000000 - 0.0221908900000000i,3.98847100000000 - 0.0207852600000000i,3.96331000000000 - 0.0194575300000000i,3.93996900000000 - 0.0182043800000000i,3.91824200000000 - 0.0170216300000000i,3.89796000000000 - 0.0159055000000000i,3.87901700000000 - 0.0148545100000000i,3.86126100000000 - 0.0138637700000000i,3.84458500000000 - 0.0129302700000000i,3.82889500000000 - 0.0120509300000000i,3.81411400000000 - 0.0112231900000000i,3.80017700000000 - 0.0104448400000000i,3.78699700000000 - 0.00971188900000000i,3.77452000000000 - 0.00902226300000000i,3.76270800000000 - 0.00837446500000000i,3.75149300000000 - 0.00776502500000000i,3.74084000000000 - 0.00719237600000000i,3.73072000000000 - 0.00665514400000000i,3.72107900000000 - 0.00615027000000000i];

%Turn n values into polynomials
%resolution
global wavelengths;
wavelengths = linspace(400e-9,750e-9,36);
Polys = struct;
for i = 1:length(Mats)
    Polys(i).name = Mats(i).name;
    Polys(i).real = polyfit(wavelengths,real(Mats(i).vals),10);
    Polys(i).imag = polyfit(wavelengths,imag(Mats(i).vals),10);
    
%     %Plot the polynomials and individual points
%     plotindices(Mats(i), Polys(i));
end

%Turn n polys back into points at higher resolution
wavelengths = linspace(400e-9,750e-9,176);
for i = 1:length(Mats)
    Mats(i).vals = complex(polyval(Polys(i).real, wavelengths),polyval(Polys(i).imag, wavelengths));
end


%Define stack from top layer (not including air) to substrate

%Stack1 has no bi2se3 oxide, has native sio2 oxide
Stack1 = createstack(1,0,3,linspace(0,30e-9,176),4,1e-9,5,0);
%Stack2 has 1 nm bi2se3 oxide, has native sio2 oxide
Stack2 = createstack(1,0,2,1.9e-9,3,linspace(0,30e-9,176),4,1e-9,5,0);
%Stack3 has no bi2se3 oxide, has 300 mn thermal sio2 oxide
Stack3 = createstack(1,0,3,linspace(0,30e-9,176),4,300e-9,5,0);
%Stack4 has 1 nm bi2se3 oxide, has 300 nm thermal sio2 oxide
Stack4 = createstack(1,0,2,1.9e-9,3,linspace(0,30e-9,176),4,300e-9,5,0);

%Compute 2 layer r vales and betas
Stack1 = getr2beta(Stack1);
Stack2 = getr2beta(Stack2);
Stack3 = getr2beta(Stack3);
Stack4 = getr2beta(Stack4);

%Use 2 layer r vales and betas to come up with a full stack r value.
Stack1 = getwholer(Stack1);


% %Compute 2 layer r values (p polarized in Fujiwara, normal incidence)
% rAir_Bi2Se3Bulk = gettwolayer(NVals.Air, NVals.Bi2Se3Bulk);
% rAir_Bi2Se3Oxide = gettwolayer(NVals.Air, NVals.Bi2Se3Oxide);
% rAir_SiO2 = gettwolayer(NVals.Air, NVals.SiO2);
% rBi2Se3Oxide_Bi2Se3Bulk = gettwolayer(NVals.Bi2Se3Oxide, NVals.Bi2Se3Bulk);
% rBi2Se3Bulk_SiO2 = gettwolayer(NVals.Bi2Se3Bulk, NVals.SiO2);
% rSiO2_Si = gettwolayer(NVals.SiO2, NVals.Si);

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

function plotindices(nvals, npolys)
global wavelengths;
figure;
hold on
[AX, H1, H2] = plotyy(wavelengths*1e9, polyval(npolys.real, wavelengths), wavelengths*1e9, -1*polyval(npolys.imag, wavelengths));
set(H1,'LineStyle','--');
set(H2,'LineStyle','--');
[AX, H1, H2] = plotyy(wavelengths*1e9, real(nvals.vals), wavelengths*1e9, -1*imag(nvals.vals));
set(H1,'LineStyle','o');
set(H2,'LineStyle','o');
hold off
set(get(AX(1),'Ylabel'),'String','N real');
set(get(AX(2),'Ylabel'),'String','N imag');
xlabel('Wavelength (nm)');
title(['Refractive index points and polynomial fits to ', nvals.name],'FontSize',12)
end

function stack = createstack(varargin)
global Mats;
stack = struct;
for i = 1:length(varargin)/2
    stack(i).name = Mats(varargin{i*2-1}).name;
    stack(i).vals = Mats(varargin{i*2-1}).vals;
    stack(i).thick = varargin{i*2};
end
end

function stack = getr2beta(stack)
global wavelengths
for i = 2:length(stack)
    
    stack(1).r2 = 0;
    stack(i).r2 = (stack(i-1).vals-stack(i).vals)./(stack(i-1).vals+stack(i).vals);
    
    %Compute betas above substrate
    stack(1).beta = 0;
    stack(length(stack)).beta = 0;
    stack(i).thick = stack(i).thick';
    if i == length(stack)
    else
        stack(i).beta = 2*pi*stack(i).thick*(stack(i).vals./wavelengths);
    end
    
end
end

function stack = getwholer(stack)
stack(length(stack)+1).name = 'Whole Stack';
    for i = 3:length(stack)-1
        stack(length(stack)+1).vals = getnextlayer(stack(i-1).r2,stack(i).r2,stack(i-1).beta);
    end
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

function contrast = getcontrast(sample, background)
contrast = zeros(176);
for b = 1:176
    contrast(b,:) = (sample(b,:)-background)./background;
end
end

function limitedcontrast = limitcontrast(contrast, maxcontrast)
limitedcontrast = contrast;
[r,c] = find(contrast>maxcontrast);
for i = 1:length(r)
    limitedcontrast(r(i),c(i)) = maxcontrast;
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


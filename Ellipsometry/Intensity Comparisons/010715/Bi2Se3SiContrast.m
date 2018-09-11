function null = main()

close all;
clear all;
clc;

%Input n, thickness values, and wavelengths
AirReal = 1.0003*ones(1,401);
AirImag = zeros(1,401);
AirC = complex(AirReal,AirImag);
Bi2Se3BulkReal = [1.99411000000000,2.00376200000000,2.01329600000000,2.02270100000000,2.03197000000000,2.04109300000000,2.05006500000000,2.05887900000000,2.06753100000000,2.07601800000000,2.08433900000000,2.09249300000000,2.10048100000000,2.10830600000000,2.11597300000000,2.12348700000000,2.13085400000000,2.13808300000000,2.14518300000000,2.15216400000000,2.15903800000000,2.16581600000000,2.17251200000000,2.17913800000000,2.18570900000000,2.19224000000000,2.19874400000000,2.20523600000000,2.21173000000000,2.21824300000000,2.22478700000000,2.23137800000000,2.23802900000000,2.24475300000000,2.25156400000000,2.25847400000000,2.26549500000000,2.27263800000000,2.27991300000000,2.28733200000000,2.29490300000000,2.30263300000000,2.31053100000000,2.31860300000000,2.32685400000000,2.33529100000000,2.34391500000000,2.35273100000000,2.36174100000000,2.37094400000000,2.38034200000000,2.38993300000000,2.39971500000000,2.40968400000000,2.41983800000000,2.43017000000000,2.44067500000000,2.45134600000000,2.46217500000000,2.47315200000000,2.48426900000000,2.49551500000000,2.50688000000000,2.51835000000000,2.52991500000000,2.54156200000000,2.55327800000000,2.56505000000000,2.57686500000000,2.58871100000000,2.60057400000000,2.61244200000000,2.62430200000000,2.63614500000000,2.64795800000000,2.65973300000000,2.67145800000000,2.68312800000000,2.69473400000000,2.70626900000000,2.71773000000000,2.72911100000000,2.74041000000000,2.75162600000000,2.76275600000000,2.77380100000000,2.78476300000000,2.79564200000000,2.80644300000000,2.81716800000000,2.82782100000000,2.83840700000000,2.84893200000000,2.85940000000000,2.86981800000000,2.88019200000000,2.89052800000000,2.90083200000000,2.91111100000000,2.92137100000000,2.93161800000000,2.94185800000000,2.95209800000000,2.96234300000000,2.97259800000000,2.98286900000000,2.99316100000000,3.00347800000000,3.01382400000000,3.02420400000000,3.03462100000000,3.04507800000000,3.05557900000000,3.06612700000000,3.07672400000000,3.08737200000000,3.09807200000000,3.10882800000000,3.11963900000000,3.13050800000000,3.14143600000000,3.15242200000000,3.16346800000000,3.17457400000000,3.18574100000000,3.19696700000000,3.20825500000000,3.21960200000000,3.23100900000000,3.24247600000000,3.25400200000000,3.26558700000000,3.27722900000000,3.28892900000000,3.30068600000000,3.31249800000000,3.32436600000000,3.33628700000000,3.34826300000000,3.36029100000000,3.37237100000000,3.38450200000000,3.39668300000000,3.40891300000000,3.42119200000000,3.43351900000000,3.44589300000000,3.45831400000000,3.47078000000000,3.48329100000000,3.49584600000000,3.50844500000000,3.52108700000000,3.53377200000000,3.54649900000000,3.55926800000000,3.57207800000000,3.58492900000000,3.59782000000000,3.61075200000000,3.62372400000000,3.63673500000000,3.64978700000000,3.66287700000000,3.67600800000000,3.68917700000000,3.70238600000000,3.71563400000000,3.72892100000000,3.74224800000000,3.75561400000000,3.76902000000000,3.78246600000000,3.79595100000000,3.80947700000000,3.82304300000000,3.83664900000000,3.85029600000000,3.86398500000000,3.87771400000000,3.89148500000000,3.90529800000000,3.91915200000000,3.93305000000000,3.94698900000000,3.96097200000000,3.97499700000000,3.98906600000000,4.00317800000000,4.01733400000000,4.03153400000000,4.04577700000000,4.06006500000000,4.07439800000000,4.08877400000000,4.10319500000000,4.11766000000000,4.13216900000000,4.14672200000000,4.16132000000000,4.17596100000000,4.19064600000000,4.20537400000000,4.22014600000000,4.23496000000000,4.24981500000000,4.26471300000000,4.27965200000000,4.29463200000000,4.30965100000000,4.32470900000000,4.33980600000000,4.35494000000000,4.37011000000000,4.38531500000000,4.40055500000000,4.41582800000000,4.43113300000000,4.44646800000000,4.46183300000000,4.47722400000000,4.49264200000000,4.50808500000000,4.52355100000000,4.53903700000000,4.55454200000000,4.57006500000000,4.58560300000000,4.60115500000000,4.61671700000000,4.63228900000000,4.64786700000000,4.66345000000000,4.67903500000000,4.69461900000000,4.71020000000000,4.72577600000000,4.74134400000000,4.75690100000000,4.77244500000000,4.78797200000000,4.80348100000000,4.81896800000000,4.83443000000000,4.84986400000000,4.86526700000000,4.88063700000000,4.89597000000000,4.91126400000000,4.92651500000000,4.94172000000000,4.95687600000000,4.97198000000000,4.98702900000000,5.00201900000000,5.01694800000000,5.03181300000000,5.04661000000000,5.06133700000000,5.07598900000000,5.09056500000000,5.10506100000000,5.11947400000000,5.13380100000000,5.14804000000000,5.16218700000000,5.17623900000000,5.19019400000000,5.20404800000000,5.21780000000000,5.23144600000000,5.24498300000000,5.25841000000000,5.27172300000000,5.28492000000000,5.29799900000000,5.31095700000000,5.32379200000000,5.33650300000000,5.34908500000000,5.36153900000000,5.37386100000000,5.38605000000000,5.39810400000000,5.41002100000000,5.42180000000000,5.43343900000000,5.44493600000000,5.45629000000000,5.46750000000000,5.47856400000000,5.48948200000000,5.50025200000000,5.51087300000000,5.52134400000000,5.53166500000000,5.54183500000000,5.55185300000000,5.56171800000000,5.57143000000000,5.58098900000000,5.59039400000000,5.59964600000000,5.60874300000000,5.61768600000000,5.62647400000000,5.63510900000000,5.64358900000000,5.65191700000000,5.66009000000000,5.66811000000000,5.67597800000000,5.68369300000000,5.69125700000000,5.69867000000000,5.70593300000000,5.71304600000000,5.72001000000000,5.72682600000000,5.73349600000000,5.74001900000000,5.74639800000000,5.75263300000000,5.75872600000000,5.76467700000000,5.77048700000000,5.77615900000000,5.78169300000000,5.78709100000000,5.79235400000000,5.79748300000000,5.80248000000000,5.80734700000000,5.81208500000000,5.81669600000000,5.82118000000000,5.82554100000000,5.82977900000000,5.83389500000000,5.83789300000000,5.84177300000000,5.84553700000000,5.84918700000000,5.85272500000000,5.85615300000000,5.85947100000000,5.86268200000000,5.86578800000000,5.86879100000000,5.87169200000000,5.87449300000000,5.87719700000000,5.87980400000000,5.88231700000000,5.88473700000000,5.88706700000000,5.88930700000000,5.89146100000000,5.89353000000000,5.89551600000000,5.89741900000000,5.89924400000000,5.90099000000000,5.90266000000000,5.90425600000000,5.90578000000000,5.90723300000000,5.90861700000000,5.90993400000000,5.91118500000000,5.91237300000000,5.91349800000000,5.91456400000000,5.91557100000000,5.91652200000000,5.91741700000000,5.91825900000000,5.91904900000000,5.91978900000000,5.92048000000000,5.92112500000000,5.92172400000000,5.92228000000000,5.92279300000000,5.92326600000000,5.92370000000000,5.92409600000000,5.92445700000000,5.92478200000000,5.92507500000000,5.92533500000000,5.92556600000000,5.92576800000000,5.92594200000000,5.92609100000000,5.92621500000000,5.92631500000000,5.92639300000000,5.92645100000000,5.92648900000000,5.92650800000000;];
Bi2Se3BulkImag = [3.24044800000000,3.24476400000000,3.24897800000000,3.25309800000000,3.25713600000000,3.26110200000000,3.26501000000000,3.26887200000000,3.27270300000000,3.27651600000000,3.28032700000000,3.28415000000000,3.28800200000000,3.29189500000000,3.29584700000000,3.29987000000000,3.30397800000000,3.30818500000000,3.31250300000000,3.31694300000000,3.32151600000000,3.32623100000000,3.33109600000000,3.33611900000000,3.34130500000000,3.34665900000000,3.35218500000000,3.35788400000000,3.36375800000000,3.36980700000000,3.37602900000000,3.38242200000000,3.38898300000000,3.39570600000000,3.40258700000000,3.40961900000000,3.41679500000000,3.42410800000000,3.43154700000000,3.43910400000000,3.44676800000000,3.45452900000000,3.46237600000000,3.47029600000000,3.47827800000000,3.48630900000000,3.49437600000000,3.50246600000000,3.51056700000000,3.51866500000000,3.52674600000000,3.53479800000000,3.54280600000000,3.55075900000000,3.55864400000000,3.56644800000000,3.57415900000000,3.58176600000000,3.58925900000000,3.59662700000000,3.60386000000000,3.61095200000000,3.61789300000000,3.62467800000000,3.63130200000000,3.63775900000000,3.64404700000000,3.65016400000000,3.65610900000000,3.66188300000000,3.66748700000000,3.67292400000000,3.67819800000000,3.68331400000000,3.68827800000000,3.69309700000000,3.69777900000000,3.70233200000000,3.70676600000000,3.71109000000000,3.71531400000000,3.71944800000000,3.72350300000000,3.72748900000000,3.73141600000000,3.73529400000000,3.73913400000000,3.74294400000000,3.74673300000000,3.75051000000000,3.75428200000000,3.75805700000000,3.76184000000000,3.76563900000000,3.76945700000000,3.77330000000000,3.77717100000000,3.78107200000000,3.78500800000000,3.78897800000000,3.79298500000000,3.79702900000000,3.80111100000000,3.80523000000000,3.80938500000000,3.81357500000000,3.81779800000000,3.82205400000000,3.82633900000000,3.83065300000000,3.83499100000000,3.83935200000000,3.84373200000000,3.84813000000000,3.85254100000000,3.85696300000000,3.86139400000000,3.86583000000000,3.87026700000000,3.87470400000000,3.87913700000000,3.88356400000000,3.88798100000000,3.89238600000000,3.89677600000000,3.90114900000000,3.90550200000000,3.90983300000000,3.91414000000000,3.91842100000000,3.92267300000000,3.92689500000000,3.93108400000000,3.93524000000000,3.93936000000000,3.94344300000000,3.94748700000000,3.95149200000000,3.95545500000000,3.95937600000000,3.96325400000000,3.96708700000000,3.97087500000000,3.97461700000000,3.97831200000000,3.98196000000000,3.98555900000000,3.98910900000000,3.99261000000000,3.99606100000000,3.99946200000000,4.00281200000000,4.00611100000000,4.00935700000000,4.01255300000000,4.01569600000000,4.01878700000000,4.02182500000000,4.02481000000000,4.02774200000000,4.03062100000000,4.03344600000000,4.03621700000000,4.03893400000000,4.04159700000000,4.04420500000000,4.04675900000000,4.04925700000000,4.05169900000000,4.05408600000000,4.05641700000000,4.05869100000000,4.06090800000000,4.06306800000000,4.06517000000000,4.06721400000000,4.06919800000000,4.07112400000000,4.07298900000000,4.07479300000000,4.07653600000000,4.07821700000000,4.07983500000000,4.08138900000000,4.08287900000000,4.08430200000000,4.08566000000000,4.08695000000000,4.08817100000000,4.08932300000000,4.09040400000000,4.09141300000000,4.09234800000000,4.09320900000000,4.09399500000000,4.09470300000000,4.09533200000000,4.09588100000000,4.09635000000000,4.09673500000000,4.09703500000000,4.09725000000000,4.09737700000000,4.09741400000000,4.09736100000000,4.09721500000000,4.09697400000000,4.09663700000000,4.09620300000000,4.09566800000000,4.09503300000000,4.09429400000000,4.09345000000000,4.09249900000000,4.09143900000000,4.09026900000000,4.08898600000000,4.08759000000000,4.08607800000000,4.08444800000000,4.08269900000000,4.08082800000000,4.07883500000000,4.07671700000000,4.07447300000000,4.07210100000000,4.06959900000000,4.06696700000000,4.06420200000000,4.06130300000000,4.05826900000000,4.05509700000000,4.05178800000000,4.04833900000000,4.04474900000000,4.04101800000000,4.03714400000000,4.03312600000000,4.02896400000000,4.02465500000000,4.02020000000000,4.01559800000000,4.01084900000000,4.00595000000000,4.00090400000000,3.99570700000000,3.99036100000000,3.98486600000000,3.97922000000000,3.97342500000000,3.96747900000000,3.96138400000000,3.95514000000000,3.94874600000000,3.94220400000000,3.93551300000000,3.92867500000000,3.92169000000000,3.91455800000000,3.90728200000000,3.89986100000000,3.89229800000000,3.88459200000000,3.87674500000000,3.86876000000000,3.86063600000000,3.85237700000000,3.84398200000000,3.83545500000000,3.82679600000000,3.81800800000000,3.80909200000000,3.80005100000000,3.79088700000000,3.78160200000000,3.77219800000000,3.76267700000000,3.75304200000000,3.74329500000000,3.73343900000000,3.72347600000000,3.71341000000000,3.70324100000000,3.69297400000000,3.68261100000000,3.67215400000000,3.66160800000000,3.65097300000000,3.64025400000000,3.62945300000000,3.61857300000000,3.60761700000000,3.59658900000000,3.58549000000000,3.57432500000000,3.56309600000000,3.55180700000000,3.54045900000000,3.52905700000000,3.51760300000000,3.50610100000000,3.49455300000000,3.48296300000000,3.47133400000000,3.45966700000000,3.44796800000000,3.43623800000000,3.42448000000000,3.41269800000000,3.40089500000000,3.38907200000000,3.37723400000000,3.36538200000000,3.35352100000000,3.34165200000000,3.32977700000000,3.31790200000000,3.30602600000000,3.29415400000000,3.28228700000000,3.27042900000000,3.25858100000000,3.24674700000000,3.23492900000000,3.22312800000000,3.21134800000000,3.19959000000000,3.18785700000000,3.17615200000000,3.16447400000000,3.15282900000000,3.14121600000000,3.12963900000000,3.11809800000000,3.10659700000000,3.09513600000000,3.08371800000000,3.07234500000000,3.06101700000000,3.04973600000000,3.03850500000000,3.02732400000000,3.01619500000000,3.00512000000000,2.99410000000000,2.98313500000000,2.97222900000000,2.96138100000000,2.95059300000000,2.93986500000000,2.92920000000000,2.91859800000000,2.90806000000000,2.89758700000000,2.88718000000000,2.87684000000000,2.86656700000000,2.85636200000000,2.84622700000000,2.83616100000000,2.82616600000000,2.81624100000000,2.80638800000000,2.79660700000000,2.78689900000000,2.77726300000000,2.76770100000000,2.75821300000000,2.74879800000000,2.73945800000000,2.73019200000000,2.72100200000000,2.71188600000000,2.70284500000000,2.69387900000000,2.68498900000000,2.67617400000000,2.66743500000000,2.65877100000000,2.65018200000000,2.64166800000000,2.63323000000000,2.62486600000000,2.61657800000000,2.60836500000000,2.60022500000000,2.59216000000000,2.58417000000000,2.57625300000000,2.56840900000000,2.56063800000000,2.55294100000000,2.54531600000000,2.53776200000000,2.53028000000000,2.52287000000000,2.51553000000000,2.50826000000000,2.50106000000000,2.49392900000000,2.48686600000000;];
Bi2Se3BulkC = complex(Bi2Se3BulkReal,Bi2Se3BulkImag);
SiReal = [5.52285800000000,5.55265900000000,5.58551900000000,5.62207500000000,5.66311300000000,5.70956900000000,5.76249500000000,5.82298200000000,5.89203500000000,5.97036800000000,6.05817900000000,6.15490900000000,6.25907100000000,6.36819800000000,6.47895300000000,6.58738600000000,6.68931000000000,6.78071400000000,6.85816600000000,6.91800900000000,6.95857300000000,6.98101700000000,6.98642500000000,6.97653100000000,6.95342800000000,6.91934200000000,6.87644600000000,6.82673500000000,6.77174200000000,6.71305900000000,6.65239400000000,6.59056900000000,6.52824000000000,6.46593000000000,6.40406200000000,6.34314600000000,6.28358400000000,6.22540700000000,6.16874600000000,6.11370200000000,6.06035500000000,6.00923200000000,5.96009600000000,5.91276300000000,5.86721200000000,5.82341400000000,5.78175900000000,5.74198400000000,5.70376300000000,5.66703000000000,5.63171600000000,5.59833000000000,5.56614600000000,5.53509200000000,5.50510400000000,5.47645900000000,5.44882500000000,5.42200400000000,5.39594700000000,5.37087900000000,5.34655700000000,5.32282000000000,5.29963900000000,5.27727800000000,5.25541400000000,5.23399200000000,5.21307600000000,5.19276800000000,5.17282200000000,5.15322600000000,5.13419000000000,5.11551400000000,5.09713500000000,5.07916700000000,5.06160400000000,5.04429800000000,5.02730500000000,5.01073200000000,4.99438300000000,4.97828700000000,4.96260500000000,4.94712100000000,4.93185600000000,4.91698300000000,4.90228500000000,4.88779700000000,4.87366000000000,4.85967900000000,4.84591900000000,4.83245900000000,4.81913900000000,4.80606500000000,4.79322900000000,4.78051800000000,4.76809100000000,4.75583000000000,4.74370000000000,4.73187000000000,4.72014400000000,4.70861100000000,4.69728900000000,4.68606000000000,4.67509500000000,4.66424400000000,4.65354200000000,4.64305400000000,4.63264300000000,4.62246900000000,4.61239900000000,4.60247000000000,4.59272700000000,4.58304600000000,4.57360800000000,4.56423400000000,4.55502400000000,4.54594500000000,4.53695700000000,4.52816200000000,4.51941100000000,4.51087000000000,4.50238500000000,4.49405100000000,4.48582300000000,4.47769300000000,4.46970900000000,4.46177600000000,4.45403000000000,4.44630800000000,4.43877000000000,4.43126900000000,4.42391600000000,4.41662900000000,4.40945600000000,4.40237300000000,4.39537500000000,4.38848700000000,4.38166000000000,4.37495900000000,4.36829900000000,4.36177700000000,4.35528000000000,4.34893000000000,4.34259100000000,4.33640600000000,4.33022300000000,4.32419500000000,4.31816300000000,4.31228600000000,4.30640300000000,4.30066900000000,4.29492800000000,4.28933200000000,4.28373100000000,4.27826700000000,4.27280100000000,4.26746500000000,4.26213100000000,4.25691500000000,4.25170900000000,4.24660800000000,4.24152700000000,4.23653500000000,4.23157600000000,4.22668900000000,4.22184800000000,4.21706100000000,4.21233400000000,4.20764300000000,4.20302700000000,4.19842700000000,4.19392100000000,4.18940900000000,4.18500600000000,4.18059900000000,4.17627600000000,4.17197200000000,4.16772600000000,4.16352100000000,4.15934700000000,4.15523900000000,4.15113400000000,4.14712000000000,4.14310100000000,4.13915800000000,4.13523000000000,4.13134800000000,4.12750900000000,4.12368500000000,4.11993200000000,4.11617500000000,4.11249400000000,4.10882100000000,4.10519100000000,4.10159900000000,4.09801700000000,4.09450600000000,4.09099100000000,4.08753500000000,4.08409800000000,4.08068500000000,4.07732400000000,4.07396100000000,4.07066500000000,4.06737700000000,4.06411800000000,4.06090100000000,4.05768100000000,4.05453100000000,4.05138200000000,4.04826400000000,4.04518300000000,4.04210000000000,4.03908100000000,4.03606500000000,4.03307200000000,4.03012300000000,4.02717100000000,4.02427000000000,4.02138100000000,4.01850300000000,4.01567700000000,4.01284800000000,4.01005500000000,4.00728800000000,4.00451800000000,4.00180400000000,3.99909400000000,3.99639800000000,3.99374600000000,3.99109300000000,3.98847100000000,3.98587400000000,3.98327600000000,3.98072400000000,3.97818100000000,3.97564100000000,3.97315200000000,3.97066100000000,3.96818700000000,3.96574900000000,3.96331000000000,3.96089800000000,3.95851100000000,3.95612200000000,3.95376900000000,3.95143000000000,3.94909000000000,3.94679400000000,3.94450400000000,3.94221200000000,3.93996900000000,3.93772600000000,3.93548600000000,3.93329000000000,3.93109300000000,3.92890100000000,3.92675100000000,3.92459900000000,3.92245400000000,3.92034900000000,3.91824200000000,3.91614100000000,3.91407900000000,3.91201500000000,3.90995700000000,3.90793700000000,3.90591600000000,3.90389800000000,3.90192000000000,3.89994000000000,3.89796000000000,3.89602300000000,3.89408400000000,3.89214400000000,3.89024200000000,3.88834400000000,3.88644400000000,3.88457500000000,3.88271600000000,3.88085600000000,3.87901800000000,3.87719700000000,3.87537500000000,3.87356700000000,3.87178400000000,3.87000000000000,3.86821900000000,3.86647300000000,3.86472600000000,3.86297800000000,3.86126100000000,3.85955000000000,3.85783900000000,3.85614600000000,3.85447000000000,3.85279400000000,3.85112400000000,3.84948300000000,3.84784200000000,3.84620000000000,3.84458500000000,3.84297800000000,3.84137000000000,3.83977500000000,3.83820100000000,3.83662700000000,3.83505200000000,3.83350800000000,3.83196600000000,3.83042400000000,3.82889500000000,3.82738600000000,3.82587600000000,3.82436600000000,3.82288400000000,3.82140600000000,3.81992700000000,3.81845800000000,3.81701000000000,3.81556200000000,3.81411400000000,3.81268800000000,3.81127000000000,3.80985200000000,3.80843700000000,3.80704900000000,3.80566100000000,3.80427200000000,3.80289500000000,3.80153600000000,3.80017700000000,3.79881700000000,3.79747700000000,3.79614600000000,3.79481500000000,3.79348400000000,3.79217900000000,3.79087600000000,3.78957200000000,3.78827200000000,3.78699700000000,3.78572100000000,3.78444500000000,3.78317600000000,3.78192700000000,3.78067800000000,3.77942800000000,3.77818900000000,3.77696600000000,3.77574300000000,3.77452000000000,3.77330800000000,3.77211200000000,3.77091500000000,3.76971700000000,3.76853200000000,3.76736000000000,3.76618800000000,3.76501600000000,3.76385500000000,3.76270800000000,3.76156100000000,3.76041400000000,3.75927500000000,3.75815200000000,3.75703000000000,3.75590600000000,3.75478900000000,3.75369000000000,3.75259200000000,3.75149300000000,3.75039600000000,3.74932100000000,3.74824500000000,3.74716900000000,3.74609300000000,3.74503700000000,3.74398500000000,3.74293200000000,3.74187900000000,3.74084000000000,3.73981000000000,3.73878000000000,3.73775000000000,3.73672600000000,3.73571800000000,3.73471000000000,3.73370200000000,3.73269400000000,3.73170600000000,3.73072000000000,3.72973300000000,3.72874700000000,3.72777100000000,3.72680600000000,3.72584200000000,3.72487600000000,3.72391100000000,3.72296700000000,3.72202300000000,3.72107900000000;];
SiImag = [2.94162400000000,2.94313900000000,2.94600000000000,2.95018100000000,2.95553000000000,2.96169600000000,2.96803000000000,2.97349500000000,2.97656700000000,2.97520700000000,2.96689400000000,2.94879000000000,2.91800900000000,2.87197400000000,2.80879300000000,2.72756500000000,2.62857300000000,2.51331200000000,2.38435300000000,2.24471200000000,2.09905700000000,1.95193600000000,1.80679200000000,1.66639100000000,1.53277500000000,1.40730100000000,1.29072300000000,1.18329700000000,1.08551200000000,0.997554000000000,0.917572000000000,0.844983000000000,0.779217000000000,0.719731000000000,0.666011000000000,0.618216000000000,0.575768000000000,0.537518000000000,0.503094000000000,0.472153000000000,0.444375000000000,0.420060000000000,0.398375000000000,0.378819000000000,0.361170000000000,0.345221000000000,0.331092000000000,0.318346000000000,0.306634000000000,0.295830000000000,0.285821000000000,0.276753000000000,0.268193000000000,0.260081000000000,0.252361000000000,0.245094000000000,0.238133000000000,0.231403000000000,0.224884000000000,0.218636000000000,0.212583000000000,0.206682000000000,0.200925000000000,0.195396000000000,0.190005000000000,0.184738000000000,0.179618000000000,0.174687000000000,0.169868000000000,0.165158000000000,0.160635000000000,0.156233000000000,0.151931000000000,0.147773000000000,0.143761000000000,0.139839000000000,0.136032000000000,0.132380000000000,0.128811000000000,0.125337000000000,0.122019000000000,0.118775000000000,0.115616000000000,0.112605000000000,0.109661000000000,0.106798000000000,0.104068000000000,0.101399000000000,0.0988130000000000,0.0963400000000000,0.0939210000000000,0.0915940000000000,0.0893560000000000,0.0871650000000000,0.0850780000000000,0.0830530000000000,0.0810750000000000,0.0792050000000000,0.0773720000000000,0.0756070000000000,0.0739160000000000,0.0722580000000000,0.0706890000000000,0.0691590000000000,0.0676790000000000,0.0662690000000000,0.0648840000000000,0.0635750000000000,0.0622980000000000,0.0610660000000000,0.0598910000000000,0.0587350000000000,0.0576500000000000,0.0565840000000000,0.0555660000000000,0.0545840000000000,0.0536290000000000,0.0527250000000000,0.0518330000000000,0.0509960000000000,0.0501740000000000,0.0493900000000000,0.0486320000000000,0.0478980000000000,0.0471980000000000,0.0465110000000000,0.0458650000000000,0.0452260000000000,0.0446260000000000,0.0440340000000000,0.0434720000000000,0.0429240000000000,0.0423990000000000,0.0418900000000000,0.0413980000000000,0.0409250000000000,0.0404640000000000,0.0400250000000000,0.0395920000000000,0.0391820000000000,0.0387760000000000,0.0383930000000000,0.0380110000000000,0.0376520000000000,0.0372930000000000,0.0369550000000000,0.0366170000000000,0.0362980000000000,0.0359790000000000,0.0356770000000000,0.0353750000000000,0.0350890000000000,0.0348020000000000,0.0345290000000000,0.0342570000000000,0.0339960000000000,0.0337360000000000,0.0334860000000000,0.0332380000000000,0.0329980000000000,0.0327590000000000,0.0325270000000000,0.0322980000000000,0.0320740000000000,0.0318520000000000,0.0316350000000000,0.0314210000000000,0.0312090000000000,0.0310010000000000,0.0307940000000000,0.0305930000000000,0.0303900000000000,0.0301940000000000,0.0299960000000000,0.0298030000000000,0.0296110000000000,0.0294210000000000,0.0292320000000000,0.0290450000000000,0.0288600000000000,0.0286750000000000,0.0284940000000000,0.0283120000000000,0.0281330000000000,0.0279550000000000,0.0277780000000000,0.0276020000000000,0.0274270000000000,0.0272540000000000,0.0270800000000000,0.0269090000000000,0.0267390000000000,0.0265690000000000,0.0264010000000000,0.0262330000000000,0.0260670000000000,0.0259010000000000,0.0257370000000000,0.0255730000000000,0.0254100000000000,0.0252480000000000,0.0250870000000000,0.0249270000000000,0.0247680000000000,0.0246090000000000,0.0244520000000000,0.0242950000000000,0.0241390000000000,0.0239840000000000,0.0238300000000000,0.0236770000000000,0.0235240000000000,0.0233730000000000,0.0232220000000000,0.0230720000000000,0.0229240000000000,0.0227750000000000,0.0226280000000000,0.0224810000000000,0.0223350000000000,0.0221910000000000,0.0220460000000000,0.0219030000000000,0.0217610000000000,0.0216180000000000,0.0214780000000000,0.0213380000000000,0.0211980000000000,0.0210600000000000,0.0209220000000000,0.0207850000000000,0.0206490000000000,0.0205130000000000,0.0203790000000000,0.0202450000000000,0.0201110000000000,0.0199800000000000,0.0198480000000000,0.0197170000000000,0.0195870000000000,0.0194580000000000,0.0193290000000000,0.0192010000000000,0.0190740000000000,0.0189480000000000,0.0188220000000000,0.0186960000000000,0.0185730000000000,0.0184490000000000,0.0183260000000000,0.0182040000000000,0.0180830000000000,0.0179620000000000,0.0178420000000000,0.0177230000000000,0.0176040000000000,0.0174870000000000,0.0173690000000000,0.0172520000000000,0.0171370000000000,0.0170220000000000,0.0169070000000000,0.0167930000000000,0.0166800000000000,0.0165670000000000,0.0164560000000000,0.0163450000000000,0.0162330000000000,0.0161240000000000,0.0160150000000000,0.0159050000000000,0.0157980000000000,0.0156910000000000,0.0155840000000000,0.0154780000000000,0.0153730000000000,0.0152670000000000,0.0151640000000000,0.0150600000000000,0.0149570000000000,0.0148550000000000,0.0147530000000000,0.0146520000000000,0.0145510000000000,0.0144510000000000,0.0143520000000000,0.0142520000000000,0.0141550000000000,0.0140570000000000,0.0139600000000000,0.0138640000000000,0.0137680000000000,0.0136720000000000,0.0135780000000000,0.0134840000000000,0.0133900000000000,0.0132960000000000,0.0132050000000000,0.0131130000000000,0.0130210000000000,0.0129300000000000,0.0128400000000000,0.0127500000000000,0.0126610000000000,0.0125720000000000,0.0124840000000000,0.0123960000000000,0.0123090000000000,0.0122230000000000,0.0121370000000000,0.0120510000000000,0.0119660000000000,0.0118820000000000,0.0117970000000000,0.0117140000000000,0.0116310000000000,0.0115490000000000,0.0114660000000000,0.0113850000000000,0.0113040000000000,0.0112230000000000,0.0111430000000000,0.0110640000000000,0.0109850000000000,0.0109060000000000,0.0108280000000000,0.0107510000000000,0.0106730000000000,0.0105960000000000,0.0105210000000000,0.0104450000000000,0.0103690000000000,0.0102940000000000,0.0102200000000000,0.0101460000000000,0.0100720000000000,0.0100000000000000,0.00992700000000000,0.00985500000000000,0.00978300000000000,0.00971200000000000,0.00964100000000000,0.00957000000000000,0.00950000000000000,0.00943100000000000,0.00936200000000000,0.00929300000000000,0.00922500000000000,0.00915700000000000,0.00909000000000000,0.00902200000000000,0.00895600000000000,0.00889000000000000,0.00882400000000000,0.00875800000000000,0.00869300000000000,0.00862900000000000,0.00856500000000000,0.00850100000000000,0.00843700000000000,0.00837400000000000,0.00831200000000000,0.00824900000000000,0.00818700000000000,0.00812600000000000,0.00806500000000000,0.00800400000000000,0.00794300000000000,0.00788400000000000,0.00782500000000000,0.00776500000000000,0.00770600000000000,0.00764800000000000,0.00759000000000000,0.00753200000000000,0.00747400000000000,0.00741700000000000,0.00736100000000000,0.00730400000000000,0.00724800000000000,0.00719200000000000,0.00713700000000000,0.00708300000000000,0.00702800000000000,0.00697300000000000,0.00692000000000000,0.00686600000000000,0.00681300000000000,0.00675900000000000,0.00670700000000000,0.00665500000000000,0.00660300000000000,0.00655100000000000,0.00650000000000000,0.00644900000000000,0.00639900000000000,0.00634800000000000,0.00629800000000000,0.00624900000000000,0.00619900000000000,0.00615000000000000;];
SiC = complex(SiReal,SiImag);

global wavelengths;
wavelengths = linspace(350e-9,750e-9,401);

% %Plot Polys and Points
% plotindices(AirReal,AirImag);
% plotindices(Bi2Se3BulkReal,Bi2Se3BulkImag);
% plotindices(SiReal,SiImag);
% hold off;

%Compute 2 layer r values (p polarized in Fujiwara, normal incidence)
%With Flake
rAir_Bi2Se3Bulk = gettwolayer(AirC, Bi2Se3BulkC);
rBi2Se3Bulk_Si = gettwolayer(Bi2Se3BulkC, SiC);
rAir_Si = gettwolayer(AirC, SiC);

%Input Thicknesses AND LOOP
Thicknesses = linspace(0,100e-9,101);
Thicknesses = Thicknesses';

%Compute beta values
bBi2Se3Bulk = getbetasthick(Bi2Se3BulkC,Thicknesses);



%_________________________SAMPLES WITH OXIDE_______________________________

%Compute r values
rAir_Bi2Se3Bulk_Si = getnextlayer(rAir_Bi2Se3Bulk, rBi2Se3Bulk_Si, bBi2Se3Bulk);

%Compute R values
RVals = getRvals(rAir_Bi2Se3Bulk_Si);
rAir_Si = ones(length(Thicknesses),1)*rAir_Si;
RBackground = getRvals(rAir_Si);

colormap(jet);
[C,h]=contourf([0,1],Thicknesses*10^9,Thicknesses*10^9*ones(1,2),401);
set(h,'edgecolor','none');


%Create colormaps based on the color of each thickness
cmap = flipud(colormap(jet(401)));
RValsColor = RVals*cmap;
RValsColor = RValsColor/max(max(RValsColor));
RBackgroundColor = RBackground*cmap;
RBackgroundColor = RBackgroundColor/max(max(RBackgroundColor));

figure;
colormap(RValsColor);
[C,h]=contourf([0,1],Thicknesses*10^9,Thicknesses*10^9*ones(1,2),401);
set(h,'edgecolor','none');

figure;
colormap(RBackgroundColor);
[C,h]=contourf([0,1],Thicknesses*10^9,Thicknesses*10^9*ones(1,2),401);
set(h,'edgecolor','none');


RBackgroundColor = RBackground*cmap;

RVals_Tot = RVals*ones(length(wavelengths),1);
RBackground_Tot = RBackground*ones(length(wavelengths),1);

TotIntMax = max(RVals_Tot,RBackground_Tot);



%Compute contrast R values
ContrastVals = getcontrast(RVals, RBackground);

%Limit contrast to 10
% LimitedContrastWithOxide = limitcontrast(ContrastWithOxide, 10);

%Make a plot of contrast values
%Create a mesh plot
mesh(wavelengths*10^9,Thicknesses*10^9,ContrastVals)
xlabel('Wavelength (nm)');
ylabel('Bulk Bi2Se3 Thickness (nm)');
zlabel('Relative Reflected Intensity Difference');
view(2);
colorbar;

a = 1;

end

function plotindices(nreal, nimag)
global wavelengths;
figure;
hold on
[AX, H1, H2] = plotyy(wavelengths*1e9, nreal, wavelengths*1e9, nimag);
set(get(AX(1),'Ylabel'),'String','N real');
set(get(AX(2),'Ylabel'),'String','N imag');
xlabel('Wavelength (nm)');
end

% function thinbetas = getbetasthin(nvals, thick)
% global wavelengths
% thinbetas = (2*pi*thick*nvals)./wavelengths;
% end

function rvals = gettwolayer(n1, n2)
rvals = (n2-n1)./(n2+n1);
end

function thickbetas = getbetasthick(nvals, thick)
global wavelengths
thickbetas = 2*pi*thick*nvals;
for i = 1:length(thick)
    thickbetas(i,:) = thickbetas(i,:)./wavelengths;
end
end


function rvals = getnextlayer(rlast,rnext,beta)
rvals = zeros(size(beta,1),size(beta,2));
for k = 1:size(rvals,1)
    rvals(k,:) = (rlast+rnext.*exp(2i*beta(k,:)))./(1+rlast.*rnext.*exp(2i*beta(k,:)));
end
end

function Rvals = getRvals(rvals)
Rvals = rvals.*conj(rvals);
end

function contrast = getcontrast(sample, background)
contrast = (sample-background)./background;
end

% %TEMPORARILY USING LOG INTENSITIES
% function limitedcontrast = limitcontrast(contrast, maxcontrast)
% 
% maxcontrast = 5;
% mincontrast = maxcontrast*-1;
% 
% limitedcontrast = contrast;
% [r,c] = find(contrast>maxcontrast);
% for i = 1:length(r)
%     limitedcontrast(r(i),c(i)) = maxcontrast;
% end
% 
% [r,c] = find(contrast<mincontrast);
% for i = 1:length(r)
%     limitedcontrast(r(i),c(i)) = mincontrast;
% end

% [r,c] = find(contrast<.5);
% for i = 1:length(r)
%     limitedcontrast(r(i),c(i)) = .5;
% end
% end


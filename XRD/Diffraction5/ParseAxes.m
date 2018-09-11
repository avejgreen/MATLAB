function [ScanAxis,LoopAxis] = ParseAxes(Headers)

%Use headers to find x and y axes, which are scan and loop axes
switch Headers{12,3}
    case 'Chi'
        ScanAxis = 1;
    case 'Phi'
        ScanAxis = 2;
    case 'X'
        ScanAxis = 3;
    case 'Y'
        ScanAxis = 4;
    case 'Z'
        ScanAxis = 5;
    case 'Omega'
        ScanAxis = 6;
    case '2Theta'
        ScanAxis = 7;
    case 'Omega-2Theta'
        ScanAxis = 8;
    case 'Omega_Rel'
        ScanAxis = 9;
end

switch Headers{10,3}
    case 'Chi'
        LoopAxis = 1;
    case 'Phi'
        LoopAxis = 2;
    case 'X'
        LoopAxis = 3;
    case 'Y'
        LoopAxis = 4;
    case 'Z'
        LoopAxis = 5;
    case 'Omega'
        LoopAxis = 6;
    case '2Theta'
        LoopAxis = 7;
    case 'Omega-2Theta'
        LoopAxis = 8;
    case 'Omega_Rel'
        LoopAxis = 9;
end

test = 1;

end
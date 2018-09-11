function [netdat,rho,curl,length]=...
    gennetbeta(bounds,rho,fphi1,fphi2,flfib,nseg,fr,ftheta,fthetak1,fthetak2,pk)

%{
    
    Generates periodic fibre network

    [netdat,rho,curl,length]=...
        gennetbeta(bounds,rho,fphi1,fphi2,flfib,nseg,fr,ftheta,pk)
    [netdat,rho]=gennetbeta(bounds,rho,fphi1,fphi2,flfib,nseg,fr,ftheta,pk)
    
    INPUT:
    bounds  - network boundingbox widths [Lx Ly Lz]
    rho     - network density (fibrelength/volume)
    nseg    - number of segments used per fibre
    pk      - probability of kink between segments
    
    Distribution inputs, for beta distribution [a b q] where
    a and b are lower resp. upper limits and r = q (symmetric)
    
    fphi1       - distribution of fibreorientation angle phi1
    fphi2       - distribution of fibreorientation angle phi2
    flfib       - distribution of fibre length
    fr          - distribution of segment radii
    ftheta      - distribution of segment orientation angle
    fthetak1    - distribution of kink angle 1
    fthetak2    - distribution of kink angle 2
    
    OUTPUT:
    netdat  - 3d matrix containing radius of curvature, centre point,
              alfa1, alfa2, u and v for all fibres dim: [nfib nseg 12]
    rho     - network density (fibrelength/volume)
    curl    - vector containing curl of all fibres
    length  - vector containing length of all fibres

    %}
    
    nfib=floor(rho*prod(bounds)/(flfib(1)/2));
    n=1;
    flseg=[flfib(1)/nseg flfib(2)/nseg (2*flfib(3)-nseg+1)/(2*nseg)];
    h=waitbar(0,'Generating Network. Please wait...');
    
    for fibnr=1:nfib
        waitbar(fibnr/nfib);
        
        for segnr=1:nseg
            R(segnr)=betarnd(fr(3),fr(3))*(fr(2)-fr(1))+fr(1);
            THETA(segnr)=betarnd(ftheta(3),ftheta(3))*(ftheta(2)-ftheta(1))+ftheta(1);
            lseg=betarnd(flseg(3),flseg(3))*(flseg(2)-flseg(1))+flseg(1);
            ALFA(segnr)=lseg/R(segnr);
            
            if rand<pk
                THETAK1(segnr)=betarnd(fthetak1(3),fthetak1(3))...
                    *(fthetak1(2)-fthetak1(1))+fthetak1(1);
                THETAK2(segnr)=betarnd(fthetak2(3),fthetak2(3))...
                    *(fthetak2(2)-fthetak2(1))+fthetak2(1);
            else
                THETAK1(segnr)=0;
                THETAK2(segnr)=0;
            end
        end
        
        if nargout==4
            [fibdat,curl(fibnr),length(fibnr)]=genfib3(nseg,R,THETA,ALFA,THETAK1,THETAK2);
        else
            [fibdat]=genfib3(nseg,R,THETA,ALFA,THETAK1,THETAK2);
        end
        
        mp=[rand*bounds(1) rand*bounds(2) rand*bounds(3)];
        phi1=betarnd(fphi1(3),fphi1(3))*(fphi1(2)-fphi1(1))+fphi1(1);
        phi2=betarnd(fphi2(3),fphi2(3))*(fphi2(2)-fphi2(1))+fphi2(1);
        fibdir=rot3daxl([0 1 0],phi1,[1 0 0]);
        fibdir=rot3daxl([0 0 1],phi2,fibdir);
        [fibdat]=place(fibdat,fibdir,mp);
        [fibdatmod]=modfib(fibdat,bounds);
        
        for i=1:size(fibdatmod,1)
            netdat(n,:,:)=fibdatmod(i,:,:);
            n=n+1;
        end
    end
    
    if nargout==4
        rho=sum(length)/prod(bounds);
    end
    close(h);
    
    
    
    
    
    
    
    
    
    
    
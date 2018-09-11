function [fibdat,outdir,ep,n,tec]=...
    genfibseg(sp,r,beta,theta,thetak1,thetak2,indir,tec,nprev)

%{

    Subroutine used in genfib3
    Generates one fibresegment
    
    [fibdat,outdir,ep,n,tec]=...
        genfibseg(sp,r,beta,theta,thetak1,thetak2,indir,tec,nprev)
    
    INPUT:
    sp      - startingpoint of fibre segment
    r       - radius of curvature
    alfa    - angle between starting and ending tangents
    theta   - rotationangle of fibresegment
    indir   - startingtangent
    
    
    OUTPUT:
    fibdat  - vector containing radius of curvature,
              centre point, alfa1, alfa2, u and v
    outdir  - endtangent
    ep      - endpoint
    n       - fibre segment normal vector
    tec     - vector pointing from endpoint to centrepoint

    %}
    
    alfa=pi-beta;
    b=r*beta;
    x=2*r*sin(beta/2);
    l=x/(2*sin(alfa/2));
    indir=rot3daxl(nprev,thetak1,indir);
    tsc=rot3daxl(nprev,thetak1,tec);
    indir=rot3daxl(tsc,thetak2,indir);
    tsc=rot3daxl(indir,theta,tsc);
    n=cross(indir,tsc);
    n=n/sqrt(sum(n*n'));
    outdir=rot3daxl(n,pi/2,indir);
    outdir=rot3daxl(n,pi/2-alfa,outdir);
    outdir=outdir/(sqrt(outdir*outdir'));
    cp=sp+l*indir;
    ep=cp+l*outdir;
    
    %BASE VECTORS IN THE FIBRE PLANE U V
    %if n is in the xy-plane
    if (n(3)<l/10000)
        u=[n(2) -n(1) 0];
        if (u(1)<0)
            u=-u;
        end
    else
        u=(1+(n(1)^2/n(3)^2))^-0.5*[1 0 -n(1)/n(3)];
    end
    
    u=u/sqrt(sum(u*u'));
    v=cross(n,u);
    v=v/sqrt(sum(v*v'));
    rv=cross(n,indir);
    c=sp+rv*r;
    tec=c-ep;
    tec=tec./sqrt(tec*tec');
    
    
    %ANGLES ALFA1, ALFA2
    ts=sp-c;
    ts=ts/sqrt(ts*ts');
    alfa1=acos(ts*u');
    
    if acos(ts*v')>pi/2
        alfa1=2*pi-alfa1;
    end
    
    alfa2=alfa1+beta;
    
    if (alfa1<0)
        alfa1=alfa1+2*pi;
    end
    
    if (alfa2>2*pi)
        alfa2=alfa2-2*pi;
    end
    
    fibdat=[r c alfa1 alfa2 u v];
    
    
    
    
    
    
    

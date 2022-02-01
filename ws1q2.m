xbeg = 0;
xend = 1;
ubeg = 0;
Numberofpoints = 100;
stepsize = (xend-xbeg)/Numberofpoints;
f = @(x) 1;
u = zeros(Numberofpoints+1,1);

gamma = stepsize/6 - 1/stepsize;
lambda = 2*stepsize/3 + 2/stepsize;

x = zeros(1,Numberofpoints+1);
matrixm = zeros(Numberofpoints);

    for i = 2: Numberofpoints+1
        x(i) = xbeg + (i-1)*stepsize;
    end


    for i = 2:Numberofpoints-1
    
       matrixm(i,i-1) = gamma;
       matrixm(i,i) =  lambda ;
       matrixm(i,i+1) =  gamma;
   
    end
    
    matrixm(1,1) = lambda;
    matrixm(1,2) = gamma;
    matrixm(Numberofpoints,Numberofpoints-1) = gamma;
    matrixm(Numberofpoints,Numberofpoints) = 0.5*lambda;
    
    fvec = zeros(Numberofpoints,1);
    
        for i = 1: Numberofpoints
            
            fvec(i) = stepsize*f(x(i+1));
            
        end
        
    uvals = inv(matrixm)*fvec;
    
    for i = 2:Numberofpoints+1
        
        u(i) = uvals(i-1);
        
    end
    
    sol = @(x) 1 - cosh(x) + tanh(1)*sinh(x);
    solvals = zeros(Numberofpoints+1,1);
    errors = zeros(Numberofpoints+1,1);

    for i = 1: Numberofpoints+1
        
        solvals(i) = sol(x(i));
        errors(i) = abs(solvals(i) - u(i));
    end
    
    figure
    plot(x,u,x,solvals)

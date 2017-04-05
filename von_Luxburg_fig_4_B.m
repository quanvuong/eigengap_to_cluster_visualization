
%stddev = [.1 .5 1]
%stddev = [.2 .5 1]
%stddev = [.25 .5 .75]
%stddev = [.25 .55 .8]
stddev = [.3 .58 .8]

figure(1),clf,hold off, hold on

for jj = 1:3
    s = stddev(jj);
    
    x = [];
    for j = 1:4
        mu = 2*j;
        x = [x;  mu + s*randn(200,1)];
    end
    
    y = rand(size(x)); [y,p1]=sort(y); x = x(p1);
    
    subplot(2,3,jj),       hist(x,200,'b')
    axis([0 10 0 15]),       hold on
    
    N = size(x,1)
    S = zeros(N); 
    
    sigma = 0.05;
    for i = 1:N
        for j = 1:N
            Sij = exp(-(x(i)-x(j))^2 / (2*sigma));
            if Sij > 1e-6, S(i,j)=Sij; end
        end
    end
    
    u = ones(N,1); d = S*u; D = diag(d);
    L = D - S;
    Ln = diag(1./sqrt(d)) * L * diag(1./sqrt(d));
    [Q,LAM]=eig(Ln);
    lam = diag(LAM); [lam,perm]=sort(lam); Q=Q(:,perm);
    
    subplot(2,3,jj+3),       plot(lam(1:12),'*')
    ax=axis;   axis([ax(1),ax(2),0,ax(4)]),   hold on
end






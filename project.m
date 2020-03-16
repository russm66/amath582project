% Matt Russell
% amath582 Project
% project.m
% 3/16/20

%% Preprocessing
run('project_csvread.m');

%% reduced-SVD
X = [kv1dc,kv2dc,kv3dc,kv4dc,kv5dc,kv6dc];

[u,s,v] = svd(X,'econ');

%% Gabor window

%% Plot
% Plot singular values
figure();
semilogy(diag(s),'ko','Linewidth',[1.5]);
axis([0 6 10^0 10^3])
title('Singular Values');

% Displacement of dominant modes
figure();
subplot(3,2,1), plot(tfft,u(:,1),'ko','Linewidth',[1.5])
subplot(3,2,2), plot(tfft,u(:,2),'ko','Linewidth',[1.5])
subplot(3,2,3), plot(tfft,u(:,3),'ko','Linewidth',[1.5])
subplot(3,2,4), plot(tfft,u(:,4),'ko','Linewidth',[1.5])
subplot(3,2,5), plot(tfft,u(:,5),'ko','Linewidth',[1.5])
subplot(3,2,6), plot(tfft,u(:,6),'ko','Linewidth',[1.5])
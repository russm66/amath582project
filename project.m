% Matt Russell
% amath582 Project
% project.m
% 3/16/20

%% Preprocessing
run('project_csvread.m');

%% reduced-SVD
Xdc = [kv1dc,kv2dc,kv3dc,kv4dc,kv5dc,kv6dc];
Xf = [kv1f,kv2f,kv3f,kv4f,kv5f,kv6f];

[udc,sdc,vdc] = svd(Xdc,'econ');
[uf,sf,vf] = svd(Xf,'econ');

%% Average all the signals to eliminate noise if it's zero-mean
kvave = (kv1f + kv2f + kv3f + kv4f + kv5f + kv6f)/6;
kvave = kvave(1:n);
kvavet = fft(kvave);

% then perform reduced-SVD
[uave,save,vave] = svd(kvave,'econ');

%% Gabor window (zero-mean, unit-variance Gaussian) and produce spectrogram
% of shot 170411019
sample = 100;
tslide = linspace(tfft(1),tfft(n),sample)';

kv4fspec = [];

for k=1:sample
    g = 1/sqrt(2*pi)*exp((-1/2)*(tfft - tslide(k)).^2);
    kv4fg = g.*kv4f;
    kv4fgt = fft(kv4fg);
    kv4fspec = [kv4fspec;abs(fftshift(kv4fgt'))];
end

%% Plot
% Averaged signal
% in time
figure();
subplot(2,1,1), plot(tfft,kvave,'k');
% in frequency
subplot(2,1,2), plot(ws,abs(fftshift(kvavet))/max(abs(kvavet)),'k');


% Singular values
% Unfiltered signal
figure();
semilogy(diag(sf),'ko','Linewidth',[1.5]);
axis([0 6 10^0 10^3]);
title('Singular Values of unfiltered signal');

% Highpass-filtered signal
figure();
semilogy(diag(sdc),'ko','Linewidth',[1.5]);
axis([0 6 10^0 10^3])
title('Singular Values of highpass-filtered signal');

% Run-averaged signal
% only one singular value because we only have one set of measurements
figure();
semilogy(diag(save),'ko','Linewidth',[1.5]);
axis([0 6 10^0 10^3]);
title('Singular Values of run-averaged signal <kV(t)>');

% Displacement of dominant modes
figure();
subplot(3,2,1), plot(tfft,udc(:,1)/max(abs(udc(:,1))),'k','Linewidth',[1.5])
title('highpass-filtered signal, m = 1');
subplot(3,2,2), plot(tfft,udc(:,2)/max(abs(udc(:,2))),'k','Linewidth',[1.5])
title('highpass-filtered signal, m = 2');
subplot(3,2,3), plot(tfft,udc(:,3)/max(abs(udc(:,3))),'k','Linewidth',[1.5])
title('highpass-filtered signal, m = 3');
subplot(3,2,4), plot(tfft,udc(:,4)/max(abs(udc(:,4))),'k','Linewidth',[1.5])
title('highpass-filtered signal, m = 4');
subplot(3,2,5), plot(tfft,udc(:,5)/max(abs(udc(:,5))),'k','Linewidth',[1.5])
title('highpass-filtered signal, m = 5');
subplot(3,2,6), plot(tfft,udc(:,6)/max(abs(udc(:,6))),'k','Linewidth',[1.5])
title('highpass-filtered signal, m = 6');

% Spectrogram
figure();
pcolor(kv4fspec.'), shading interp